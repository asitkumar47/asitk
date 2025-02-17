clear, clc, close all

% get params
param = getParamFcn;

%% find linear model
% find fixed points
fixedPoints.speed_radps = 120; % x0
fixedPoints.torque_Nm   = fixedPoints.speed_radps ^ 2 * ...
                          interp1(param.dQdOm2Lut.bkpts1Speed_radps, param.dQdOm2Lut.dataDQdOm2_Nms2, fixedPoints.speed_radps, 'linear', 'extrap'); % u0

% find linear model
linSys = findLinearModelFcn(fixedPoints, param);

%% compare nonlinear vs linear model around fixed point
% create input
chirpSignal = createChirpFcn("startFreq_Hz", 1, "endFreq_Hz", 10, "timeDuration_s", 20, ...
                             "magnitude_nd", fixedPoints.torque_Nm * .1, "ts_s", 0.001, ...
                             "offset_nd", fixedPoints.torque_Nm);
input.torque_Nm     = chirpSignal.signal;
simParam.dt_s       = chirpSignal.time_s(2) - chirpSignal.time_s(1);
simParam.time_s     = chirpSignal.time_s;

% simulate nonlinear model
simOutputReal.speed_radps(1, 1) = fixedPoints.speed_radps; % IC
for iT = 2:length(simParam.time_s)
    simInput.torque_Nm = input.torque_Nm(iT-1, 1);
    
    [speedNext_radps, debugStruct] = propellerModelFcn(param, simInput, simOutputReal.speed_radps(iT-1, 1), simParam.dt_s);
    simOutputReal.speed_radps(iT, 1) = speedNext_radps;
    simOutputReal.dQdOm2_Nms2(iT, 1) = debugStruct.dQdOm2_Nms2;
end

% simulate linear model
[simOutLin.speed_radps, simOutLin.time_s] = lsim(linSys, (input.torque_Nm - fixedPoints.torque_Nm), simParam.time_s, 0); % lsim(sys, u, t, x0)
simOutLin.speed_radps = simOutLin.speed_radps + fixedPoints.speed_radps;

% compare
figure(1); clf;
ax1 = subplot(2, 1, 1);
plot(simParam.time_s, simOutputReal.speed_radps, 'LineWidth', 1); grid on; hold on;
plot(simOutLin.time_s, simOutLin.speed_radps, '--', 'LineWidth', 1)
ylabel('rad/s'); title('Output speed'); legend('non-lin', 'linearized')
ax2 = subplot(2, 1, 2);
plot(simParam.time_s, input.torque_Nm, 'r'); grid on
ylabel('Nm'); xlabel('Time (s)'); title('Input torque')


