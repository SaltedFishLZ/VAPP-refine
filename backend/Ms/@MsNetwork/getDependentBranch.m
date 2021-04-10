function depBranchVec = getDependentBranch(thisNetwork, branchObj)
% GETDEPENDENTBRANCH get all branches that depend on branchObj
% another branch's potential depends on the potential of branchObj if
% branchObj is a twig
% another branch's flow depends on the flow of branchObj if branchObj
% is a chord
    [twigVec, chordVec] = thisNetwork.getTwigChordVec();
    [B_t, D_c] = thisNetwork.getTwigLoopChordCutsetMatrix();
    if branchObj.isTwig() == true
        % get the index of the branchObj in the twig vector
        twigIdx = find(twigVec == branchObj);
        % twigIdx indicates which column of B_t we should look into.
        % A non-zero element there means that we have a chord whose
        % potential value depends on the potential value on the
        % branchObj.
        depChordIdx = find(B_t(:, twigIdx) ~= 0);
        depBranchVec = chordVec(depChordIdx);
    elseif branchObj.isChord() == true
        % get the index of the branchObj in the chordVec
        chordIdx = find(chordVec == branchObj);
        % chordIdx indicates which column of D_c we should look into.
        % The location of a non-zero element in D_c points to the index
        % of a branch whose flow depends on the flow of branchObj.
        depTwigIdx = find(D_c(:, chordIdx) ~= 0);
        depBranchVec = twigVec(depTwigIdx);
    else
        error(['This branch has not been marked either as a twig',...
               ' or a chord!']);
    end
end