function outBranch = getBranch(thisNode, otherNode)
% GETBRANCH

    % return empty object if not connected to otherNode
    outBranch = MsBranch.empty;
    for branch = thisNode.branchVec
        if branch.getOtherNode(thisNode) == otherNode
            outBranch = branch;
            break;
        end
    end
end