function addBranch(thisNode, branchObj)
    otherNode = branchObj.getOtherNode(thisNode);
    if isempty(thisNode.getBranch(otherNode))
        thisNode.branchVec = [thisNode.branchVec, branchObj];
    else
        error(['Cannot add this branch! ', ...
               '%s is already connected to %s with another ',...
               'branch.'], thisNode.getLabel(), otherNode.getLabel());
    end

    if isempty(thisNode.network) == false
        thisNode.network.addBranch(branchObj);
    end
end
