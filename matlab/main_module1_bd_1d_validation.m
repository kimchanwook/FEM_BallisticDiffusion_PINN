% main_module1_bd_1d_validation
% Validate a dimensionless ballistic-diffusive thin-film solver.
clear; clc;
setup_project_paths();

params = struct();
params.Nx = 201;
params.tFinalStar = 4.0;
params.dtStar = 2.0e-4;
params.KnList = [0.01, 0.1, 1.0, 10.0];
params.outputTimesStar = [0.05, 0.2, 1.0, 4.0];

results = cell(numel(params.KnList), 1);
for i = 1:numel(params.KnList)
    params.Kn = params.KnList(i);
    results{i} = solve_bd_thin_film_1d(params);
end

outDir = fullfile(fileparts(fileparts(mfilename('fullpath'))), 'outputs', 'figures');
if ~exist(outDir, 'dir'); mkdir(outDir); end
plot_bd_1d_results(results, params, fullfile(outDir, 'module1_bd_1d_validation.png'));
fprintf('Module 1 validation finished. Figure written to %s\n', outDir);
