function dx = msdFcn(~, x, u, m_kg, c_Nspm, k_Npm)
% size initialization
dx = [0; 0];

% msd model
dx(1) = x(2);
dx(2) = -k_Npm/m_kg * x(1) - c_Nspm/m_kg * x(2) + 1/m_kg * u;

end