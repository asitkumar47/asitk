classdef MotorModel < handle
%==========================================================================
    properties
        propSpeedModel
        motorThermalModel
    end

%==========================================================================
    methods
        function obj = MotorModel(propSpeedModel, motorThermalModel)
            obj.propSpeedModel          = propSpeedModel;
            obj.motorThermalModel       = motorThermalModel;
        end

%--------------------------------------------------------------------------
        % run ode model (motor speed, motor temperature)
        function dxdt = computeDerivative(obj, ~, ...
                        motorSpd_radps, motorTemp_degC, ... % x
                        aeroTorque_Nm, ambientTemp_degC)    % u
            dOmega_radps2 = obj.propSpeedModel.computeDerivative( ...
                            motorSpd_radps, ...             % x
                            aeroTorque_Nm);                 % t

            dMotorTemp_degCps = obj.motorThermalModel.computeDerivative( ...
                                motorTemp_degC, ...         % x
                                ambientTemp_degC);          % u
            
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

