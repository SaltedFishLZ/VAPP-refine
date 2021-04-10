function ncBranchIdxVec = getBranchIdxWithNodeCollapse(thisNetwork, branchIdxVec)
% GETBRANCHIDXWITHNODECOLLAPSE
    ncBranchIdxVec = branchIdxVec;
    for collapsedBranchIdx = thisNetwork.collapsedBranchIdxVec
        geIdx = find(ncBranchIdxVec >= collapsedBranchIdx);
        ncBranchIdxVec(geIdx) = ncBranchIdxVec(geIdx) + 1;
    end
end