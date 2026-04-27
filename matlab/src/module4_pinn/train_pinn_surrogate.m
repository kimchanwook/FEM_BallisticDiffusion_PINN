function trainedNet = train_pinn_surrogate(trainData, net, options)
%TRAIN_PINN_SURROGATE Placeholder training routine for the physics-informed surrogate.
% First build documents the loss terms and network structure. Full training should
% be implemented after a multi-case FEM dataset exists.
if nargin < 3; options = struct(); end
trainedNet = net;
fprintf('train_pinn_surrogate scaffold called with %d samples.\n', size(trainData.X,1));
end
