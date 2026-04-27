function mesh = create_tensor_hex_mesh_3d(xNodes, yNodes, zNodes)
%CREATE_TENSOR_HEX_MESH_3D Structured hexahedral mesh from tensor-product nodes.
[xg, yg, zg] = ndgrid(xNodes(:), yNodes(:), zNodes(:));
nodes = [xg(:), yg(:), zg(:)];
Nx = numel(xNodes); Ny = numel(yNodes); Nz = numel(zNodes);
nodeId = @(i,j,k) i + (j-1)*Nx + (k-1)*Nx*Ny;
numElem = (Nx-1)*(Ny-1)*(Nz-1);
elements = zeros(numElem, 8);
e = 0;
for k = 1:Nz-1
    for j = 1:Ny-1
        for i = 1:Nx-1
            e = e + 1;
            elements(e,:) = [nodeId(i,j,k), nodeId(i+1,j,k), nodeId(i+1,j+1,k), nodeId(i,j+1,k), ...
                             nodeId(i,j,k+1), nodeId(i+1,j,k+1), nodeId(i+1,j+1,k+1), nodeId(i,j+1,k+1)];
        end
    end
end
mesh = struct();
mesh.nodes = nodes;
mesh.elements = elements;
mesh.xNodes = xNodes(:);
mesh.yNodes = yNodes(:);
mesh.zNodes = zNodes(:);
mesh.elementCenters = compute_element_centers(nodes, elements);
mesh.elementVolumes = compute_element_volumes(nodes, elements);
end

function centers = compute_element_centers(nodes, elements)
centers = zeros(size(elements,1), 3);
for e = 1:size(elements,1)
    centers(e,:) = mean(nodes(elements(e,:),:), 1);
end
end

function volumes = compute_element_volumes(nodes, elements)
volumes = zeros(size(elements,1), 1);
for e = 1:size(elements,1)
    X = nodes(elements(e,:),:);
    dx = max(X(:,1)) - min(X(:,1));
    dy = max(X(:,2)) - min(X(:,2));
    dz = max(X(:,3)) - min(X(:,3));
    volumes(e) = dx*dy*dz;
end
end
