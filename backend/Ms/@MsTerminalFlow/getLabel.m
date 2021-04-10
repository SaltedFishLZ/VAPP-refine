function label = getLabel(thisFlow)
% GETLABEL
    label = [thisFlow.labelPrefix, '_', thisFlow.terminal.getLabel()];
end