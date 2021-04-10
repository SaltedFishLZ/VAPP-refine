function otherNode = getOtherNode(thisBranch, aNode)
    % GETOTHERNODE
    if thisBranch.node1 == aNode
        otherNode = thisBranch.node2;
    elseif thisBranch.node2 == aNode
        otherNode = thisBranch.node1;
    else
        error('Error this branch is not connected to %s!', aNode.getLabel());
    end
end