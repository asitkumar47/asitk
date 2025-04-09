classdef MotorHeatGenModel < handle

    properties
        qGenCoeff_nd % W/W
    end

    methods
        function obj = MotorHeatGenModel(params)
            obj.qGenCoeff_nd = params.qGenCoeff_nd;
        end

        function qGen_W = computeHeatGen(motorTorque, motorSpd_radps)
            qGen_W = obj.qGenCoeff_nd * motorTorque * motorSpd_radps;
        end
    end
end