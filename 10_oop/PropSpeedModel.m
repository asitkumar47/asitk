classdef PropSpeedModel
    
    properties
        inertia_kgm2
        linearDamping_Nms
    end


    methods
        function obj = PropSpeedModel(params)
            obj.inertia_kgm2 = params.inertia_kgm2;
            obj.linearDamping_Nms = params.linearDamping_Nms;
        end

        function dxdt = computeDerivative(obj, ~, x, u)
            omega_radps    = x;
            motorTorque_Nm = u(1);
            aeroTorque_Nm  = u(2);
            dxdt = (motorTorque_Nm - aeroTorque_Nm - obj.linearDamping_Nms * omega_radps) / obj.inertia_kgm2;
        end
    end
end