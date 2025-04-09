classdef MotorModel
    
    properties
        propSpeedModel
        motorThermalModel
        motorEfficiencyModel
    end
    

    methods
        function obj = MotorModel(propSpeedModel, motorThermalModel, motorEfficiencyModel)
            obj.propSpeedModel          = propSpeedModel;
            obj.motorThermalModel       = motorThermalModel;
            obj.motorEfficiencyModel    = motorEfficiencyModel;
        end

        
        % ODE model (prop-speed and motor-temperature)
        function dxdt = computeDerivative(obj, t, x, u)
            xs = x(1); % prop speed
            us = u(1); % motor torque
            dOmega_radps2 = obj.propSpeedModel.computeDerivative(t, xs, us);

            xt = x(2); % motor temp
            ut = [u(1), x(1), u(2)]; % motor torque, motor speed, battery voltage
            dMotorTemp_degCps = obj.motorThermalModel.computeDerivative(t, xt, ut);
            dxdt = [dOmega_radps2, dMotorTemp_degCps];
        end


        % hvdc current model
        function motorDcCurrent_A = computeMotorCurrent(obj, ...
                        batteryVoltage_V, propSpeed_radps, motorTorque_Nm)
            % find efficiency
            motorEfficiency_nd = obj.motorEfficiencyModel.computeEfficieny( ... 
                        batteryVoltage_V, propSpeed_radps, motorTorque_Nm);
            
            % find dc current
            if propSpeed_radps * motorTorque_Nm >= 0
                motorDcCurrent_A = 1/motorEfficiency_nd * (propSpeed_radps * motorTorque_Nm / batteryVoltage_V);
            else
                motorDcCurrent_A = motorEfficiency_nd * (propSpeed_radps * motorTorque_Nm / batteryVoltage_V);
            end        
        end
    end
end

