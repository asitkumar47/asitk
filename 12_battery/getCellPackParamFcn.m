function param = getCellPackParamFcn(opts)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function returns the apparent real cell parameters
% These parameters can be used to generate fake pulse test data, which then
% would be estimated by the cell parameter estimation algorithms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Takes two inputs to find the number of cell is series and parallel
% 1. maxPackVolt_V  -> maximum OCV (@ 100% SOC)
% 2. packEnergy_kWh -> pack nominal energy (nominal voltage hardcoded)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Example usage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% param = getCellPackParamFcn();

arguments
    opts.maxPackVolt_V  (1, 1) double  = 400
    opts.packEnergy_kWh (1, 1) double  = 10
    opts.isShowPlot     (1, 1) logical = true
end




%% cell real params
% soc grid
bkptsSoc_nd = (0:0.01:1)';

% OCV
dataE0_V    = polyval([32.7399  -89.7849   91.7798  -43.6569   11.1174    1.9941], bkptsSoc_nd)';
dataR0_Ohm  = polyval([ 0.0222   -0.0377    0.0033    0.0198], bkptsSoc_nd)' * 3;
dataR1_Ohm  = polyval([-0.1115    0.3456   -0.4219    0.2518   -0.0635    0.0180], bkptsSoc_nd)' * 2;
dataC1_F    = 10 ./ dataR1_Ohm;
dataR2_Ohm  = polyval([-0.0023    0.0160   -0.0311    0.0177    0.0099], bkptsSoc_nd)';
dataC2_F    = 100 ./ dataR2_Ohm;

if opts.isShowPlot
    figure(2); clf;
    nexttile
    plot(bkptsSoc_nd, dataE0_V); grid on; title('OCV (V)')
    nexttile
    plot(bkptsSoc_nd, dataR0_Ohm); grid on; title('r0 (\Omega)')
    nexttile
    plot(bkptsSoc_nd, dataR1_Ohm); grid on; title('r1 (\Omega)')
    nexttile
    plot(bkptsSoc_nd, dataC1_F); grid on; title('c1 (F)')
    nexttile
    plot(bkptsSoc_nd, dataR2_Ohm); grid on; title('r2 (\Omega)')
    nexttile
    plot(bkptsSoc_nd, dataC2_F); grid on; title('c2 (F)')
    xlabel('SOC (nd)')
end


param.cell.bkptsSoc_nd = bkptsSoc_nd;
param.cell.dataE0_V = dataE0_V;
param.cell.dataR0_Ohm = dataR0_Ohm;
param.cell.dataR1_Ohm = dataR1_Ohm;
param.cell.dataR2_Ohm = dataR2_Ohm;
param.cell.dataC1_F = dataC1_F;
param.cell.dataC2_F = dataC2_F;
param.cell.capacity_Ah = 5;

param.pack.nS_nd = floor(opts.maxPackVolt_V / max(dataE0_V));
param.pack.nP_nd = ceil(opts.packEnergy_kWh * 1000 / ((param.cell.capacity_Ah) * param.pack.nS_nd * 3.5));

%%
% x = [0:0.1:0.9, 0.95, 1];
% y = [1.8, 1.4, 1.22, 1.3, 1.37, 1.45, 1.55, 1.65, 1.75, 1.8, 1.85, 1.85]/100;
% p = polyfit(x, y, 5)
% 
% bkptsSoc_nd = (0:0.01:1)';
% yp = polyval(p, bkptsSoc_nd);
% figure(4); clf; plot(x, y, bkptsSoc_nd, yp); grid on
