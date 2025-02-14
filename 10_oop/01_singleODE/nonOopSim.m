%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mass-Spring-Damper System Simulation
% 
% This MATLAB script models a simple linear mass-spring-damper system. 
% The system is governed by the second-order differential equation:
% 
%     m * x''(t) + c * x'(t) + k * x(t) = 0
% 
% where:
%     m = mass (kg)
%     c = damping coefficient (Ns/m)
%     k = spring constant (N/m)
%     x(t) = displacement as a function of time (m)
%     x'(t) = velocity (m/s)
%     x''(t) = acceleration (m/s^2)
%
% The equation is converted into a system of first-order ODEs:
% 
%     x1' = x2
%     x2' = (-c * x2 - k * x1) / m
% 
% where x1 represents displacement and x2 represents velocity.
% 
% The script numerically solves these equations using MATLAB's ODE solver 
% (ode45) and plots the displacement, velocity, and phase plot response.
%
% Additionally, a function is provided to compute the system's natural 
% frequency, damping ratio, and time constant:
% 
%     naturalFrequency_Hz = sqrt(k / m) / (2 * pi)
%     dampingRatio_nd = c / (2 * sqrt(m * k))
%     timeConstant_s = 1 / (dampingRatio_nd * (2 * pi * naturalFrequency_Hz))
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;

% Initialize
% System Parameters
mass_kg = 1;      % Mass (kg)
dampingCoeff_Nspm = 0.5;    % Damping Coefficient (Ns/m)
springConstant_Npm = .8;      % Spring Constant (N/m)

% Compute system properties
[naturalFrequency_Hz, dampingRatio_nd, timeConstant_s] = calculateSystemProperties(mass_kg, dampingCoeff_Nspm, springConstant_Npm);

% Display results
fprintf('Natural Frequency (Hz) = sqrt(k/m) / (2*pi) = %.2f Hz\n', naturalFrequency_Hz);
fprintf('Damping Ratio (dimensionless) = c / (2 * sqrt(m * k)) = %.2f\n', dampingRatio_nd);
fprintf('Time Constant (s) = 1 / (dampingRatio * (2*pi*naturalFrequency)) = %.4f s\n', timeConstant_s);

% Simulate
% Initial Conditions
initialDisplacement_m = 1;     % Initial Displacement (m)
initialVelocity_mps = 0;     % Initial Velocity (m/s)

% Time Span
timeSpan_nd = [0 5 * timeConstant_s];

% Solve the ODE
[time_s, states_mixed] = ode45(@(time_s, states_mixed) ...
    massSpringDamper(time_s, states_mixed, mass_kg, dampingCoeff_Nspm, ...
    springConstant_Npm), timeSpan_nd, [initialDisplacement_m; initialVelocity_mps]);

% Plot Results
figure('Position', [100, 100, 1200, 600]);

subplot(2,2,[1,3]);
plot(states_mixed(:,1), states_mixed(:,2), 'k', 'LineWidth', 1);
xlabel('Displacement (m)');
ylabel('Velocity (m/s)');
title(sprintf('Phase Plot\n\x03B6 = %.2f (dimensionless), \x03C9_n = %.2f Hz', dampingRatio_nd, naturalFrequency_Hz));
grid on;
axis equal;

subplot(2,2,2);
plot(time_s, states_mixed(:,1), 'b', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Displacement (m)');
title('Displacement');
grid on;

subplot(2,2,4);
plot(time_s, states_mixed(:,2), 'r', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity');
grid on;
linkaxes([gca, gca], 'x');

% Function for the ODE System
function dydt_nd = massSpringDamper(~, states_mixed, mass_kg, ...
    dampingCoeff_Nspm, springConstant_Npm)
    dydt_nd = zeros(2,1);
    dydt_nd(1) = states_mixed(2);
    dydt_nd(2) = (-dampingCoeff_Nspm*states_mixed(2) - springConstant_Npm*states_mixed(1)) ...
        / mass_kg;
end

% Function to calculate natural frequency, damping ratio, and time constant
function [naturalFrequency_Hz, dampingRatio_nd, timeConstant_s] = calculateSystemProperties(...
    mass_kg, dampingCoeff_Nspm, springConstant_Npm)
    naturalFrequency_Hz = sqrt(springConstant_Npm / mass_kg) / (2 * pi);
    dampingRatio_nd = dampingCoeff_Nspm / (2 * sqrt(mass_kg * springConstant_Npm));
    omega_radps = 2 * pi * naturalFrequency_Hz;
    timeConstant_s = 1 / (dampingRatio_nd * omega_radps);
end
