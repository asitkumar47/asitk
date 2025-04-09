classdef VehicleModel < handle
    
    properties
        motorModel
        aeroModel
    end

    methods
        function obj = VehicleModel
            obj.motorModel = motorModel;
            obj.aeroModel = aeroModel;
        end

        function dxdt = computeDerivative(t, x, u)

        end

    end

    % construstor to build and return a VehicleModel instance
    methods (Static)
        function vehicleModel = make(params)
            % collect models to build vehicleModel
            motorModel = MotorModel(params.motor);
            aeroModel  = AeroModel(params.aero);

            % construct vehicleModel
            vehicleModel = VehicleModel(motorModel, aeroModel);
        end
    end

end