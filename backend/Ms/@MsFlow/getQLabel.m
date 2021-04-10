function qLabel = getQLabel(thisFlow)
    % GETFLABEL
    if thisFlow.branch.isZeroFlow() == true
        qLabel = '';
    else
        qLabel = getQLabel@MsPotentialFlow(thisFlow);
    end
end