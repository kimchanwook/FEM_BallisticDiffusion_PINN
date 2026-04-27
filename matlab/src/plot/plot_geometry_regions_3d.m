function plot_geometry_regions_3d(geom, outFile)
%PLOT_GEOMETRY_REGIONS_3D Plot cuboid wireframes for geometry sanity check.
figure('Color','w'); hold on; axis equal; grid on; view(35,25);
for r = 1:numel(geom.regions)
    mn = geom.regions(r).min; mx = geom.regions(r).max;
    draw_box(mn, mx);
    c = (mn+mx)/2;
    text(c(1), c(2), c(3), strrep(geom.regions(r).name,'_','\_'), 'FontSize', 8);
end
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]');
title('Hard-coded planar transmon cuboid regions');
if nargin >= 2 && ~isempty(outFile)
    exportgraphics(gcf, outFile, 'Resolution', 200);
end
end

function draw_box(mn, mx)
X = [mn(1) mx(1) mx(1) mn(1) mn(1) mx(1) mx(1) mn(1)];
Y = [mn(2) mn(2) mx(2) mx(2) mn(2) mn(2) mx(2) mx(2)];
Z = [mn(3) mn(3) mn(3) mn(3) mx(3) mx(3) mx(3) mx(3)];
edges = [1 2;2 3;3 4;4 1;5 6;6 7;7 8;8 5;1 5;2 6;3 7;4 8];
for i = 1:size(edges,1)
    plot3(X(edges(i,:)), Y(edges(i,:)), Z(edges(i,:)), 'LineWidth', 1.0);
end
end
