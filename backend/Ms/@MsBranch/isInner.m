function out = isInner(thisBranch)
    % ISINNER
    nodeObj1 = thisBranch.node1;
    nodeObj2 = thisBranch.node2;
    out = (nodeObj1.isInternal() || nodeObj2.isInternal());
end