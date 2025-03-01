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
dataE0_V    = polyval([-1.748, 7.88, -10.5, 6.36, 1.988], bkptsSoc_nd)';
dataR0_Ohm  = polyval([0.0053, -0.0167, 0.0198, -0.01, 0.0034], bkptsSoc_nd)';
dataR1_Ohm  = polyval([0.0047, -0.0117, 0.0097, -0.0033, 0.002], bkptsSoc_nd)';
dataC1_F    = 10 ./ dataR1_Ohm;
dataR2_Ohm  = polyval([2, -.1, 1]/5000, bkptsSoc_nd)';
dataC2_F    = 100 ./ dataR2_Ohm;

if opts.isShowPlot
    figure(1); clf;
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
param.cell.dataC1_F = dataC1_F;
param.cell.capacity_Ah = 5;

param.pack.nS_nd = floor(opts.maxPackVolt_V / max(dataE0_V));
param.pack.nP_nd = ceil(opts.packEnergy_kWh * 1000 / ((param.cell.capacity_Ah) * param.pack.nS_nd * 3.5));


