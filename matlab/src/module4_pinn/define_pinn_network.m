function net = define_pinn_network(numInputs, numOutputs)
%DEFINE_PINN_NETWORK Define a simple fully connected network skeleton.
% Requires MATLAB Deep Learning Toolbox for actual training.
layers = [
    featureInputLayer(numInputs, 'Normalization','zscore', 'Name','input')
    fullyConnectedLayer(64, 'Name','fc1')
    tanhLayer('Name','tanh1')
    fullyConnectedLayer(64, 'Name','fc2')
    tanhLayer('Name','tanh2')
    fullyConnectedLayer(64, 'Name','fc3')
    tanhLayer('Name','tanh3')
    fullyConnectedLayer(numOutputs, 'Name','output')];
try
    net = dlnetwork(layerGraph(layers));
catch
    net = layers;
end
end
