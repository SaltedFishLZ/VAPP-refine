function [twigVec, chordVec] = getTwigChordVec(thisNetwork)
% GETTWIGCHORDVEC
    %branchVec = thisNetwork.getOrderedBranchVec();
    [twigIdx, chordIdx, branchVec] = thisNetwork.getTwigChordIdx();
    twigVec = branchVec(twigIdx);
    chordVec = branchVec(chordIdx);

    % mark branches as twigs or chrods
    % first reset any previous markings
    for branchObj = twigVec
        branchObj.resetTwigChord();
        branchObj.setTwig();
    end

    for branchObj = chordVec
        branchObj.resetTwigChord();
        branchObj.setChord();
    end
end
