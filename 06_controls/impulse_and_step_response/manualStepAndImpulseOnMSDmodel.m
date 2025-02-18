%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The objective of this code is to manually simulate the step and impulse
% responses and compare them to Matlab's step and impulse commands, thus
% gaining intuition about what is happening mathematically.
% 
% The model used is a linear mass-spring-damper system
%
% Step    - a constant unit input (value = 1) to the system 
%           x(t) = lsim(sys, unit u, for time t, from 0 IC)
% Impulse - a constant unit input (value = 1) 
%           x(t) = e^(At)B <- impulse of u => IC in the B direction
% Link - https://www.youtube.com/watch?v=tnsWsMwYbEU (Steve Brunton)
% Link - https://www.youtube.com/watch?v=2HMv7Lx86K0 (Steve Brunton)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A plot comparing the manual vs. Matlab commands step and impulse
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear, clc, close all
% params
k_Npm   = 1;
c_Nspm  = 1;
m_kg    = 1;

% model
A = [0            1;
    -k_Npm/m_kg  -c_Nspm/m_kg];
B = [0
    1/m_kg];
C = eye(2);
D = 0;
ltiMsdSys = ss(A, B, C, D);

% sim
    % step
[xStepMatlab, tStepMatlab] = step(ltiMsdSys); grid on, hold on
[xStepManual, tStepManual] = lsim(ltiMsdSys, ones(1, floor(tStepMatlab(end))/0.01+1), 0:0.01:floor(tStepMatlab(end)), [0, 0]);

    % impulse
[xImpulseMatlab, tImpulseMatlab]   = impulse(ltiMsdSys); grid on, hold on;
[xImpulseManual1, tImpulseManual1] = lsim(ltiMsdSys, zeros(1, floor(tImpulseMatlab(end))/0.01+1), 0:0.01:floor(tImpulseMatlab(end)), ltiMsdSys.B);
xImpulseManual2                    = expmv(A, B, tImpulseManual1)';

% plot
figure(1); clf;
set(gcf, 'Position', [50, 100, 1000, 600])

ax1 = subplot(2, 2, 1);
plot(tStepMatlab, xStepMatlab(:, 1)); grid on, hold on;
plot(tStepManual, xStepManual(:, 1), '--'); title('Step response')
ylabel('x1 (position m)')
ax3 = subplot(2, 2, 3);
plot(tStepMatlab, xStepMatlab(:, 1)); grid on, hold on;
plot(tStepManual, xStepManual(:, 1), '--')
ylabel('x2 (speed m/s)'); xlabel('Time (s)'); legend('Matlab', 'manual', 'Location', 'best')


ax2 = subplot(2, 2, 2);
plot(tImpulseMatlab, xImpulseMatlab(:, 1)), grid on, hold on
plot(tImpulseManual1, xImpulseManual1(:, 1), '--'); title('Impulse response')
plot(tImpulseManual1, xImpulseManual2(:, 1), ':');
ylabel('x1 (position m)')
ax4 = subplot(2, 2, 4);
plot(tImpulseMatlab, xImpulseMatlab(:, 2)), grid on, hold on
plot(tImpulseManual1, xImpulseManual1(:, 2), '--')
plot(tImpulseManual1, xImpulseManual2(:, 2), ':');
ylabel('x2 (speed m/s)'); xlabel('Time (s)'); legend('Matlab', 'manual1', 'manual2', 'Location', 'best')

linkaxes([ax1, ax2], 'x');

hline = findall(gcf, 'type', 'line');
set(hline, 'LineWidth', 1.5);

