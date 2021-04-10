function label = getModSpecLabel(thisFlow)
    % GET
    branchLabel = thisFlow.branch.getModSpecLabel();
    label = ['i', branchLabel];
end