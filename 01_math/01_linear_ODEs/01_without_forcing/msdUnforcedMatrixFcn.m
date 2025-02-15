function Amatrix = msdUnforcedMatrixFcn(omega_radps, zeta_nd)
% EOM: mxdd + cxd + kx = 0;  (d -> dot)
% some relevatn ratios:
%   sqrt(k/m)          = natural frequency ω
%   c / (2 * sqrt(mak)) = damping ratio ζ (1 = critically damped)
% EOM using the above variable -> xdd + 2ωζxd + ω^2x = 0

Amatrix = [0                1;
           -omega_radps^2   -2*omega_radps*zeta_nd];

end

