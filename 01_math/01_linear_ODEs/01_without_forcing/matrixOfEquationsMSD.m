%% Description
% this is a simple mass-spring-damper system
% this is a second order linear ODE
% this is broken down to a set of first order ODEs
% and solved using expm (matrix exponential)
% Intent is to document how to use matlab commands
% Intent is not to derive equatios
% EOM: mxdd + cxd + kx = 0;  (d -> dot)
% some relevatn ratios:
%   sqrt(k/m)          = natural frequency ω
%   c / (2 * sqrt(mak)) = damping ratio ζ (1 = critically damped)
% EOM using the above variable -> xdd + 2ωζxd + ω^2x = 0


%% Code
clear, clc

% params
omega_radps = 1;    % ω natural frequency
zeta_nd     = .5;  % ζ damping ratio

% model
Amatrix = createMsdModel(omega_radps, zeta_nd);

% sim
time_s = (0 : 0.01 : 20)';
ic_mixed = [1; 0]; % position, velocity
state_mixed = (expmv(Amatrix, ic_mixed, time_s))';

% plot
figure(1); clf;
ax1 = subplot(2, 1, 1);
plot(time_s, state_mixed(:, 1)); grid on
ylabel('meter'); title('Position')
ax2 = subplot(2, 1, 2);
plot(time_s, state_mixed(:, 2)); grid on
title('Speed'); ylabel('m/s'); xlabel('Time (s)')
eig(Amatrix)
%% functions
% matrix model msd
function Amatrix = createMsdModel(omega_radps, zeta_nd)
Amatrix = [0                1;
           -omega_radps^2   -2*omega_radps*zeta_nd];
end


