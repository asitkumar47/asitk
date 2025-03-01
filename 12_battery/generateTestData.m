clear, clc

% get parameters
param = getCellPackParamFcn("isShowPlot", false);

% create input for pulse test
test.cRate_nd   = 5;
test.restTime_s = 500;
test.numPulse_nd = 10;
test.time_s = (0: 1 : param.cell.capacity_Ah * 3600 * param.pack.nP_nd / test.cRate_nd + ...
                         test.restTime_s * test.numPulse_nd)';

test.currentDraw_A = 0 * test.time_s;


% perform pulse test


% simulate data recording (add noise)