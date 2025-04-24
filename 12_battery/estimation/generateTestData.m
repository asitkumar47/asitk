clear, clc

% get parameters
param = getCellPackParamFcn("isShowPlot", false);

% create input for pulse test
test.cRateCell_nd   = 2;
test.numPulse_nd    = 10;
test.pulseTime_s    = param.cell.capacity_Ah * 3600 / test.cRateCell_nd / test.numPulse_nd;
test.restTime_s     = 500;

test.dt_s = 1;
test.time_s = (0: test.dt_s : test.numPulse_nd * (test.pulseTime_s + test.restTime_s))';

packPulseCurrent_A = test.cRateCell_nd * param.pack.nP_nd;
packCurrentProfile_A = [ones(1, test.pulseTime_s / test.dt_s) * packPulseCurrent_A, ...
    zeros(1, test.restTime_s / test.dt_s)]';
test.packCurrentDraw_A = [0; repmat(packCurrentProfile_A, test.numPulse_nd, 1)];
clear packPulseCurrent_A packCurrentProfile_A

%% perform pulse test
% IC
testData.ic.soc_nd = 1;
testData.ic.Vc1_V  = 0;
testData.ic.Vc2_V  = 0;

% initialization
testData.x(1, 1:3) = [1, 0, 0]; % soc_nd, Vc1_V, Vc2_V
testData.y(1, 1)  = interp1(param.cell.bkptsSoc_nd, param.cell.dataE0_V, testData.ic.soc_nd) * param.pack.nS_nd;
testData.x2(1:3, 1) = [1, 0, 0]';
testData.y2(1, 1) = testData.y(1, 1);

tic
% ECM model with integrator outputing states (x)
for iT = 2:length(test.time_s)
    [testData.x(iT, :), testData.y(iT, 1), debug(iT, :)] = ecmModelFcn(param, testData.x(iT - 1, :), test.packCurrentDraw_A(iT), test.dt_s);
end
toc

tic
% ECM ode model outputing state derivatives (dx)
for iT = 2:length(test.time_s)
    E0_V      = interp1(param.cell.bkptsSoc_nd, param.cell.dataE0_V,   max(testData.x2(1, iT-1), 0)) * param.pack.nS_nd;
    r0_Ohm    = interp1(param.cell.bkptsSoc_nd, param.cell.dataR0_Ohm, max(testData.x2(1, iT-1), 0)) * param.pack.nS_nd / param.pack.nP_nd;
    r1_Ohm    = interp1(param.cell.bkptsSoc_nd, param.cell.dataR1_Ohm, max(testData.x2(1, iT-1), 0)) * param.pack.nS_nd / param.pack.nP_nd;
    c1_F      = interp1(param.cell.bkptsSoc_nd, param.cell.dataC1_F,   max(testData.x2(1, iT-1), 0)) * param.pack.nP_nd / param.pack.nS_nd;
    r2_Ohm    = interp1(param.cell.bkptsSoc_nd, param.cell.dataR2_Ohm, max(testData.x2(1, iT-1), 0)) * param.pack.nS_nd / param.pack.nP_nd;
    c2_F      = interp1(param.cell.bkptsSoc_nd, param.cell.dataC2_F,   max(testData.x2(1, iT-1), 0)) * param.pack.nP_nd / param.pack.nS_nd;
    testData.x2(:, iT) = rk4StepperFcn(@(t, x, u) ecmOdeFcn(t, x, u, param.cell.capacity_Ah * param.pack.nP_nd, r1_Ohm, r2_Ohm, c1_F, c2_F), ...
        test.dt_s, test.time_s(iT), testData.x2(:, iT-1), test.packCurrentDraw_A(iT));
    testData.y2(:, iT) = E0_V - test.packCurrentDraw_A(iT) * r0_Ohm - testData.x2(2, iT) - testData.x2(3, iT);
end
toc


% simulate data recording (add noise)


%% plot simulated test data
figure(1); clf; pause(0.1);
subplot 211
plot(test.time_s, testData.y', test.time_s, testData.y2); grid on; grid minor; hold on
subplot 212
plot(test.time_s, testData.y' - testData.y2)
% plot(test.time_s(2:end, 1), debug(2:end, 1))
xlabel('Time (s)'); ylabel('V_{terminal} (V)')
