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
% The example here is two ECM unit models in parallel. Each ECM model has
% two RC pairs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear, clc

% params (constant)
ocvA_V = 4; % brnach A OCV
ocvB_V = 4;
r0A_Ohm = 0.005;
r0B_Ohm = 0.015;
r1A_Ohm = 0.004;
r1B_Ohm = 0.004;
r2A_Ohm = 0.007;
r2B_Ohm = 0.007;
c1A_F   = 5 / r1A_Ohm;
c1B_F   = 5 / r1B_Ohm;
c2A_F   = 25 / r2A_Ohm;
c2B_F   = 25 / r2B_Ohm;

% sim
dt_s = .001;
t_s = 1:dt_s:100;

% input
pwr_W = 50 * ones(1, length(t_s));
pwr_W(round(length(pwr_W)/2) : end) = 0;

% ic
vc1AM1_V(1) = 0;
vc1BM1_V(1) = 0;
vc2AM1_V(1) = 0;
vc2BM1_V(1) = 0;

vc1AM2_V(1) = 0;
vc1BM2_V(1) = 0;
vc2AM2_V(1) = 0;
vc2BM2_V(1) = 0;

VtM1_V(1) = ocvA_V;
VtM2_V(1) = ocvB_V;


% sim
for iT = 1:length(t_s)
    % brnach currents
        % method 1
        iM1_A(iT) = pwr_W(iT) / VtM1_V(iT);
        iAM1_A(iT + 1) = (ocvA_V - ocvB_V + iM1_A(iT) * r0B_Ohm - vc1AM1_V(iT) - vc2AM1_V(iT) + vc1BM1_V(iT) + vc2BM1_V(iT)) / (r0A_Ohm + r0B_Ohm);
        iBM1_A(iT + 1) = (ocvB_V - ocvA_V + iM1_A(iT) * r0A_Ohm - vc1BM1_V(iT) - vc2BM1_V(iT) + vc1AM1_V(iT) + vc2AM1_V(iT)) / (r0A_Ohm + r0B_Ohm);    
        
        % method 2
        iM2_A(iT) = pwr_W(iT) / VtM2_V(iT);
        iAM2_A(iT + 1) = iM2_A(iT) * r0B_Ohm / (r0A_Ohm + r0B_Ohm);
        iBM2_A(iT + 1) = iM2_A(iT) * r0A_Ohm / (r0A_Ohm + r0B_Ohm);

    % capacitor voltages (Forward Euler integration)
    vc1AM1_V(iT + 1) = vc1AM1_V(iT) + dt_s * (iAM1_A(iT + 1) / c1A_F - vc1AM1_V(iT) / (r1A_Ohm * c1A_F));
    vc2AM1_V(iT + 1) = vc2AM1_V(iT) + dt_s * (iAM1_A(iT + 1) / c2A_F - vc2AM1_V(iT) / (r2A_Ohm * c2A_F));
    vc1BM1_V(iT + 1) = vc1BM1_V(iT) + dt_s * (iBM1_A(iT + 1) / c1B_F - vc1BM1_V(iT) / (r1B_Ohm * c1B_F));
    vc2BM1_V(iT + 1) = vc2BM1_V(iT) + dt_s * (iBM1_A(iT + 1) / c2B_F - vc2BM1_V(iT) / (r2B_Ohm * c2B_F));

    vc1AM2_V(iT + 1) = vc1AM2_V(iT) + dt_s * (iAM2_A(iT + 1) / c1A_F - vc1AM2_V(iT) / (r1A_Ohm * c1A_F));
    vc2AM2_V(iT + 1) = vc2AM2_V(iT) + dt_s * (iAM2_A(iT + 1) / c2A_F - vc2AM2_V(iT) / (r2A_Ohm * c2A_F));
    vc1BM2_V(iT + 1) = vc1BM2_V(iT) + dt_s * (iBM2_A(iT + 1) / c1B_F - vc1BM2_V(iT) / (r1B_Ohm * c1B_F));
    vc2BM2_V(iT + 1) = vc2BM2_V(iT) + dt_s * (iBM2_A(iT + 1) / c2B_F - vc2BM2_V(iT) / (r2B_Ohm * c2B_F));

    VtM1_V(iT + 1) = ocvA_V - iAM1_A(iT) * r0A_Ohm - vc1AM1_V(iT + 1) - vc1BM1_V(iT + 1);
    VtM2_V(iT + 1) = ocvA_V - iAM2_A(iT) * r0A_Ohm - vc1AM2_V(iT + 1) - vc1BM2_V(iT + 1);
end

%%
figure(1); clf; pause(.05);
ax1 = subplot(2, 2, 1);
yyaxis left
plot(t_s, VtM1_V(2: end), 'LineWidth', 1); grid on, hold on;
plot(t_s, VtM2_V(2: end), '--', 'LineWidth', 2); title('Terminal voltage'); ylabel('V')
yyaxis right
plot(t_s, (VtM1_V(2: end) - VtM2_V(2: end)) ./ VtM1_V(2:end) * 100, 'LineWidth', 1); ylabel('%')
legend('Method 1 - simultaneous solving', 'Method 2 - resistor divider', 'error (%)')

ax2 = subplot(2, 2, 3);
yyaxis left
plot(t_s, iAM1_A(2:end) + iBM1_A(2:end), 'LineWidth', 1.5); grid on; title('Method 1 - sum of branch currents'); 
ylim([1.1, 1.1] .* [(min(iM1_A) - 1), (max(iM1_A) + 1)])
yyaxis right
plot(t_s, iM1_A - (iAM1_A(2:end) + iBM1_A(2:end)), 'LineWidth', 1); ylim([-1 1])
ylabel('A'); xlabel('Time (s)'); legend('Method 1 $\rightarrow \sum$ brnach currents', 'error (A)', 'interpreter', 'latex')

ax3 = subplot(2, 2, 2);
yyaxis left
plot(t_s, iAM1_A(2:end), 'LineWidth', 1); grid on; hold on;
plot(t_s, iAM2_A(2:end), '--', 'LineWidth', 2); title('Branch A current');  ylabel('A')
yyaxis right
plot(t_s, (iAM1_A(2:end) - iAM2_A(2:end)) ./ iAM1_A(2:end) * 100, 'LineWidth', 1); ylabel('%')
legend('Method 1 - simultaneous solving', 'Method 2 - resistor divider', 'error (%)')

ax4 = subplot(2, 2, 4);
yyaxis left
plot(t_s, iBM1_A(2:end), 'LineWidth', 1); grid on; hold on;
plot(t_s, iBM2_A(2:end), '--', 'LineWidth', 2); title('Branch B current'); ylabel('A')
yyaxis right
plot(t_s, (iBM1_A(2:end) - iBM2_A(2:end)) ./ iBM1_A(2:end) * 100, 'LineWidth', 1)
legend('Method 1 - simultaneous solving', 'Method 2 - resistor divider', 'error (%)'); ylabel('%'); xlabel('Time (s)')

set([ax1, ax2, ax3, ax4], 'FontSize', 16)
