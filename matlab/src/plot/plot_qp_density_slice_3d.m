function plot_qp_density_slice_3d(mesh, n, outFile)
%PLOT_QP_DENSITY_SLICE_3D Scatter plot of top-layer nodal quasiparticle density.
zTop = max(mesh.nodes(:,3));
tol = 1e-15 + 1e-6*abs(zTop);
ids = find(abs(mesh.nodes(:,3)-zTop) <= tol);
figure('Color','w');
scatter(mesh.nodes(ids,1), mesh.nodes(ids,2), 20, n(ids), 'filled');
axis equal; box on; colorbar; grid on;
xlabel('x [m]'); ylabel('y [m]');
title('Final quasiparticle density on top film layer');
if nargin >= 3 && ~isempty(outFile)
    exportgraphics(gcf, outFile, 'Resolution', 200);
end
end
