function [defBranchVec, defSignVec] = getCutDef(thisNetwork, branchObj)
% GETCUTDEFINITION get the branches and their signs that are required
% to write a KCL for branchObj

    defBranchVec = MsBranch.empty;
    defSignVec = [];
    if branchObj.isChord() == false
        [twigVec, chordVec] = thisNetwork.getTwigChordVec();
        [B_t, ~] = thisNetwork.getTwigLoopChordCutsetMatrix();
        twigIdx = find(twigVec == branchObj);
        % get the row twigIdx in transpose(B_t)
        twigRow = transpose(B_t(:, twigIdx));
        chordIdx = (twigRow ~= 0);
        defBranchVec = chordVec(chordIdx);
        defSignVec = twigRow(chordIdx);
    else
        error(['You have provided a branch that has an independent',...
               ' flow. It cannot be expressed in terms of',...
               ' other flows in the network!']);
    end
end
