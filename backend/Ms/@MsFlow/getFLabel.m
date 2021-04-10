function fLabel = getFLabel(thisFlow)
    % GETFLABEL
    if thisFlow.branch.isZeroFlow() == true
        fLabel = thisFlow.getLabel();
    else
        fLabel = getFLabel@MsPotentialFlow(thisFlow);
    end
end