function label = getModSpecLabel(thisFlow)
% GETMODSPECLABEL
% this has to be augmented with the label of the reference node
    nodeLabel = thisFlow.terminal.getLabel();
    label = ['i', nodeLabel];
end
