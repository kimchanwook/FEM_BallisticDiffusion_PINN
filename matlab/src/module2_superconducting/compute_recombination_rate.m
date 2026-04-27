function R = compute_recombination_rate(T, Tc)
%COMPUTE_RECOMBINATION_RATE Placeholder reduced recombination coefficient.
% This returns an effective coefficient for testing the PDE structure.
T = max(T, eps);
R0 = 1.0e-16; % m^3/s placeholder
R = R0 .* exp(-0.2*T./Tc);
end
