classdef MotorThermalModel < handle
    
    properties
        convArea_m2
        htc_Wpm2pK
        m_kg
        cp_JpkgpK
        motorHeatGenModel
    end
    
    methods
        function obj = MotorThermalModel(params)
            obj.convArea_m2 = params.convArea_m2;
            obj.htc_Wpm2pK  = params.htc_Wpm2pK;
            obj.m_kg        = params.m_kg;
            obj.cp_JpkgpK   = params.cp_JpkgpK;
            obj.motorHeatGenModel = motorHeatHenModel;
        end
        
        function dxdt = computeDerivative(obj, ~, x, u)
            motorTemp_degC = x;
            ambientTemp_degC = u(1);
            motorTorque_Nm = u(2);
            propSpd_radps = u(3);

            qGen_W  = obj.motorHeatGenModel(motorTorque_Nm, propSpd_radps);
            qLoss_W = obj.htc_Wpm2pK * obj.convArea_m2 * (motorTemp_degC - ambientTemp_degC);
            
            dxdt = (qGen_W - qLoss_W) / (obj.m_kg * obj.cp_JpkgpK); % dMotorTemp/dt
        end
    end
end

