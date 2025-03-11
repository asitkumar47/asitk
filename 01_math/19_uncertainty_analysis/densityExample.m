clear, clc

g_mps2      = 9.8;

% measured
weight_N    = 100;
height_m    = 30 * 1e-2;
diameter_m  = 7.4 * 1e-2;

measuredDesnsity_kgpm3 = (4 * weight_N) / (pi * diameter_m^2 * g_mps2 * height_m);

% measurement uncertainties
uWeight_N   = 1;
uHeight_m   = 0.1 * 1e-2;
uDiameter_m = 0.1 * 1e-2;

% run monte-carlo
n = 100000;
p = 10;
% normRandNumber = xmin + (xmax - xmin) * sum(rand(n, p), 2)/p
mWeight_N   = (weight_N - uWeight_N/2) + uWeight_N * sum(rand(n, p), 2)/p;
mHeight_m   = (height_m - uHeight_m/2) + uHeight_m * sum(rand(n, p), 2)/p;
mDiameter_m = (diameter_m - uDiameter_m/2) + uDiameter_m * sum(rand(n, p), 2)/p;

figure(1); clf; nexttile
histogram(mWeight_N, 20, 'FaceAlpha', 0.3, 'EdgeAlpha', 0); grid on; title('weight (N)'); nexttile; 
histogram(mHeight_m * 100, 20, 'FaceAlpha', 0.3, 'EdgeAlpha', 0); grid on; title('height (cm)'); nexttile; 
histogram(mDiameter_m * 100, 20, 'FaceAlpha', 0.3, 'EdgeAlpha', 0); title('diameter (cm)'); grid on

monteCarloDesnsity_kgpm3 = (4 * mWeight_N) ./ (pi * mDiameter_m.^2 * g_mps2 .* mHeight_m);
nexttile
histogram(monteCarloDesnsity_kgpm3, 20, 'FaceAlpha', 0.6, 'EdgeAlpha', 0); grid on; title('density (kg/m^3)'); hold on;
plot(measuredDesnsity_kgpm3, 0, 'Marker','d', 'MarkerSize', 10, 'MarkerFaceColor', 'r')
legend('desnsity distribution', 'measured density')

disp(compose("Measured density = %.0f kg/m3", measuredDesnsity_kgpm3))
disp(compose("Density = %.0f +/- %.0f kg/m3", mean(monteCarloDesnsity_kgpm3), ...
                                              2*std(monteCarloDesnsity_kgpm3)));
