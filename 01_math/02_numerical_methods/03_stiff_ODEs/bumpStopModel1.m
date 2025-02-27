%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is to model a moving mass that hits a bumpstop and reflects back
% This model will be augmented with a moving MSD later (complex example)
% The modeling technique is based on "bouncing ball model"
% Link - https://www.mathworks.com/help/simulink/slref/simulation-of-a-bouncing-ball.html
% Modeling technique -
%       resetable integrators with new IC which flipped and scaled down
%       e.g., mass moving at      v = 1 m/s hits a bump (zero-crossing)
%             mass moves at e.g., v = -0.8 m/s in the next instant
% EOMs
%  1. vd  = F / m
%  2. xd  = v
%
% Special treatment needed for chatter
% depending on the system, we can stop chatter by allowing a maximum number
% of zero-crossings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear, clc

% param
m_kg    = 1;
e_nd    = 0.6;     % coefficient of restitution
maxNumZeroCrossing = 5;

% ic
v0_mps  = 0;
x0_m    = 1;

% model
A = [0 1;
    0 0];
B = [0; 1/m_kg];

% input
force_N = -1;

% time-stepper (integrator)
dt_s = 0.01;
time_s  = (0 : dt_s : 10)';
x_mixed = [x0_m, v0_mps];
numZeroCrossings = 0;

for iT = 1 : length(time_s) - 1
    % detect chatter and stop
    if numZeroCrossings >= maxNumZeroCrossing
        x_mixed(iT + 1, :) = [0, 0];
    else
        if x_mixed(iT, 1) > 0
            x_mixed(iT + 1, :) = x_mixed(iT, :)' + dt_s * (A * x_mixed(iT, :)' + B * force_N);
        else
            % if the mass is at a negative position that is synonymous with
            % hitting the bumpstop. In that case, reverse the speed and
            % position and scale by the coefficient of restitution
            x_mixed(iT + 1, :) = -e_nd * x_mixed(iT, :);
            % x_mixed(iT + 1, :) = [0, -e_nd * x_mixed(iT, 2)];
        end
    end
    numZeroCrossings = numel(find(x_mixed(1:end-1, 1) .* x_mixed(2:end, 1) < 0)) / 2;
end

figure(1); clf; pause(0.05);
ax1 = subplot(2, 1, 1);
plot(time_s, x_mixed(:, 1)); grid on; title('Position (m)')
ax2 = subplot(2, 1, 2);
plot(time_s, x_mixed(:, 2)); grid on; title('Speed (m/s)')
linkaxes([ax1, ax2], 'x')

