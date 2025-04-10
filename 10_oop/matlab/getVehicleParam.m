function p = getVehicleParam()

%% aero params
p.aero.dQdOm2_Nms2 = 0.03;

%% motor params
% mechanical (prop) params
p.motor.prop.inertia_kgm2 = 5;
p.motor.prop.linearDamping_Nms = 0.1;

% thermal params
    % goem, mass params
    l_m = 0.2;
    r_m = 0.2;
    rho_kgpm3 = 3000;
    v_m3 = pi * r_m^2 * l_m;

p.motor.thm.qLoss.htc_Wpm2 = 200;
p.motor.thm.qLoss.convArea_m2 = 2*pi*r_m * l_m;
p.motor.thm.qGen.motorEta_nd = 0.9;
p.motor.thm.motorCp_JpkgpK = 300;
p.motor.thm.motorMass_kg = rho_kgpm3 * v_m3;

%% battery params
end