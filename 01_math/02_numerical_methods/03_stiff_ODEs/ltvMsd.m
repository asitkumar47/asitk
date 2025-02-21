%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LTV MSD -> linear-time-variant tw0-mass-spring-damper system

clear, clc, close all

% param
k1_Npm  = 1;
c1_Nspm = 1;
m1_kg   = 1;
k2_Npm  = 100;
c2_Nspm = 1;
m2_kg   = 1;

% model
ltiMsdSys = returnLtiMsdSys(k1_Npm, c1_Nspm, m1_kg, k2_Npm, c2_Nspm, m2_kg);
[V, D] = eig(ltiMsdSys.A);


% input
time_s       = (0 : min(abs(real(diag(D))), [], 'all')/20 : max(abs(real(D)), [], 'all') * 20)';
forceInput_N = 0 * sin(time_s); % lsim
uOde45 = @(t, x) sin(t)*0;
ic_mixed     = [-1; -1; 1; 1];

% sim
[xLsim,  tLsim]  = lsim(ltiMsdSys, forceInput_N, time_s, ic_mixed);
[tOde45, xOde45] = ode45(@(t, x) msdMdlForOde45Fcn(t, x, ...
    uOde45, k1_Npm, c1_Nspm, m1_kg, k2_Npm, c2_Nspm, m2_kg), ...
    time_s, ic_mixed');


% plot
figure(1); clf;
subplot 211
plot(tLsim, xLsim); grid on;
subplot 212
plot(tLsim, xLsim - xOde45); grid on;
ylim([-1 1])


% post-process
omega1_Hz = sqrt(k1_Npm/m1_kg) / (2*pi);
omega2_Hz = sqrt(k2_Npm/m2_kg) / (2*pi);

%% functions
function ltiMsdSys = returnLtiMsdSys(k1_Npm, c1_Nspm, m1_kg, k2_Npm, c2_Nspm, m2_kg)
A = [0            1              0            0;
    -k1_Npm/m1_kg -c1_Nspm/m1_kg k1_Npm/m1_kg c1_Nspm/m1_kg;
    0             0              0            1;
    k1_Npm/m2_kg  c1_Nspm/m2_kg  -(k1_Npm+k2_Npm)/m2_kg  -(c1_Nspm+c2_Nspm)/m2_kg];

B = [0; 1/m1_kg; 0; 0];

C = eye(4);

D = zeros(4, 1);

ltiMsdSys = ss(A, B, C, D);
end

function dxdt = msdMdlForOde45Fcn(t, x, u, k1_Npm, c1_Nspm, m1_kg, k2_Npm, c2_Nspm, m2_kg)
dxdt(1) = x(2);
dxdt(2) = u(t) - (k1_Npm*(x(1) - x(3))  + c1_Nspm*(x(2)-x(4))) / m1_kg;
dxdt(3) = x(4);
dxdt(4) = - (k2_Npm*x(3) + k1_Npm*(x(3)-x(1)) + c2_Nspm*x(4) + c1_Nspm*(x(4)-x(2)) ) / m2_kg;

dxdt = dxdt(:);
end

%% notes
% 1. We can't pass in a time series forcing function to ode45. Rather need
% to define the forcing function as a time dependent function handle 
% f = @(t) sint(t)*10 and ode45 will determine the value of f. Same comment
% if the forcing is a function of states -> f = @(t, x) sin(t)*10 + x(2)/10