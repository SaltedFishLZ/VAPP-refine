function [twigIdxVec, chordIdxVec, branchVec] = getTwigChordIdx(thisNetwork)
% GETSPANNINGTREE =  get the spanning tree of the network
% twig -> edge in the spanning tree
% chord -> edge of network not in the spanning tree

    [inciMat, branchVec] = thisNetwork.getIncidenceMatrix();

    % get the row echolon form of the incidence matrix
    inciMatEch = rref(inciMat);
    % procedure to select branches for the spanning tree
    % reference: L. O. Chua and P.-M. Lin, Computer-aided analysis
    % of electronic circuits: algorithms and computational techniques.
    % Prentice-Hall, 1975.
    % Chapter 3-6-1

    twigIdxVec = [];
    [nNode, nBranch] = size(inciMatEch);

    i = 1;
    j = 1;
    while i <= nNode
        while j <= nBranch
            if inciMatEch(i,j) == 1
                twigIdxVec = [twigIdxVec, j];
                i = i + 1;
                j = j + 1;
                break;
            else
                j = j + 1;
            end
        end
    end

    chordIdxVec = setdiff(1:nBranch, twigIdxVec);
end