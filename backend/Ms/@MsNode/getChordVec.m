function chordVec = getChordVec(thisNode)
% GETCHORDVEC
    chordVec = MsBranch.empty();
    for branchObj = thisNode.branchVec
        if branchObj.isChord() == true
            chordVec = [chordVec, branchObj];
        end
    end
end