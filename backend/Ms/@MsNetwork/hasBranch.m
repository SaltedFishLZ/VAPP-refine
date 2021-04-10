function out = hasBranch(thisNetwork, branchObj)
% HASBRANCH
    if any(thisNetwork.branchVec == branchObj)
        out = true;
    else
        out = false;
    end
end