function bc = apply_thermal_boundary_conditions(mesh, type)
%APPLY_THERMAL_BOUNDARY_CONDITIONS Placeholder boundary-condition helper.
% First build uses natural no-flux boundaries unless a Dirichlet node set is supplied.
if nargin < 2; type = 'natural_no_flux'; end
bc = struct('type', type, 'nodeIds', [], 'values', []);
end
