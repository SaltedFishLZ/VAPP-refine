function out = getNodeOrder(thisBranch, nodeObj1, nodeObj2)
    % NAME
    if nodeObj1 == thisBranch.node1 && nodeObj2 == thisBranch.node2
        out = 1;
    elseif nodeObj2 == thisBranch.node1 && nodeObj1 == thisBranch.node2
        out = -1;
    else
        error('The supplied nodes do not match with the nodes of this branch!');
    end
end