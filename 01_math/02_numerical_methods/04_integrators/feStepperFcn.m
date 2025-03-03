function xkp1 = feStepperFcn(f, dt_s, t_s, x, u)
% xkp1 -> x_{k+1}
% x    -> present x
% t_s  -> present time
% f    -> function to be integrated (f = dx/dt)
% dt_s -> time step

xkp1 = x + dt_s * f(t_s, x, u);

end