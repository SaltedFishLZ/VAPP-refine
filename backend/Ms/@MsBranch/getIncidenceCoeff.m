function out = getIncidenceCoeff(thisBranch, nodeObj)
    if thisBranch.node1 == nodeObj
        out = 1;
    elseif thisBranch.node2 == nodeObj
        out = -1;
    else
        out = 0;
    end
end