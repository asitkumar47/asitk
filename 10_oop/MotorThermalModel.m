classdef MotorThermalModel < handle
%==========================================================================
    properties
        motorMass_kg
        motorCp_JpkgpK
        motorHeatGenModel
        motorHeatLossModel
    end

%==========================================================================
    % self-instantiation
    methods
        function obj = MotorThermalModel(param, motorHeatGenModel, motorHeatLossModel)
            obj.motorMass_kg        = param.motorMass_kg;
            obj.motorCp_JpkgpK      = param.motorCp_JpkgpK;
            obj.motorHeatGenModel   = motorHeatGenModel;
            obj.motorHeatLossModel  = motorHeatLossModel;
        end

%--------------------------------------------------------------------------
        % run ODE model (motor temperature)
        function dxdt = computeDerivative(obj, ~, ...
                        motorTemp_degC, ...
                        ambientTemp_degC, motorTorque_Nm, motorSpd_radps)
            
            qGen_W  = obj.motorHeatGenModel(motorTorque_Nm, motorSpd_radps);
            qLoss_W = obj.motorHeatLossModel(motorTemp_degC, ambientTemp_degC);
            
            dxdt = (qGen_W - qLoss_W) / (obj.motorMass_kg * obj.motorCp_JpkgpK);
        end
    end

%==========================================================================
    methods (Static)
        function motorThermalModel = make(param)
            % construct models in motorThermalModel
            motorHeatGenModel  = MotorHeatGenModel(param.qGen);
            motorHeatLossModel = MotorHeatLossModel(param.qLoss);

            % construct motorThermalModel
            motorThermalModel = MotorThermalModel(motorHeatGenModel, motorHeatLossModel);
        end

%==========================================================================
    end
end

