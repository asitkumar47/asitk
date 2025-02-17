%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LTV MSD -> linear-time-variant mass-spring-damper system

clear, clc, close all

ltiMsdSys = returnLtiMsdSys(1, 1, 1);
eig(ltiMsdSys)

figure(1); clf;
step(ltiMsdSys); grid on, hold on
[xs, ts] = lsim(ltiMsdSys, ones(1, 14/0.01+1), 0:0.01:14, [0, 0]);
plot(ts, xs(:, 2), '--')

figure(2); clf;
impulse(ltiMsdSys); grid on, hold on;
[xi, ti] = lsim(ltiMsdSys, zeros(1, 14/0.01+1), 0:0.01:14, ltiMsdSys.B);
plot(ti, xi(:, 2), '--')


function ltiMsdSys = returnLtiMsdSys(k_Npm, c_Nspm, m_kg)
A = [0            1;
    -k_Npm/m_kg  -c_Nspm/m_kg];
B = [0
    1/m_kg];
C = eye(2);
D = 0;
ltiMsdSys = ss(A, B, C, D);
end