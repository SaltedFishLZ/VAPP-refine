function out = hasTwigWithFlow(thisNode)
% HASTWIGWITHFLOW check if a node has a branch attached to it that is
% not zeroFlow.
    out = false;
    for branch = thisNode.branchVec
        if branch.isTwig() == true && branch.isZeroFlow() == false
            out = true;
            break;
        end
    end
end