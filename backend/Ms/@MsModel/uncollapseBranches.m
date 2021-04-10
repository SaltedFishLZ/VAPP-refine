function uncollapseBranches(thisModel)
    % UNCOLLAPSEBRANCHES
    for branchObj = thisModel.collapsedBranchVec
        branchObj.unsetCollapsed();
    end
end