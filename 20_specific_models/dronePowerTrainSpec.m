%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is a very basic script to size the battery given certain
% requirements and certain designs frozen
%
% Requirements
%  1. range (two way)
%  2. cruise speed
%  3. hover time
%
% Frozen parts
%  1. total mass
%  2. number of props
%  3. prop radius
%  
% Assumptions / rule of thumbs
%  1. efficiencies (powertrain, prop)
%  2. number of batteries
%  3. cell characteristics (capacity, max-nom-min voltage)
%  4. maximum voltage
%  5. L/D ratio of aircraft
%  6. hover, cruise aero efficiencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Outputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Hover power               (kW)
% 2. Cruise power              (kW)
% 3. Total energy needed       (kWh)
% 4. Total energy available    (kWh)
% 5. Number of series cells
% 6. Number of parallel cell
% 7. Maximum current           (A)
% 8. Min, nominal, max voltage (V)


clear, clc

%% requirements
rangeTwoWay_m       = 10 * 1609.34; 
cruiseSpeed_mps     = 60 / 2.2369;
hoverTime_s         = 10 * 60;



%% params

% environment params
airDensity_kgpm3    = 1.2;
g_mps2              = 9.8;

% drone params
massDrone_kg        = 10; 
massPayload_kg      = 3.5;
propRadius_m        = 0.2;
propHoverEta_nd     = 0.8;
propCruiseEta_nd    = 0.75;
numProp_nd          = 4;
diskArea_nd         = numProp_nd * pi * propRadius_m^2;
lByD_nd             = 12; % need to be a function of cruise speed

% powertrain params
ptEta_nd            = 0.92;
cellMaxVoltage_V    = 4.2;
cellNomVoltage_V    = 3.7;
cellMinVoltage_V    = 3;
cellNomCapacity_Ah  = 5;
cellMaxDischargeCrate_ph = 7;
numBattery_nd       = 2;
packMaxVoltage_V    = 24;
packMinVoltage_V    = packMaxVoltage_V * (cellMinVoltage_V / cellMaxVoltage_V);




%% find powertrain size
% power -> hover
hoverMechPower_kW   = (  ((massDrone_kg + massPayload_kg) * g_mps2) ^ 1.5  ) / ...
                          (  sqrt(2 * airDensity_kgpm3 * diskArea_nd) * propHoverEta_nd  ) / 1000;
hoverElecPower_kW   = hoverMechPower_kW / ptEta_nd;


% power -> cruise
cruiseDrag_N        = ((massDrone_kg + massPayload_kg) * g_mps2) / lByD_nd; % [F = weight / (L/D)]
cruiseMechPower_kW  = cruiseDrag_N * cruiseSpeed_mps / 1000;
cruiseElecPower_kW  = cruiseMechPower_kW / ptEta_nd;


% energy
cruiseTime_s        = rangeTwoWay_m / cruiseSpeed_mps;
totalElecEnergy_kWh = (hoverTime_s * hoverElecPower_kW + cruiseTime_s * cruiseElecPower_kW) / 3600;


% cell architecture
numCellSeries_nd    = floor(packMaxVoltage_V / cellMaxVoltage_V);
packNomVoltage_V    = numCellSeries_nd * cellNomVoltage_V;
maxBatCurrent_A     = max(hoverElecPower_kW, cruiseElecPower_kW) * 1000 / numBattery_nd / (numCellSeries_nd * cellMinVoltage_V);
numCellParallel_nd  = ceil(round(max(totalElecEnergy_kWh * 1000 / packNomVoltage_V / cellNomCapacity_Ah / numBattery_nd, ...
                                     maxBatCurrent_A / (cellNomCapacity_Ah * cellMaxDischargeCrate_ph)), 2));
totBatteryEnergy_kWh = (numCellSeries_nd * cellNomVoltage_V) * (cellNomCapacity_Ah * numCellParallel_nd) / 1000 * numBattery_nd;

maxCellCurrent_A    = maxBatCurrent_A / numCellParallel_nd;
maxCellCrate_ph     = maxCellCurrent_A / cellNomCapacity_Ah; % ph -> per hour

%% collect salient details
drone.hoverElectricalPower_kW   = hoverElecPower_kW;
drone.cruiseElectricalPower_kW  = cruiseElecPower_kW;
drone.maxCellCrate_ph           = maxCellCrate_ph;
drone.maxBatteryCurrent_A       = maxBatCurrent_A;
drone.numBat_nd                 = numBattery_nd;
drone.numCellSeries_nd          = numCellSeries_nd;
drone.numCellParallel_nd        = numCellParallel_nd;
drone.totalBatteryEnergyNeeded_kWh = totalElecEnergy_kWh;
drone.totalBatteryEnergy_kWh    = (numCellSeries_nd * cellNomVoltage_V) * (cellNomCapacity_Ah * numCellParallel_nd) / 1000 * numBattery_nd;
drone.minTerminalVoltage_V      = numCellSeries_nd * cellMinVoltage_V;


%% print powertrain details
clc
disp(compose("Hover  power (electrical)           = %.1f kW",  drone.hoverElectricalPower_kW));
disp(compose("Cruise power (electrical)           = %.1f kW",  drone.cruiseElectricalPower_kW));
disp(compose("Num batteries                       = %i",       drone.numBat_nd));
disp(compose("Max battery Current                 = %.1f A",   drone.maxBatteryCurrent_A));
disp(compose("Max cell C-rate                     = %.1f C",   drone.maxCellCrate_ph));
disp(compose("Total energy needed    (electrical) = %.2f kWh", drone.totalBatteryEnergyNeeded_kWh));
disp(compose("Total energy available (electrical) = %.2f kWh", drone.totalBatteryEnergy_kWh));
disp(compose("Battery - Number of series cells    = %i ",      drone.numCellSeries_nd));
disp(compose("Battery - Number of paralle cells   = %i ",      drone.numCellParallel_nd));

