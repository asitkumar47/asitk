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
%   1. E0 - Vc1 - ir0 = Vt
%   2. d(Vc1) = i/c1 - Vc1/(r1c1)
%   3. d(soc) = -i/Q = -i/(Cap_Ah/3600)
%   4. Temperature equation to be added later
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%