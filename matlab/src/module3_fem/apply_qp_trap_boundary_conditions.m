function gammaElem = apply_qp_trap_boundary_conditions(mesh, gammaElem, trapRate)
%APPLY_QP_TRAP_BOUNDARY_CONDITIONS Add volume trap removal to trap-tagged elements.
if nargin < 3; trapRate = 1.0e7; end
gammaElem(mesh.elementRegion.isTrap) = gammaElem(mesh.elementRegion.isTrap) + trapRate;
end
