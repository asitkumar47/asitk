classdef MotorHeatGenModel < handle
%==========================================================================
    properties
        motorEta_nd 
    end
%==========================================================================
    methods
        function obj = MotorHeatGenModel(param)
            obj.motorEta_nd = param.motorEta_nd;
        end

        function qGen_W = computeHeatGen(obj, motorSpd_radps, motorTorque_Nm)
            qGen_W = abs((1 - obj.motorEta_nd) * motorTorque_Nm * motorSpd_radps);
        end
    end
%==========================================================================
end