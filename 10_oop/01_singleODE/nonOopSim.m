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
% frequency and damping ratio:
% 
%     naturalFrequency_Hz = sqrt(k / m) / (2 * pi)
%     dampingRatio = c / (2 * sqrt(m * k))
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;

% System Parameters
mass_kg = 1;      % Mass (kg)
dampingCoeff_Nspm = 0.5;    % Damping Coefficient (Ns/m)
springConstant_Npm = 5;      % Spring Constant (N/m)

% Initial Conditions
initialDisplacement_m = 1;     % Initial Displacement (m)
initialVelocity_mps = 0;     % Initial Velocity (m/s)

% Time Span
timeSpan_nd = [0 10];

% Solve the ODE
[time_s, states_mixed_nd] = ode45(@(time_s, states_mixed_nd) ...
    massSpringDamper(time_s, states_mixed_nd, mass_kg, dampingCoeff_Nspm, ...
    springConstant_Npm), timeSpan_nd, [initialDisplacement_m; initialVelocity_mps]);

% Plot Results
figure;

subplot(2,2,[1,3]);
plot(states_mixed_nd(:,1), states_mixed_nd(:,2), 'k', 'LineWidth', 1);
xlabel('Displacement (m)');
ylabel('Velocity (m/s)');
title('Phase Plot');
grid on;

subplot(2,2,2);
plot(time_s, states_mixed_nd(:,1), 'b', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Displacement (m)');
title('Displacement');
grid on;

subplot(2,2,4);
plot(time_s, states_mixed_nd(:,2), 'r', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity');
grid on;

% Function for the ODE System
function dydt_nd = massSpringDamper(time_s, states_mixed_nd, mass_kg, ...
    dampingCoeff_Nspm, springConstant_Npm)
    dydt_nd = zeros(2,1);
    dydt_nd(1) = states_mixed_nd(2);
    dydt_nd(2) = (-dampingCoeff_Nspm*states_mixed_nd(2) - springConstant_Npm*states_mixed_nd(1)) ...
        / mass_kg;
end

% Function to calculate natural frequency and damping ratio
function [naturalFrequency_Hz, dampingRatio] = calculateSystemProperties(...
    mass_kg, dampingCoeff_Nspm, springConstant_Npm)
    naturalFrequency_Hz = sqrt(springConstant_Npm / mass_kg) / (2 * pi);
    dampingRatio = dampingCoeff_Nspm / (2 * sqrt(mass_kg * springConstant_Npm));
end
