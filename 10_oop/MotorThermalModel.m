classdef MotorThermalModel
    
    properties
        % heat gen params
        
        % heat loss params
    end
    
    methods
        function obj = MotorThermalModel(inputArg1,inputArg2)
            obj.qGen_W = inputArg1 + inputArg2;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.qGen_W + inputArg;
        end
    end
end

