function test_trap_sweep_outputs()
setup_project_paths();
p = default_transmon_geometry_params();
p.trap.distanceFromJunction = 50e-6;
g = build_planar_transmon_geometry_3d(p);
assert(any(strcmp({g.regions.name}, 'normal_metal_qp_trap')));
fprintf('test_trap_sweep_outputs passed.\n');
end
