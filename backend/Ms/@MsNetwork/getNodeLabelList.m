function nll = getNodeLabelList(thisNetwork)
% GETNODELABELLIST
    nodeVec = thisNetwork.nodeVec;
    nodeVec(nodeVec == thisNetwork.refNode) = [];

    nll = {};
    for nodeObj = nodeVec
        nll = [nll, {nodeObj.getLabel()}];
    end

end