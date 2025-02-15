clear, clc, close all

% get params
param = getParamFcn;

% create input
simParam.dt_s       = 0.01;
simParam.time_s     = (0 : simParam.dt_s : 20)';
input.torque_Nm     = 10 * ones(length(simParam.time_s), 1);
input.torque_Nm(ceil(length(simParam.time_s)/2):end, 1) = 0;

% simulate
simOutput.speed_radps(1, 1) = 0; % IC
for iT = 2:length(simParam.time_s)
    simInput.torque_Nm = input.torque_Nm(iT-1, 1);
    
    [speedNext_radps, debugStruct] = propellerModelFcn(param, simInput, simOutput.speed_radps(iT-1, 1), simParam.dt_s);
    simOutput.speed_radps(iT, 1) = speedNext_radps;
    simOutput.dQdOm2_Nms2(iT, 1) = debugStruct.dQdOm2_Nms2;
end

% plot
figure(1)
clf
yyaxis left
plot(simParam.time_s, simOutput.speed_radps * 30/pi)
grid on
xlabel('Time (s)')
ylabel('Speed output (rpm)')
yyaxis right
plot(simParam.time_s, input.torque_Nm)
ylim([min(input.torque_Nm) - 1, max(input.torque_Nm) + 1]);
grid on
ylabel('Torque input (Nm)')
title('Speed vs. torque')


