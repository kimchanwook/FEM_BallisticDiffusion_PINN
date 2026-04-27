function [M,K,A,F] = assemble_qp_diffusion_reaction_fem_3d(mesh, DqpElem, gammaElem, sourceElem)
%ASSEMBLE_QP_DIFFUSION_REACTION_FEM_3D Wrapper for QP transport equation.
[M,K,A,F] = assemble_scalar_diffusion_reaction_hex8(mesh, ones(size(DqpElem)), DqpElem, gammaElem, sourceElem);
end
