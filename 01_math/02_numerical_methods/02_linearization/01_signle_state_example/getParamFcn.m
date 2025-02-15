function param = getParamFcn(opts)

arguments
    opts.isShowPlot (1, 1) logical  = false
end

param.inertia_kgm2 = 1;
param.dQdOm2Lut.dataDQdOm2_Nms2     = [0, 0.01, 0.021, 0.027, 0.03, 0.033, 0.035, 0.036];
param.dQdOm2Lut.bkpts1Speed_radps   = [0, 100,  500,   800,   1000, 1200,  1400,  1600 ] * pi/30;

if opts.isShowPlot
    figure(1); 
    clf;
    plot(param.dQdOm2Lut.bkpts1Speed_radps, param.dQdOm2Lut.dataDQdOm2_Nms2, '-o')
    grid on
    title('Speed vs dQdOm2')
    xlabel('Speed (rpm)')
    ylabel('dQ / dOmega^2 (Nm*s^2)')

end