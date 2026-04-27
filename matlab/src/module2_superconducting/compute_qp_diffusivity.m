function D = compute_qp_diffusivity(materialName, T)
%COMPUTE_QP_DIFFUSIVITY Effective quasiparticle diffusivity model.
% First-build values are placeholders and should be replaced for quantitative work.
switch lower(materialName)
    case {'al','aluminum','aluminum_superconductor'}
        D0 = 2.0e-3;
    case {'ta','tantalum','tantalum_superconductor'}
        D0 = 5.0e-4;
    case {'nb','niobium','niobium_superconductor'}
        D0 = 8.0e-4;
    otherwise
        D0 = 1.0e-12;
end
D = D0 * ones(size(T));
end
