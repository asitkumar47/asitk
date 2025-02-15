function [Amatrix, Bmatrix] = findLinearModelFcn(fixedPoints, param)

% This function returns a linear propeller model (A, B matrices) about user-defined fixed-points
% This function needs inputs of i) fixed points, ii) model parameters

inertia_kgm2 = param.inertia_kgm2;
dQdOm2_Nms2 = interp1(param.dQdOm2Lut.bkpts1Speed_radps, param.dQdOm2Lut.dataDQdOm2_Nms2, fixedPoints.speed_radps, 'linear', 'extrap');

Amatrix = -2 * dQdOm2_Nms2 * fixedPoints.speed_radps / inertia_kgm2;
Bmatrix = 1 / inertia_kgm2;

end