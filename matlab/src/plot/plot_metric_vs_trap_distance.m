function plot_metric_vs_trap_distance(distances, metrics, outFile)
%PLOT_METRIC_VS_TRAP_DISTANCE Plot design metric versus trap distance.
figure('Color','w');
plot(distances*1e6, metrics, 'o-', 'LineWidth', 1.5);
xlabel('trap distance from junction [micrometer]');
ylabel('integrated junction exposure metric');
title('Trap-distance sweep');
grid on; box on;
if nargin >= 3 && ~isempty(outFile)
    exportgraphics(gcf, outFile, 'Resolution', 200);
end
end
