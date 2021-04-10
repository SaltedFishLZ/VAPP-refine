function twigVec = getTwigVec(thisNode)
% GETTWIGVEC
    twigVec = MsBranch.empty();
    for branchObj = thisNode.branchVec
        if branchObj.isTwig() == true
            twigVec = [twigVec, branchObj];
        end
    end
end