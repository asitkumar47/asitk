function [simOutReal, simOutLin] = compareLinearModelFcn(ssSpeed_radps, ssTorqueVariation_pcnt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script output the time series of non-linear and linear sim for a
% chirp torque input signal increasing from 1 to 10 Hz
% It plots a sample time series and a RMSE contour if the inputs > (2x2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ssSpeed_radps:          speed(s) around which the model is linearized
% ssTorqueVariation_pcnt: torque variation(s) applied around the ss torque 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [simOutputReal, simOutLin] = compareLinearModelFcn(60:10:120, 4:2:20);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

arguments
    ssSpeed_radps           (:, 1) double = 100
    ssTorqueVariation_pcnt  (:, 1) double = 10
end

% instantiate
rmse_radps = zeros(length(ssSpeed_radps), length(ssTorqueVariation_pcnt));
% simOutLin  = rmse_radps;
% simOutReal = rmse_radps;  

% get params
param = getParamFcn;

for iS = 1:length(ssSpeed_radps)
    for iTv = 1:length(ssTorqueVariation_pcnt)
        %% find linear model
        % find fixed points
        fixedPoints.speed_radps = ssSpeed_radps(iS); % x0
        fixedPoints.torque_Nm   = fixedPoints.speed_radps ^ 2 * ...
            interp1(param.dQdOm2Lut.bkpts1Speed_radps, param.dQdOm2Lut.dataDQdOm2_Nms2, fixedPoints.speed_radps, 'linear', 'extrap'); % u0

        % find linear model
        linSys = findLinearModelFcn(fixedPoints, param);

        %% compare nonlinear vs linear model around fixed point
        % create input
        chirpSignal = createChirpFcn("startFreq_Hz", 1, "endFreq_Hz", 10, "timeDuration_s", 20, ...
            "magnitude_nd", fixedPoints.torque_Nm * ssTorqueVariation_pcnt(iTv)/100, "ts_s", 0.001, ...
            "offset_nd", fixedPoints.torque_Nm);
        input.torque_Nm     = chirpSignal.signal;
        simParam.dt_s       = chirpSignal.time_s(2) - chirpSignal.time_s(1);
        simParam.time_s     = chirpSignal.time_s;

        % simulate nonlinear model
        simOutReal(iS, iTv).speed_radps(1, 1) = fixedPoints.speed_radps; % IC
        for iT = 2:length(simParam.time_s)
            simInput.torque_Nm = input.torque_Nm(iT-1, 1);

            [speedNext_radps, debugStruct] = propellerModelFcn(param, simInput, simOutReal(iS, iTv).speed_radps(iT-1, 1), simParam.dt_s);
            simOutReal(iS, iTv).speed_radps(iT, 1) = speedNext_radps;
            simOutReal(iS, iTv).dQdOm2_Nms2(iT, 1) = debugStruct.dQdOm2_Nms2;
        end

        % simulate linear model
        [simOutLin(iS, iTv).speed_radps, simOutLin(iS, iTv).time_s] = lsim(linSys, (input.torque_Nm - fixedPoints.torque_Nm), simParam.time_s, 0); % lsim(sys, u, t, x0)
        simOutLin(iS, iTv).speed_radps = simOutLin(iS, iTv).speed_radps + fixedPoints.speed_radps;

        rmse_radps(iS, iTv) = rmse(simOutLin(iS, iTv).speed_radps, simOutReal(iS, iTv).speed_radps);
    end
end
%% post-process
% compare 1st set
figure(1); clf;

ax1 = subplot(2, 1, 1);
plot(simParam.time_s, simOutReal(1, 1).speed_radps, 'LineWidth', 1); grid on; hold on;
plot(simOutLin(1, 1).time_s, simOutLin(1, 1).speed_radps, '--', 'LineWidth', 1)
ylabel('rad/s'); legend('non-lin', 'linearized')
title(compose("Output speed (RMSE = %.2f)", rmse_radps(1, 1)))

ax2 = subplot(2, 1, 2);
plot(simParam.time_s, input.torque_Nm, 'r'); grid on
ylabel('Nm'); xlabel('Time (s)'); title('Input torque')
linkaxes([ax1, ax2], 'x');


% plot sensitivity to SS speed and torque variation at SS torque input
figure(2); 
if (length(ssSpeed_radps) > 1) & (length(ssTorqueVariation_pcnt) > 1)
    contourf(ssSpeed_radps, ssTorqueVariation_pcnt, rmse_radps', 'showtext', true);
    xlabel('Stead state speed (\omega_0) rad/s')
    ylabel('Torque variation around (T_{{aero}_0}) %')
    colorbar
    legend('RMSE (rad/s)')
    title('Accuracy sensitivity')
end


