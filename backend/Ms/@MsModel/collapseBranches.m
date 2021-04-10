function collapseBranches(thisModel)
    % COLLAPSEBRANCHES
    for branchObj = thisModel.collapsedBranchVec
        branchObj.setCollapsed();
    end
end