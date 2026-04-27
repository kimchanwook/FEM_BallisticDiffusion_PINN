function nEq = compute_equilibrium_qp_density(T, Delta, N0)
%COMPUTE_EQUILIBRIUM_QP_DENSITY Low-temperature BCS asymptotic estimate.
% N0 convention must be supplied consistently by the user.
kB = 1.380649e-23;
T = max(T, eps);
Delta = max(Delta, 0);
nEq = 2*N0.*sqrt(2*pi*kB*T.*max(Delta,eps)).*exp(-Delta./(kB*T));
nEq(Delta == 0) = NaN; % normal state: this asymptotic expression is invalid
end
