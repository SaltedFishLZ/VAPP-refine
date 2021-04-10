function [defBranchVec, defSignVec] = getLoopDef(thisNetwork, branchObj)
% GETLOOPDEFINITION get the branches and their signs that are required
% to write down a KVL for branchObj
    defBranchVec = MsBranch.empty;
    defSignVec = [];
    if branchObj.isTwig() == false
        [twigVec, chordVec] = thisNetwork.getTwigChordVec();
        [~, D_c] = thisNetwork.getTwigLoopChordCutsetMatrix();
        chordIdx = find(chordVec == branchObj);
        % get the row chordIdx in transpose(D_c)
        chordRow = transpose(D_c(:, chordIdx));
        twigIdx = (chordRow ~= 0);
        defBranchVec = twigVec(twigIdx);
        defSignVec = chordRow(twigIdx);
    else
        error(['You have provided a branch that has an independent',...
               ' potential. It cannot be expressed in terms of',...
               ' other potentials in the network!']);
    end
end