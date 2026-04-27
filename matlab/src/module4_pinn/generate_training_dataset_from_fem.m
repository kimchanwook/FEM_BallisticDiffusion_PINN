function trainData = generate_training_dataset_from_fem(mesh, field, geomParams)
%GENERATE_TRAINING_DATASET_FROM_FEM Sample a static FEM field for surrogate scaffolding.
% For real transient training, extend X with time and design parameters.
Xspace = mesh.nodes;
trapDist = geomParams.trap.distanceFromJunction*ones(size(Xspace,1),1);
trapRate = geomParams.qp.trapRemovalRate*ones(size(Xspace,1),1);
X = [Xspace, trapDist, trapRate];
Y = field(:);
trainData = struct('X', X, 'Y', Y);
end
