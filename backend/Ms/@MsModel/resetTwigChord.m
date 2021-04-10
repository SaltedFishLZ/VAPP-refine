function resetTwigChord(thisModel)
    % RESETTWIGCHORD
    branchVec = thisModel.network.getBranchVec();
    for branchObj = branchVec
        branchObj.resetTwigChord();
    end
end