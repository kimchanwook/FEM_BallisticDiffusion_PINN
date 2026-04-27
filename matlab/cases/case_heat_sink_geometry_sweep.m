% case_heat_sink_geometry_sweep
% Future scaffold for backside heat-sink geometry sweeps.
clear; clc; setup_project_paths();
heatSinkSizes = [100, 300, 500]*1e-6;
disp(heatSinkSizes(:));
