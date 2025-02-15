clear, clc, close all

% get params
param = getParamFcn;

%% find linear model
% find fixed points
fixedPoints.speed_radps = 100; % x0
fixedPoints.torque_Nm   = fixedPoints.speed_radps ^ 2 * interp1(param.dQdOm2Lut.bkpts1Speed_radps, param.dQdOm2Lut.dataDQdOm2_Nms2, fixedPoints.speed_radps, 'linear', 'extrap'); % u0

% find linear model
[Amatrix, Bmatrix] = findLinearModelFcn(fixedPoints, param);

%% compare nonlinear vs linear model around fixed point
% create input
chirpSignal = createChirpFcn("startFreq_Hz", 0.1, "endFreq_Hz", 2, "timeDuration_s", 20, "magnitude_nd", 10, "ts_s", 0.001, ...
                                 "offset_nd", fixedPoints.torque_Nm);
input.torque_Nm     = chirpSignal.signal;
simParam.dt_s       = chirpSignal.time_s(2) - chirpSignal.time_s(1);
simParam.time_s     = chirpSignal.time_s;

% simulate nonlinear model
simOutput.speed_radps(1, 1) = fixedPoints.speed_radps; % IC
for iT = 2:length(simParam.time_s)
    simInput.torque_Nm = input.torque_Nm(iT-1, 1);
    
    [speedNext_radps, debugStruct] = propellerModelFcn(param, simInput, simOutput.speed_radps(iT-1, 1), simParam.dt_s);
    simOutput.speed_radps(iT, 1) = speedNext_radps;
    simOutput.dQdOm2_Nms2(iT, 1) = debugStruct.dQdOm2_Nms2;
end

% simulate linear model

% compare
figure(1); clf;
ax1 = subplot(2, 1, 1);
plot(simParam.time_s, simOutput.speed_radps); grid on; hold on;
ylabel('Speed (rad/s)')
ax2 = subplot(2, 1, 2);
plot(simParam.time_s, input.torque_Nm, 'r'); grid on
ylabel('Torque (Nm)'); xlabel('Time (s)')


