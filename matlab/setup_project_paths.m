function setup_project_paths()
%SETUP_PROJECT_PATHS Add FEM_BallisticDiffusion_PINN MATLAB folders to path.
thisFile = mfilename('fullpath');
matlabDir = fileparts(thisFile);
projectRoot = fileparts(matlabDir);
addpath(genpath(fullfile(projectRoot, 'matlab')));
if ~exist(fullfile(projectRoot, 'outputs'), 'dir')
    mkdir(fullfile(projectRoot, 'outputs'));
end
fprintf('Added FEM_BallisticDiffusion_PINN paths. Project root: %s\n', projectRoot);
end
