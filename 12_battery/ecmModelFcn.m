function [x, y, debug] = ecmModelFcn(p, xp, u, dt_s)
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
% 4. dx = d(soc) = -i/Q = -i/(Cap_Ah/3600)
% 5. Temperature equation to be added later
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. p    : param struct            (r, c, ocv LUTs)
% 2. xp   : previous state struct   (Vc1_V, Vc2_V, soc_nd)
% 3. u    : input struct            (i_A) discharge is positive
% 4. dt_s : time step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Outputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. x    : state struct  (Vc1_, Vc2_V, soc_nd)
% 2. y    : output struct (Vt_V)
% 3. debug: debug struct  (heatGen_W, ...)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Example usage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output = ecmModelFcn();

%%
% find params
debug.E0_V      = interp1(p.bkptsSoc_nd, p.dataOcv_V,  xp.soc_nd);
debug.r0_Ohm    = interp1(p.bkptsSoc_nd, p.dataR0_Ohm, xp.soc_nd);
debug.r1_Ohm    = interp1(p.bkptsSoc_nd, p.dataR1_Ohm, xp.soc_nd);
debug.c1_F      = interp1(p.bkptsSoc_nd, p.dataC1_Ohm, xp.soc_nd);

% find state (FE integration)
x.Vc1_V     = xp.Vc1_V  + dt_s * ( u.i_A / debug.c1_F - xp.Vc1_V / (debug.r1_Ohm * debug.c1_F) );
x.Vc2_V     = xp.Vc2_V  + dt_s * ( u.i_A / debug.c2_F - xp.Vc2_V / (debug.r2_Ohm * debug.c2_F) );
x.soc_nd    = xp.soc_nd + dt_s * ( -u.i_A / (p.capacity_Ah/3600) );

% find output
y.Vt_V      = debug.E0_V - x.Vc1_V - x.Vc2_V - u.i_A * debug.r0_Ohm;

% debug signals
debug.heatGen_W = (x.i_A^2 * debug.r0_Ohm) + (x.Vc1_V^2 / debug.r1_Ohm) + (x.Vc2_V^2 / debug.r2_Ohm);

end

