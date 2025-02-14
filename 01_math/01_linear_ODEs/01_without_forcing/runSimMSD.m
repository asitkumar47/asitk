%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Overview
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this is the run script of a simple mass-spring-damper system
% ODEs are solved using expm (matrix exponential)
% Intent is to document how to use matlab commands
% Intent is not to derive equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Some math
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EOM: mxdd + cxd + kx = 0;  (d -> dot)
% some relevatn ratios:
%   sqrt(k/m)          = natural frequency ω
%   c / (2 * sqrt(mak)) = damping ratio ζ (1 = critically damped)
% EOM using the above variable -> xdd + 2ωζxd + ω^2x = 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Functions used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% msdUnforcedMatrixFcn.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Commands used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% expmv (big brother of expm
% quiver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Code
clear, clc

% params
omega_radps = .5;    % ω natural frequency
zeta_nd     = .3;  % ζ damping ratio

% model
Amatrix = msdUnforcedMatrixFcn(omega_radps, zeta_nd);

% sim
time_s = (0 : 0.01 : 50)';
ic_mixed = [-.75; .8];                                  % position, velocity
state_mixed = (expmv(Amatrix, ic_mixed, time_s))';  % expm(Amatrix .* time_s) * ic_mixed



% plot time series
figure(1); clf;
set(gcf, 'Position',  [100, 200, 1000, 400])
ax1 = subplot(2, 2, 2);
plot(time_s, state_mixed(:, 1)); grid on
ylabel('m'); title('Position')
ax2 = subplot(2, 2, 4);
plot(time_s, state_mixed(:, 2)); grid on
title('Speed'); ylabel('m/s'); xlabel('Time (s)')
linkaxes([ax1, ax2], 'x');


% plot ODE field (quiver)
ax3 = subplot(2, 2, [1, 3]);
meshGridLim = max(state_mixed, [], 'all') * 1.1;
[xGrid, yGrid] = meshgrid(-meshGridLim : 0.1 : meshGridLim, -meshGridLim : 0.1 : meshGridLim);
for iX = 1:size(xGrid, 1)
    for iY = 1:size(xGrid, 2)
        tempGrid = Amatrix * [xGrid(iX, iY), yGrid(iX, iY)]';
        dxGrid(iX, iY) = tempGrid(1);
        dyGrid(iX, iY) = tempGrid(2);
    end
end
quiver(xGrid, yGrid, dxGrid, dyGrid); grid on; hold on;

% plot states
plot(state_mixed(:, 1), state_mixed(:, 2), 'linewidth', 1.2);
ylabel('Speed (m/s)'); xlabel('Position (m)'); title('State-space plot')
line([0, 0], [min(state_mixed(:, 2)), max(state_mixed(:, 2))], 'linestyle', '--', 'color', 'k', 'linewidth', .8)
line([min(state_mixed(:, 1)), max(state_mixed(:, 1))], [0, 0], 'linestyle', '--', 'color', 'k', 'linewidth', .8)
axis square
axis tight


%% command explnation
% 1. expmv(A,b,t) calculates the product of a matrix exponential and a vector
% 2. quiver(X,Y,U,V) plots arrows with directional components U and V at the Cartesian coordinates specified by X and Y
%    U and V are gradients of the field (dx/dt)
%    cool plots - https://www.youtube.com/watch?v=c4lntPrjGnc


