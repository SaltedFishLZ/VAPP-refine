function out = isConnectedTo(thisNode, aNode)
% ISCONNECTEDTO

    if aNode == thisNode
        error('You are probing if this node is connected to itself!');
    end

    branch = thisNode.getBranch(aNode);
    if isempty(branch) == false
        out = true;
    else
        out = false;
    end
end