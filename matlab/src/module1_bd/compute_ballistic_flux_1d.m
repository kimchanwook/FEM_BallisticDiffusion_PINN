function qb = compute_ballistic_flux_1d(eta, tStar, Kn)
%COMPUTE_BALLISTIC_FLUX_1D Approximate normalized ballistic heat flux.
% Uses Chen-style 1D thin-film expression for a boundary step at eta=0:
% q_b^*(eta,t*) = 1/2 int_{mu_t}^1 mu exp[-eta/(mu Kn)] dmu,
% where mu_t = eta/(Kn t*). If mu_t >= 1, the ballistic front has not arrived.
eta = eta(:);
qb = zeros(size(eta));
if tStar <= 0 || Kn <= 0
    return;
end
nQuad = 64;
for i = 1:numel(eta)
    mu_t = eta(i)/(Kn*tStar);
    if mu_t < 1
        a = max(mu_t, 0);
        mu = linspace(a, 1, nQuad);
        integrand = mu .* exp(-eta(i)./(max(mu,eps)*Kn));
        qb(i) = 0.5 * trapz(mu, integrand);
    end
end
end
