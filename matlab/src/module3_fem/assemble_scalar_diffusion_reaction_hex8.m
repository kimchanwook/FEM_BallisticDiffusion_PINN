function [M, K, A, F] = assemble_scalar_diffusion_reaction_hex8(mesh, massCoeffElem, diffCoeffElem, reactionCoeffElem, sourceElem)
%ASSEMBLE_SCALAR_DIFFUSION_REACTION_HEX8 Assemble Q1 hexahedral FEM matrices.
% PDE form: massCoeff*u_t - div(diffCoeff*grad u) + reactionCoeff*u = source.
nNodes = size(mesh.nodes,1);
nElem = size(mesh.elements,1);
I = []; J = []; VM = []; VK = []; VA = [];
F = zeros(nNodes,1);
[gpts, gw] = gauss_hex_points();
for e = 1:nElem
    conn = mesh.elements(e,:);
    X = mesh.nodes(conn,:);
    Me = zeros(8,8); Ke = zeros(8,8); Ae = zeros(8,8); Fe = zeros(8,1);
    for q = 1:size(gpts,1)
        xi = gpts(q,1); eta = gpts(q,2); zeta = gpts(q,3);
        [N, dNdxi] = shape_hex8(xi, eta, zeta);
        Jac = dNdxi' * X;
        detJ = det(Jac);
        if detJ <= 0
            error('Non-positive Jacobian in element %d.', e);
        end
        gradN = dNdxi / Jac;
        w = gw(q)*detJ;
        Me = Me + massCoeffElem(e)*(N*N')*w;
        Ke = Ke + diffCoeffElem(e)*(gradN*gradN')*w;
        Ae = Ae + reactionCoeffElem(e)*(N*N')*w;
        Fe = Fe + sourceElem(e)*N*w;
    end
    [ii,jj] = ndgrid(conn, conn);
    I = [I; ii(:)]; %#ok<AGROW>
    J = [J; jj(:)]; %#ok<AGROW>
    VM = [VM; Me(:)]; %#ok<AGROW>
    VK = [VK; Ke(:)]; %#ok<AGROW>
    VA = [VA; Ae(:)]; %#ok<AGROW>
    F(conn) = F(conn) + Fe;
end
M = sparse(I,J,VM,nNodes,nNodes);
K = sparse(I,J,VK,nNodes,nNodes);
A = sparse(I,J,VA,nNodes,nNodes);
end

function [gpts, gw] = gauss_hex_points()
a = 1/sqrt(3);
pts = [-a, a];
gpts = zeros(8,3); gw = ones(8,1);
q = 0;
for k = 1:2
    for j = 1:2
        for i = 1:2
            q = q + 1;
            gpts(q,:) = [pts(i), pts(j), pts(k)];
        end
    end
end
end

function [N, dNdxi] = shape_hex8(xi, eta, zeta)
% Node order: bottom face counterclockwise, then top face.
s = [-1  1  1 -1 -1  1  1 -1];
t = [-1 -1  1  1 -1 -1  1  1];
u = [-1 -1 -1 -1  1  1  1  1];
N = zeros(8,1);
dNdxi = zeros(8,3);
for a = 1:8
    N(a) = 1/8*(1+s(a)*xi)*(1+t(a)*eta)*(1+u(a)*zeta);
    dNdxi(a,1) = 1/8*s(a)*(1+t(a)*eta)*(1+u(a)*zeta);
    dNdxi(a,2) = 1/8*(1+s(a)*xi)*t(a)*(1+u(a)*zeta);
    dNdxi(a,3) = 1/8*(1+s(a)*xi)*(1+t(a)*eta)*u(a);
end
end
