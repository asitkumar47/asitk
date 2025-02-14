% runSim.m
clc; clear; close all;

% Create an instance of the MassSpringDamper class
system = MassSpringDamper(1, 0.5, 5);

% Solve and plot the system response
[time_s, states_mixed] = system.solveSystem(1, 0);
system.plotResults(time_s, states_mixed);