function out = hasBranch(thisNode, branchObj)
% HASBRANCH
    if any(thisNode.branchVec == branchObj) == true
        out = true;
    else
        out = false;
    end
end