clear, clc

%% setup
% model param
m_kg = 1;
k_Npm = 2;
c_Nspm = 1;
F_N = 0;

% sim param
dt_s   = 0.1;
time_s = (0:dt_s:10);

% ic
xR = [1; -1];
xF = xR;
uM = 1 * ones(1, length(time_s));
uF = uM;

%% simulation
% manual rk4 stepper
tic
for iT = 2:length(time_s)
    xR(:, iT) = rk4StepperFcn(@(t, x, u)msdFcn(t, x , u, m_kg, c_Nspm, k_Npm), ...
                            dt_s, time_s(iT), xR(:, iT - 1), uM(1, iT));
end
toc

% built-in rk4 (ode45)
uB = @(t) interp1(time_s, uM, t);
tic
[tB, xB] = ode45(@(t, x) msdFcn(t, x, uB(t), m_kg, c_Nspm, k_Npm), ...
                 time_s, xR(:, 1));
toc

% manual Forward Euler
tic
for iT = 2:length(time_s)
    xF(:, iT) = feStepperFcn(@(t, x, u)msdFcn(t, x , u, m_kg, c_Nspm, k_Npm), ...
                            dt_s, time_s(iT), xF(:, iT - 1), uF(1, iT));
end
toc



%% plotting
figure(1); clf;
ax1 = subplot(2, 1, 1);
plot(time_s, xR); grid on, grid minor; hold on;
plot(tB, xB, 'linestyle', '--', 'LineWidth', 1.3);
plot(time_s, xF, 'LineStyle', ':', 'LineWidth', 2);
title('States')

ax2 = subplot(2, 1, 2);
plot(time_s, xR - xB'); grid on, grid minor; hold on;
plot(time_s, xF - xB')
legend('x1 - rk4Stepper', 'x2 - rk4Stepper', 'x1 - Forward Euler', 'x1 - Forward Euler');
title('Error wrt ode45'); xlabel('Time (s)')


%% comments
% - R, B, F in for x and u stand for manualRk4, built-in ode45, and manual
% Forward Euler integrator
%
% - since integration using ode45 happens over the specified time interval
% the forcing function u is defined as an inline function u(t)