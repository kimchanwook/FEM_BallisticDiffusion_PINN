function plot_bd_1d_results(results, params, outFile)
%PLOT_BD_1D_RESULTS Plot Module 1 validation curves.
figure('Color','w'); hold on; box on;
for i = 1:numel(results)
    r = results{i};
    plot(r.eta, r.theta(:,end), 'DisplayName', sprintf('Kn = %.3g', r.Kn), 'LineWidth', 1.5);
end
xlabel('nondimensional coordinate, eta = x/L');
ylabel('normalized medium energy variable, theta_m');
title(sprintf('Ballistic-diffusive 1D validation at t* = %.2f', params.outputTimesStar(end)));
legend('Location','best');
grid on;
if nargin >= 3 && ~isempty(outFile)
    exportgraphics(gcf, outFile, 'Resolution', 200);
end
end
