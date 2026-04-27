function test_geometry_region_tags()
setup_project_paths();
p = default_transmon_geometry_params();
g = build_planar_transmon_geometry_3d(p);
db = default_material_database();
mesh = create_tensor_hex_mesh_3d(linspace(-1.5e-3,1.5e-3,15), linspace(-1.5e-3,1.5e-3,15), [-p.substrate.thickness,0,p.film.thickness]);
mesh = tag_material_regions_3d(mesh,g,db);
assert(any(mesh.elementRegion.isJunction));
assert(any(mesh.elementRegion.isTrap));
fprintf('test_geometry_region_tags passed.\n');
end
