function obl = getOrderedBranchList(thisNetwork)
% GETORDEREDBRANCHLIST
    branchVec = thisNetwork.getOrderedBranchVec();
    obl = {};
    for branchObj = branchVec
        obl = [obl, {branchObj.getLabel()}];
    end
end