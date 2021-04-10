function out = areNodesReversed(thisBranch, nodeObj1, nodeObj2)
    % ARENODESREVERSED
    out = (thisBranch.getNodeOrder(nodeObj1, nodeObj2) == -1);
end