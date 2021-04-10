function addBranch(thisNetwork, branchObj)
% ADDBRANCH
    if thisNetwork.hasBranch(branchObj) == false
        thisNetwork.branchVec = [thisNetwork.branchVec, branchObj];
    end
end