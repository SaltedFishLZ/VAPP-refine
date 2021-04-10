function outBranch = getReferenceBranch(thisNode)
% GETREFERENCEBRANCH
    outBranch = MsBranch.empty;
    if thisNode.reference == false
        for branch = thisNode.branchVec
            if branch.isReference() == true
                outBranch = branch;
                break;
            end
        end
    end
end