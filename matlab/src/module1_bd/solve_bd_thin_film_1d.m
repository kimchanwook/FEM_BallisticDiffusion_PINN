function result = solve_bd_thin_film_1d(params)
%SOLVE_BD_THIN_FILM_1D Dimensionless ballistic-diffusive thin-film solver.
% Equation: theta_tt + theta_t = (Kn^2/3) theta_xx - Kn*dq_b/dx.
% This is a pedagogical validation solver, not the final 3D FEM solver.
Nx = params.Nx;
eta = linspace(0, 1, Nx)';
deta = eta(2) - eta(1);
dt = params.dtStar;
numSteps = ceil(params.tFinalStar / dt);
Kn = params.Kn;
alpha = Kn^2 / 3;

theta = zeros(Nx,1);
vel = zeros(Nx,1);

outputTimes = params.outputTimesStar(:);
outputs = zeros(Nx, numel(outputTimes));
outIndex = 1;

for it = 1:numSteps
    tStar = it*dt;
    qb = compute_ballistic_flux_1d(eta, tStar, Kn);
    dqbdeta = gradient(qb, deta);
    lap = laplacian_1d_neumann(theta, deta);
    accel = alpha*lap - vel - Kn*dqbdeta;
    vel = vel + dt*accel;
    theta = theta + dt*vel;
    theta(theta < 0) = 0;
    if outIndex <= numel(outputTimes) && tStar >= outputTimes(outIndex)
        outputs(:,outIndex) = theta;
        outIndex = outIndex + 1;
    end
end
while outIndex <= numel(outputTimes)
    outputs(:,outIndex) = theta;
    outIndex = outIndex + 1;
end

result = struct();
result.Kn = Kn;
result.eta = eta;
result.outputTimesStar = outputTimes;
result.theta = outputs;
end

function lap = laplacian_1d_neumann(u, dx)
N = numel(u);
lap = zeros(N,1);
lap(2:N-1) = (u(3:N) - 2*u(2:N-1) + u(1:N-2))/dx^2;
lap(1) = 2*(u(2)-u(1))/dx^2;
lap(N) = 2*(u(N-1)-u(N))/dx^2;
end
