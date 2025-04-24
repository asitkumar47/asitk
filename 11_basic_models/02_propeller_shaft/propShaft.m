%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The intent is to show the variation of behavior of a the speed of a shaft
% connected to a propeller as it's parameters vary - inertia, damping, aero
% damping and stiction

clear, clc

%% params
J_kgm2      = 1;
b_Nms       = 0.2;
dQdOm2_Nms2 = 0.03;
s_Nm        = 0; % the shaft won't move until 1 Nm torque is applied

clfFlag     = 1;

%% sim
% input
dt_s = 0.01;
time_s = 0:0.01:10;
ipTq_Nm = ones(1, length(time_s)) * 10;
ipTq_Nm(round(length(ipTq_Nm)/2): end) = 0;
x0 = 0;

u = @(t) interp1(time_s, ipTq_Nm, t);

% sim
options = odeset('RelTol', 1e-5, 'AbsTol', 1e-8, 'MaxStep', dt_s);
[t, x] = ode45(@(t, x) shaftModelFcn(t, x, u(t), J_kgm2, dQdOm2_Nms2, b_Nms, s_Nm, dt_s), ...
    time_s, x0, options);

% plot
plotFcn(t, x, ipTq_Nm, J_kgm2, dQdOm2_Nms2, b_Nms, s_Nm, dt_s, clfFlag); % t, x, u, params
 
%%
calcStiction([1e-4, 9.8e-6], [0, 0], J_kgm2, s_Nm, dt_s) % x, u, params, dt

%% plot and compare
function plotFcn(t, x, u, J, dQdOm2, b, s, dt, clfFlag)

legendName = compose("J = " + J + " | b = " + b + " | s = " + s + " | dQdOm2 = " + dQdOm2);

% recalc stiction to plot

for iT = 1:length(x) % find a way to remove this for-loop
    stiction_Nm(iT) = calcStiction(x(iT), u(iT), J, s, dt);
end

figure(1); if clfFlag, clf; end

ax1 = subplot(2, 1, 1);
plot(t, x, 'DisplayName', legendName); legend('-DynamicLegend'); grid on; hold on;
ylabel('rad/s'); title('Speed')

ax2 = subplot(2, 1, 2);
plot(t, stiction_Nm); grid on; hold on
ylabel('Nm'); xlabel('Time (s)'); title('Stiction')

set([ax1, ax2], 'FontSize', 16);
linkaxes([ax1, ax2], 'x');
end

%% shaft model
function dx = shaftModelFcn(t, x, ipTq_Nm, J_kgm2, dQdOm2_Nms2, b_Nms, s_Nm, dt_s)

    stiction_Nm = calcStiction(x, ipTq_Nm, J_kgm2, s_Nm, dt_s);
    dx = 1 / J_kgm2 * (ipTq_Nm - x*b_Nms - x^2 * dQdOm2_Nms2 - stiction_Nm);

end

%% calculate stiction
function stiction_Nm = calcStiction(x, ipTq_Nm, J_kgm2, s_Nm, dt_s)
    
    % when stationary stiction is related to applied torque
    if abs(x) < 1e-5
        % stiction is always opposite of applied torque
        % stiction is never more than the applied torque
        stiction_Nm = min(abs(ipTq_Nm), s_Nm) .* sign(ipTq_Nm);

    % when moving stiction is opposite to speed direction, at low speeds, y = mx (to prevent jitter)
    elseif abs(x) < J_kgm2 * dt_s
        stiction_Nm = x * s_Nm / (J_kgm2 * dt_s); 

    % at higher speeds stiction is opposite to speed direction
    else 
        stiction_Nm = s_Nm * sign(x);
    end

end