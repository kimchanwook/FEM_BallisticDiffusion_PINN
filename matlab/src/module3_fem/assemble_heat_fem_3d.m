function [M,K,F] = assemble_heat_fem_3d(mesh, rhoCpElem, kElem, sourceElem)
%ASSEMBLE_HEAT_FEM_3D Wrapper for scalar heat equation assembly.
zeroReaction = zeros(size(rhoCpElem));
[M,K,~,F] = assemble_scalar_diffusion_reaction_hex8(mesh, rhoCpElem, kElem, zeroReaction, sourceElem);
end
