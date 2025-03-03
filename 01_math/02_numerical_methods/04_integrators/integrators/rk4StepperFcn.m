function xkp1 = rk4StepperFcn(f, dt_s, t_s, x, u)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Runge-Kutta 4th order stepping function
% This function is to be wrapped in a for loop for every time step
% A vector of ICs, inputs can be use to multiple simultaneious simulations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f    -> function to be integrated (f = dx/dt)
% dt_s -> time step size
% t_s  -> present time
% x    -> present x row vector (state)
% u    -> present u row vector (input)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xkp1 -> x_{k+1} (next state row vector)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f1 = f(t_s,          x,                 u);
f2 = f(t_s + dt_s/2, x + f1 * (dt_s/2), u);
f3 = f(t_s + dt_s/2, x + f1 * (dt_s/2), u);
f4 = f(t_s + dt_s,   x + f1 *  dt_s,    u);

xkp1 = x + (dt_s/6) * (f1 + 2*f2 + 2*f3 + f4);

end