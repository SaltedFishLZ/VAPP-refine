function bDir = getDirection(thisBranch, nodeObj)
    % GETDIRECTION returns the diretion of the branch with respect to the
    % nodeObj
    % bDir = 1 if branch goes out of nodeObj
    % bDir = -1 if branch goes into nodeObj
    bDir = thisBranch.getIncidenceCoeff(nodeObj);
    if bDir == 0
        error('This branch is not connected to node %s!',...
                                                 nodeObj.getLabel());
    end
end