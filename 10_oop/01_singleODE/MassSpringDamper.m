classdef MassSpringDamper
    properties
        mass_kg
        dampingCoeff_Nspm
        springConstant_Npm
    end
    
    methods
        function obj = MassSpringDamper(mass_kg, dampingCoeff_Nspm, springConstant_Npm)
            obj.mass_kg = mass_kg;
            obj.dampingCoeff_Nspm = dampingCoeff_Nspm;
            obj.springConstant_Npm = springConstant_Npm;
        end
        
        function [omega_radps, zeta_nd, tau_s] = getSystemProperties(obj)
            omega_radps = sqrt(obj.springConstant_Npm / obj.mass_kg);
            zeta_nd = obj.dampingCoeff_Nspm / (2 * sqrt(obj.mass_kg * obj.springConstant_Npm));
            tau_s = 1 / (zeta_nd * omega_radps);
        end
        
        function [time_s, states_mixed] = solveSystem(obj, initialDisplacement_m, initialVelocity_mps)
            % Set default initial conditions if not provided
            if nargin < 2 || isempty(initialDisplacement_m)
                initialDisplacement_m = 0; 
            end
            if nargin < 3 || isempty(initialVelocity_mps)
                initialVelocity_mps = 0; 
            end

            [~, ~, tau_s] = obj.getSystemProperties();
            timeSpan_s = [0, 5 * tau_s];
            [time_s, states_mixed] = ode45(@(t, y) obj.massSpringDamperODE(t, y), timeSpan_s, [initialDisplacement_m; initialVelocity_mps]);
        end
        
        function dydt_nd = massSpringDamperODE(obj, ~, states_mixed)
            dydt_nd = zeros(2,1);
            dydt_nd(1) = states_mixed(2);
            dydt_nd(2) = (-obj.dampingCoeff_Nspm * states_mixed(2) - obj.springConstant_Npm * states_mixed(1)) / obj.mass_kg;
        end
        
        function plotResults(obj, time_s, states_mixed)
            [omega_radps, zeta_nd, ~] = obj.getSystemProperties();

            figure('Position', [100, 100, 1200, 600]);

            subplot(2,2,[1,3]);
            plot(states_mixed(:,1), states_mixed(:,2), 'k', 'LineWidth', 1);
            xlabel('Displacement (m)');
            ylabel('Velocity (m/s)');
            title(sprintf('Phase Plot\n\x03B6 = %.2f (dimensionless), \x03C9_n = %.2f rad/s', zeta_nd, omega_radps));
            grid on;
            axis equal;

            subplot(2,2,2);
            plot(time_s, states_mixed(:,1), 'b', 'LineWidth', 1);
            xlabel('Time (s)');
            ylabel('Displacement (m)');
            title('Displacement');
            grid on;

            subplot(2,2,4);
            plot(time_s, states_mixed(:,2), 'r', 'LineWidth', 1);
            xlabel('Time (s)');
            ylabel('Velocity (m/s)');
            title('Velocity');
            grid on;
            linkaxes([gca, gca], 'x');
        end
    end
end
