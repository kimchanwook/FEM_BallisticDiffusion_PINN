% main_module3_transmon_3d_fem
% Build baseline planar transmon geometry and solve a first 3D quasiparticle
% diffusion-reaction problem with trap removal.
clear; clc;
setup_project_paths();

geomParams = default_transmon_geometry_params();
geom = build_planar_transmon_geometry_3d(geomParams);
matDB = default_material_database();

% Structured tensor mesh. The top z layer represents the thin-film metal
% region effectively; it is not a literal nanometer-resolved junction mesh.
xNodes = linspace(-geomParams.substrate.length/2, geomParams.substrate.length/2, 45);
yNodes = linspace(-geomParams.substrate.width/2,  geomParams.substrate.width/2,  37);
zNodes = [-geomParams.substrate.thickness, -2.5e-4, -1.0e-4, -3.0e-5, 0, geomParams.film.thickness];
mesh = create_tensor_hex_mesh_3d(xNodes, yNodes, zNodes);
mesh = tag_material_regions_3d(mesh, geom, matDB);

% Build coefficient arrays for a linear quasiparticle diffusion-reaction model.
numElem = size(mesh.elements, 1);
D = zeros(numElem, 1);
gamma = geomParams.qp.backgroundRemovalRate * ones(numElem, 1);
source = zeros(numElem, 1);

for e = 1:numElem
    label = mesh.elementMaterialLabels{e};
    if contains(label, 'superconductor') || contains(label, 'junction')
        D(e) = geomParams.qp.superconductorDiffusivity;
    else
        D(e) = geomParams.qp.substrateEffectiveDiffusivity;
    end
    if contains(label, 'trap')
        gamma(e) = gamma(e) + geomParams.qp.trapRemovalRate;
    end
    if mesh.elementRegion.isJunction(e)
        source(e) = geomParams.qp.junctionSourceRate;
    end
end

[M, K, A, F] = assemble_scalar_diffusion_reaction_hex8(mesh, ones(numElem,1), D, gamma, source);

dt = 2.0e-8;
tFinal = 2.0e-6;
numSteps = ceil(tFinal/dt);
n = zeros(size(mesh.nodes,1), 1);
LHS = M + dt*(K + A);
metric = zeros(numSteps,1);
time = zeros(numSteps,1);

for it = 1:numSteps
    rhs = M*n + dt*F;
    n = LHS \ rhs;
    n(n < 0) = 0; % positivity cleanup for first linear test problem
    time(it) = it*dt;
    metric(it) = compute_junction_exposure_metric(mesh, n, dt);
end

outDir = fullfile(fileparts(fileparts(mfilename('fullpath'))), 'outputs');
if ~exist(fullfile(outDir,'data'), 'dir'); mkdir(fullfile(outDir,'data')); end
if ~exist(fullfile(outDir,'figures'), 'dir'); mkdir(fullfile(outDir,'figures')); end
save(fullfile(outDir, 'data', 'module3_baseline_transmon_qp.mat'), 'geomParams', 'geom', 'mesh', 'n', 'time', 'metric');
plot_geometry_regions_3d(geom, fullfile(outDir, 'figures', 'module3_geometry_regions.png'));
plot_qp_density_slice_3d(mesh, n, fullfile(outDir, 'figures', 'module3_qp_density_final.png'));
fprintf('Module 3 baseline finished. Integrated junction exposure: %.6e\n', sum(metric));
