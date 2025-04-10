classdef MotorModel < handle
%==========================================================================
    properties
        motorSpeedModel
        motorThermalModel
    end

%==========================================================================
    methods
        function obj = MotorModel(motorSpeedModel, motorThermalModel)
            obj.motorSpeedModel         = motorSpeedModel;
            obj.motorThermalModel       = motorThermalModel;
        end

%--------------------------------------------------------------------------
        % run ode model (motor speed, motor temperature)
        function dxdt = computeDerivative(obj, ~, ...
                        motorSpd_radps, motorTemp_degC, ...                 % x
                        motorTorque_Nm, aeroTorque_Nm, ambientTemp_degC)    % u

            dOmega_radps2 = obj.motorSpeedModel.computeDerivative( ...
                        motorSpd_radps, ...                                 % x
                        motorTorque_Nm, aeroTorque_Nm);                     % u

            dMotorTemp_degCps = obj.motorThermalModel.computeDerivative( ...
                        motorTemp_degC, ...                                 % x            
                        motorSpd_radps, motorTorque_Nm, ambientTemp_degC);  % u
            
            dxdt = [dOmega_radps2, dMotorTemp_degCps];
        end

    end
%==========================================================================
    methods (Static)
        function motorModel = make(param)
            % construst models in motorModel
            motorSpeedModel = MotorSpeedModel(param.prop);
            motorThermalModel = MotorThermalModel.make(param.thm);

            % construct motorModel
            motorModel = MotorModel(motorSpeedModel, motorThermalModel);
        end
    end
%==========================================================================
end

