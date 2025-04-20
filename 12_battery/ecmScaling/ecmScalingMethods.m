%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script shows the two methods of ECM model scaling to represent a
% battery models with multiple cells each of which is modeled with the unit
% ECM model.
% 
% Part 1 - brnach currents
%   Method 1 - simultaneous solving of brnach currents
%   Method 2 - solving branch cuurents by resistor dividers
% Part 2 - capacitor voltage 
%   These brnach currents are then passed on to the capacitor voltage ODEs.
%   This part is same for both methods
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The example here is 

clear, clc

% params (constant)
ocvA_V = 4; % brnach A OCV
ocvB_V = 4;
r0A_Ohm = 0.01;
r0B_Ohm = 0.01;
r1A_Ohm = 0.005;
r1B_Ohm = 0.005;
r2A_Ohm = 0.007;
r2B_Ohm = 0.007;
c1A_F   = 5 / r1A_Ohm;
c1B_F   = 5 / r1B_Ohm;
c2A_F   = 25 / r2A_Ohm;
c2B_F   = 25 / r2B_Ohm;

% input
i_A = 10;

% sim
dt_s = 0.1;
t_s = 1:dt_s:100;

% ic
vc1AM1_V(1) = 0;
vc1BM1_V(1) = 0;
vc2AM1_V(1) = 0;
vc2BM1_V(1) = 0;

vc1AM2_V(1) = 0;
vc1BM2_V(1) = 0;
vc2AM2_V(1) = 0;
vc2BM2_V(1) = 0;

% sim
for iT = 1:length(t_s)
    % brnach currents
        % method 1
        iAM1_A(iT) = (ocvA_V - ocvB_V + i_A * r0B_Ohm - vc1AM1_V(iT) - vc2AM1_V(iT) + vc1BM1_V(iT) + vc2BM1_V(iT)) / (r0A_Ohm + r0B_Ohm);
        iBM1_A(iT) = (ocvB_V - ocvA_V + i_A * r0A_Ohm - vc1BM1_V(iT) - vc2BM1_V(iT) + vc1AM1_V(iT) + vc2AM1_V(iT)) / (r0A_Ohm + r0B_Ohm);    
        
        % method 2
        iaM2_A(iT) = r0B_Ohm / (r0A_Ohm + r0B_Ohm);
        ibM2_A(iT) = r0A_Ohm / (r0A_Ohm + r0B_Ohm);

    % capacitor voltages
    vc1AM1_V(iT + 1) = iAM1_A(iT) / c1A_F - vc1AM1_V(iT) / (r1A_Ohm * c1A_F);
    vc2AM1_V(iT + 1) = iAM1_A(iT) / c2A_F - vc2AM1_V(iT) / (r2A_Ohm * c2A_F);
    vc1BM1_V(iT + 1) = iBM1_A(iT) / c1B_F - vc1BM1_V(iT) / (r1B_Ohm * c1B_F);
    vc2BM1_V(iT + 1) = iBM1_A(iT) / c2B_F - vc2BM1_V(iT) / (r2B_Ohm * c2B_F);

    vc1AM2_V(iT + 1) = iAM2_A / c1A_F - vc1AM2_V(iT) / (r1A_Ohm * c1A_F);
    vc2AM2_V(iT + 1) = iAM2_A / c2A_F - vc2AM2_V(iT) / (r2A_Ohm * c2A_F);
    vc1BM2_V(iT + 1) = iBM2_A / c1B_F - vc1BM2_V(iT) / (r1B_Ohm * c1B_F);
    vc2BM2_V(iT + 1) = iBM2_A / c2B_F - vc2BM2_V(iT) / (r2B_Ohm * c2B_F);

    VtM1_V(iT) = ocvA_V - iAM1_A(iT)*r0A_Ohm - vc1AM1_V(iT + 1)

end