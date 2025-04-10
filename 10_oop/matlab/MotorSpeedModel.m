classdef MotorSpeedModel < handle
%==========================================================================    
    properties
        inertia_kgm2
        linearDamping_Nms
    end
%==========================================================================
    % self-instantiation
    methods
        function obj = MotorSpeedModel(params)
            obj.inertia_kgm2 = params.inertia_kgm2;
            obj.linearDamping_Nms = params.linearDamping_Nms;
        end
%--------------------------------------------------------------------------
        % run ode model (motor (prop) speed)
        function dxdt = computeDerivative(obj, ~, ...
                        motorSpd_radps, ...             % x
                        motorTorque_Nm, aeroTorque_Nm)  % u
            dxdt = 1 / obj.inertia_kgm2 * ...
                   (motorTorque_Nm - aeroTorque_Nm - obj.linearDamping_Nms * motorSpd_radps);
        end

%==========================================================================
    end
end