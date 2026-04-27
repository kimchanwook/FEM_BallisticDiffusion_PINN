function test_qp_recombination_decay()
T = 0.02;
R = compute_recombination_rate(T, 1.2);
assert(isfinite(R) && R > 0);
fprintf('test_qp_recombination_decay passed.\n');
end
