clear, clc, close all

pathRoot        = fileparts(mfilename("fullpath"));
pathIntegrators = fullfile(pathRoot, "01_math", "02_numerical_methods", "04_integrators", "integrators");

addpath(genpath(pathIntegrators));
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
disp("Integraors added                   ")
disp(" 1. feStepperFcn.m  - Forward Euler")
disp(" 2. rk4StepperFcn.m - Runge-Kutta"  )
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")


