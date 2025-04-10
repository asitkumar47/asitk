classdef MotorHeatLossModel < handle
%==========================================================================
    properties
        convArea_m2
        htc_Wpm2
    end
%==========================================================================
    methods
        function obj = MotorHeatLossModel(param)
            obj.convArea_m2 = param.convArea_m2;
            obj.htc_Wpm2    = param.htc_Wpm2;
        end

        function qLoss_W = computeHeatLoss(obj, motorTemp_degC, ambientTemp_degC)
            qLoss_W = obj.htc_Wpm2 * obj.convArea_m2 * ...
                      (motorTemp_degC - ambientTemp_degC);
        end
    end
%==========================================================================
end