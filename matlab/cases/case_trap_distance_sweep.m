% case_trap_distance_sweep
% Lightweight scaffold showing which distances should be swept. For full runs,
% wrap main_module3_transmon_3d_fem logic into a callable function.
clear; clc;
setup_project_paths();
distances = [20, 50, 100, 200]*1e-6;
metrics = nan(size(distances));
fprintf('Trap-distance sweep scaffold. Distances [um]: ');
fprintf('%.1f ', distances*1e6);
fprintf('\nConvert main_module3_transmon_3d_fem into a function to automate this sweep.\n');
