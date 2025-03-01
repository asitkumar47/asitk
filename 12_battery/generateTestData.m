clear, clc

% get parameters
param = getCellPackParamFcn("isShowPlot", false);

% create input for pulse test
test.cRateCell_nd   = 5;
test.numPulse_nd    = 10;
test.pulseTime_s    = param.cell.capacity_Ah * 3600 / test.cRateCell_nd / test.numPulse_nd;
test.restTime_s     = 500;

test.dt_s = 1;

test.time_s = (0: test.dt_s : test.numPulse_nd * (test.pulseTime_s + test.restTime_s))';

packPulseCurrent_A = test.cRateCell_nd * param.pack.nP_nd;
packCurrentProfile_A = [ones(1, test.pulseTime_s / test.dt_s) * packPulseCurrent_A, ...
                        zeros(1, test.restTime_s / test.dt_s)]';
test.packCurrentDraw_A = [repmat(packCurrentProfile_A, test.numPulse_nd, 1); 1];
clear packPulseCurrent_A packCurrentProfile_A

% perform pulse test
for iT = 1:length(test.time_s)
    testData.
end


% simulate data recording (add noise)

% plot simulated test data
