function [speedNext_radps, debugStruct] = propellerModelFcn(param, input, speed_radps, dt_s)

% forward euler integrator
% shaft-propeller model with aero damping, no linear damping, no stiction

inertia_kgm2 = param.inertia_kgm2;
dQdOm2_Nms2 = interp1(param.dQdOm2Lut.bkpts1Speed_radps, param.dQdOm2Lut.dataDQdOm2_Nms2, speed_radps, 'linear', 'extrap');
debugStruct.dQdOm2_Nms2 = dQdOm2_Nms2;

speedNext_radps = speed_radps + ((input.torque_Nm - dQdOm2_Nms2 * speed_radps^2)/inertia_kgm2) * dt_s;
end