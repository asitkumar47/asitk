clear, clc, close all

% hidden model
slope   = 5;
offset  = 30;

% simulated measurement data
x = 0 : 0.1: 10;
yActual   = slope * x + offset;
yMeasured = yActual + (0.5 - rand(1, length(x))) * (5 + 10*rand(1)); 

% plot
figure(1); clf;
scatter(x, yMeasured); hold on, grid on
plot(   x, yActual);
xlabel('x')
ylabel('y')
legend('measured data', 'underlying model')
title('1-d model data')