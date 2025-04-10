classdef VehicleModel < handle
%==========================================================================
    properties
        motorModel
        aeroModel
    end
%==========================================================================
    methods
        function obj = VehicleModel(motorModel, aeroModel)
            obj.motorModel = motorModel;
            obj.aeroModel  = aeroModel;
        end

%--------------------------------------------------------------------------
        function dxdt = computeDerivative(obj, t, ...
                        motorSpd_radps, motorTemp_degC, ...     % x
                        motorTorque_Nm, ambientTemp_degC)       % u
            
            aeroTorque_Nm = obj.aeroModel.computeAeroTorque(motorSpd_radps);

            dxdt = obj.motorModel.computeDerivative(t, ...
                        motorSpd_radps, motorTemp_degC, ...                 % x
                        motorTorque_Nm, aeroTorque_Nm, ambientTemp_degC);   % u
            
            dxdt = dxdt(:);
        end
    end

%==========================================================================
    % construstor to build and return a VehicleModel instance
    methods (Static)
        function vehicleModel = make(param)
            % construct models in vehicleModel
            motorModel = MotorModel.make(param.motor);
            aeroModel  = AeroModel(param.aero);

            % construct vehicleModel
            vehicleModel = VehicleModel(motorModel, aeroModel);
        end
    end

%==========================================================================
end