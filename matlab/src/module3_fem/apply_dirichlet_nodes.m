function [Amod, bmod] = apply_dirichlet_nodes(A, b, nodeIds, value)
%APPLY_DIRICHLET_NODES Apply Dirichlet constraints by row/column elimination.
Amod = A;
bmod = b;
for k = 1:numel(nodeIds)
    id = nodeIds(k);
    bmod = bmod - Amod(:,id)*value;
    Amod(:,id) = 0;
    Amod(id,:) = 0;
    Amod(id,id) = 1;
    bmod(id) = value;
end
end
