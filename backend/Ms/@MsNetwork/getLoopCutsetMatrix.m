function [loopMat, cutMat] = getLoopCutsetMatrix(thisNetwork)
% GETLOOPMATRIX

    inciMat = thisNetwork.getIncidenceMatrix();
    [twigIdxVec, chordIdxVec] = thisNetwork.getTwigChordIdx();
    inciMatTreeOrder = inciMat(:, [twigIdxVec, chordIdxVec]);

    cutMat = rref(inciMatTreeOrder);

    [nNode, nBranch] = size(cutMat);

    cutMat_t = cutMat(:, 1:nNode);
    cutMat_l = cutMat(:, nNode+1:nBranch);

    loopMat = [-transpose(cutMat_l), eye(nBranch-nNode)];
end
