function [B_t, D_c] = getTwigLoopChordCutsetMatrix(thisNetwork)
% GETTWIGLOOPCHORDCUTSETMATRIX
    [twigVec, chordVec] = thisNetwork.getTwigChordVec();
    [B, D] = thisNetwork.getLoopCutsetMatrix();

    nTwig = numel(twigVec);
    nChord = numel(chordVec);
    nBranch = nTwig + nChord;

    % get the twig part of the loop matrix
    B_t = B(1:nChord, 1:nTwig);
    % get the chord part of the cutset matrix
    D_c = D(1:nTwig, nTwig+1:nBranch);
end