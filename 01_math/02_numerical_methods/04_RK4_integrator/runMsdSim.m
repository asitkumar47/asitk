clear, clc

% model param
m_kg = 1;
k_Npm = 2;
c_Nspm = 1;
F_N = 0;

% sim param
dt_s   = .1;
time_s = (0:dt_s:10);

% ic
xM = [1; -1];
uM = 1 * ones(1, length(time_s));

% simulation
tic
for iT = 2:length(time_s)
    xM(:, iT) = rk4StepperFcn(@(t, x, u)msdFcn(t, x , u, m_kg, c_Nspm, k_Npm), ...
                            dt_s, time_s(iT), xM(:, iT - 1), uM(1, iT));
end
toc

% built-in 
uB = @(t) interp1(time_s, uM, t);
tic
[tB, xB] = ode45(@(t, x) msdFcn(t, x, uB(t), m_kg, c_Nspm, k_Npm), ...
                 time_s, xM(:, 1));
toc

% plotting
figure(1); clf;
ax1 = subplot(2, 1, 1);
plot(time_s, xM); grid on, grid minor; hold on;
plot(tB, xB, 'linestyle', '--', 'LineWidth', 1.3);

ax2 = subplot(2, 1, 2);
plot(time_s, xM - xB'); grid on, grid minor;


%% comments
% M, B in xM, xB, uM, uB stand for manual and built-in integrator
% since integration using ode45 happens over the specified time interval
% the forcing function u is defined as an inline function u(t)