function Delta = compute_bcs_gap(T, Tc)
%COMPUTE_BCS_GAP Approximate weak-coupling BCS gap in joules.
kB = 1.380649e-23;
T = max(T, eps);
Delta0 = 1.764*kB*Tc;
Delta = zeros(size(T));
mask = T < Tc;
arg = 1.74*sqrt(max(Tc./T(mask) - 1, 0));
Delta(mask) = Delta0*tanh(arg);
Delta(~mask) = 0;
end
