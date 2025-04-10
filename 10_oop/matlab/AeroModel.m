classdef AeroModel < handle

    properties
        dQdOm2_Nms2
    end

    methods
        function obj = AeroModel(params)
            obj.dQdOm2_Nms2 = params.dQdOm2_Nms2;
        end

        function aeroTorque_Nm = computeAeroTorque(motorSpd_radps)
            aeroTorque_Nm = obj.dQdOm2_Nms2 * motorSpd_radps ^ 2;
        end
    end
end