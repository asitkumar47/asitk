clear, clc

% get parameters
param = getCellPackParamFcn("isShowPlot", true);

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


for iT = 2:length(test.time_s)
    [testData.x(iT, :), testData.y(iT, 1), debug(iT, :)] = ecmModelFcn(param, testData.x(iT - 1, :), test.packCurrentDraw_A(iT), test.dt_s);

end


% simulate data recording (add noise)

% plot simulated test data

%%
figure(1); clf; pause(0.1);
plot(test.time_s, testData.y'); grid on; grid minor; hold on
plot(test.time_s(2:end, 1), debug(2:end, 1))
xlabel('Time (s)'); ylabel('V_{terminal} (V)')
