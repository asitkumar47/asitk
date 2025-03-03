function [x, y, debugArray] = ecmModelFcn(p, xp, u, dt_s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This contains the cannonical battery ECM model
% It is 1-RC model
% The model has varying parameters
% r0, r1, c1 vary with respect to soc (and temperature in the future)
% E0 varies with respect to soc only
% these parameters are modeled as non-linear analytical functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       System equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. y  = E0 - Vc1 - Vc2 - ir0 = Vt
% 2. dx = d(Vc1) = i/c1 - Vc1/(r1c1)
% 3. dx = d(Vc2) = i/c2 - Vc2/(r2c2)
% 4. dx = d(soc) = -i/Q = -i/(Cap_Ah*3600)
% 5. Temperature equation to be added later
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. p    : param struct           (r, c, ocv LUTs)
% 2. xp   : previous state array   (Vc1_V, Vc2_V, soc_nd)
% 3. u    : input array            (iPack_A) discharge is positive
% 4. dt_s : time step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Outputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. x    : state array  (Vc1_, Vc2_V, soc_nd)
% 2. y    : output array (Vt_V)
% 3. debug: debug array  (heatGen_W, ...)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Example usage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output = ecmModelFcn();

%%
% find params (pack level)
E0_V      = interp1(p.cell.bkptsSoc_nd, p.cell.dataE0_V,   max(xp(1), 0)) * p.pack.nS_nd;
r0_Ohm    = interp1(p.cell.bkptsSoc_nd, p.cell.dataR0_Ohm, max(xp(1), 0)) * p.pack.nS_nd / p.pack.nP_nd;
r1_Ohm    = interp1(p.cell.bkptsSoc_nd, p.cell.dataR1_Ohm, max(xp(1), 0)) * p.pack.nS_nd / p.pack.nP_nd;
c1_F      = interp1(p.cell.bkptsSoc_nd, p.cell.dataC1_F,   max(xp(1), 0)) * p.pack.nP_nd / p.pack.nS_nd;
r2_Ohm    = interp1(p.cell.bkptsSoc_nd, p.cell.dataR2_Ohm, max(xp(1), 0)) * p.pack.nS_nd / p.pack.nP_nd;
c2_F      = interp1(p.cell.bkptsSoc_nd, p.cell.dataC2_F,   max(xp(1), 0)) * p.pack.nP_nd / p.pack.nS_nd;

x = [0; 0; 0];
y = 0;

% find state (FE integration)
x(1)  = xp(1) + dt_s * ( -u(1) / (p.cell.capacity_Ah * p.pack.nP_nd * 3600) );
x(2)  = xp(2) + dt_s * ( u(1) / c1_F - xp(2) / (r1_Ohm * c1_F) );
x(3)  = xp(3) + dt_s * ( u(1) / c2_F - xp(3) / (r2_Ohm * c2_F) );

% find outputßƒ
y(1)      = E0_V - x(2) - x(3) - u(1) * r0_Ohm;

% debug signals
heatGen_W = (u^2 * r0_Ohm) + (x(2)^2 / r1_Ohm) + (x(3)^2 / r2_Ohm);

debugArray = [E0_V, r0_Ohm, r1_Ohm, r2_Ohm, c1_F, c2_F, heatGen_W];

end

