function out = hasNode(thisNetwork, nodeObj)
% HASNODE
    if any(thisNetwork.nodeVec == nodeObj)
        out = true;
    else
        out = false;
    end
end