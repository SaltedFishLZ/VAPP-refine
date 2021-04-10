function setNetwork(thisNode, networkObj)
% SETNETWORK
    if isempty(thisNode.network) == true
        thisNode.network = networkObj;
    else
        error(['Cannot set network of node %s because it already ',...
              'belongs to a network!'], thisNode.label);
    end
end