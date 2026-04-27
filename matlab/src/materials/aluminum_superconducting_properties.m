function props = aluminum_superconducting_properties(T)
%ALUMINUM_SUPERCONDUCTING_PROPERTIES Reduced Al superconducting properties.
Tc = 1.2;
Delta = compute_bcs_gap(T, Tc);
props = struct();
props.Tc = Tc;
props.Delta_J = Delta;
props.Dqp = 2.0e-3;
props.recombinationRate = compute_recombination_rate(T, Tc);
end
