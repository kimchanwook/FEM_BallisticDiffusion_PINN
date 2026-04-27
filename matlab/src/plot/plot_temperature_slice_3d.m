function plot_temperature_slice_3d(mesh, T, outFile)
%PLOT_TEMPERATURE_SLICE_3D Scatter plot of top-layer temperature field.
zTop = max(mesh.nodes(:,3));
tol = 1e-15 + 1e-6*abs(zTop);
ids = find(abs(mesh.nodes(:,3)-zTop) <= tol);
figure('Color','w');
scatter(mesh.nodes(ids,1), mesh.nodes(ids,2), 20, T(ids), 'filled');
axis equal; box on; colorbar; grid on;
xlabel('x [m]'); ylabel('y [m]');
title('Temperature on top film layer');
if nargin >= 3 && ~isempty(outFile)
    exportgraphics(gcf, outFile, 'Resolution', 200);
end
end
