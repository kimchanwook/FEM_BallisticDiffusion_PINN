function test_module1_bd_1d_thin_film()
setup_project_paths();
params = struct('Nx',51,'dtStar',1e-3,'tFinalStar',0.02,'Kn',0.1,'outputTimesStar',0.02);
r = solve_bd_thin_film_1d(params);
assert(all(isfinite(r.theta(:))));
assert(all(r.theta(:) >= 0));
fprintf('test_module1_bd_1d_thin_film passed.\n');
end
