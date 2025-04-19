%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The intent is to show the variation of behavior of a the speed of a shaft
% connected to a propeller as it's parameters vary - inertia, damping, aero
% damping and stiction

clear, clc

%% true params
J_kgm2      = 1;
b_Nms       = 0.1;
dQdOm2_Nms2 = 0.03;
s_Nm        = 0; % the shaft won't move until 1 Nm torque is applied


%% sim
% input
time_s = 0:0.01:10;
ipTq_Nm = ones(1, length(time_s)) * 10;
ipTq_Nm(length(ipTq_Nm)/2: end) = 0;
x0 = 0;

u = @(t) interp1(time_s, ipTq_Nm, t);

% sim
options = odeset('RelTol',1e-5,'AbsTol',1e-8);
[t, x] = ode45(@(t, x) shaftModelFcn(t, x, u(t), J_kgm2, dQdOm2_Nms2, b_Nms, s_Nm), ...
        time_s, x0, options);

% plot
plotFcn(t, x, J_kgm2, dQdOm2_Nms2, b_Nms, s_Nm, 0)

%% compare
function plotFcn(t, x, J, dQdOm2, b, s, clfFlag)

legendName = compose("J = " + J + " | b = " + b + " | s = " + s + " | dQdOm2 = " + dQdOm2);

figure(1); if clfFlag, clf; end
plot(t, x, 'DisplayName', legendName); 
legend('-DynamicLegend')
grid on; hold on;
set(gca, 'FontSize', 20);
end

%% shaft model
function dx = shaftModelFcn(t, x, ipTq_Nm, J_kgm2, dQdOm2_Nms2, b_Nms, s_Nm)

if sign(x) == 0 % when stationary stiction is related to applied torque
    % stiction is always opposite of applied torque
    % stiction is never more than the applied torque
    stiction_Nm = min(abs(ipTq_Nm), s_Nm) * sign(ipTq_Nm); 
elseif abs(x) < J_kgm2 * 0.01 
    stiction_Nm = x * s_Nm / (J_kgm2 * 0.01); % y = mx (stiction is low at low speeds to prevent jitter)
else % when moving stiction is related to speed direction
    stiction_Nm = s_Nm * sign(x);
end

disp([ipTq_Nm, stiction_Nm]);

dx = 1 / J_kgm2 * (ipTq_Nm - x*b_Nms - x^2*dQdOm2_Nms2 - stiction_Nm);

end