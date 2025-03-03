function xkp1 = rk4StepperFcn(f, dt_s, t_s, x, u)
% xkp1 -> x_{k+1}
% x    -> present x
% t_s  -> present time
% f    -> function to be integrated (f = dx/dt)
% dt_s -> time step

f1 = f(t_s,          x,                 u);
f2 = f(t_s + dt_s/2, x + f1 * (dt_s/2), u);
f3 = f(t_s + dt_s/2, x + f1 * (dt_s/2), u);
f4 = f(t_s + dt_s,   x + f1 *  dt_s,    u);

xkp1 = x + (dt_s/6) * (f1 + 2*f2 + 2*f3 + f4);

end