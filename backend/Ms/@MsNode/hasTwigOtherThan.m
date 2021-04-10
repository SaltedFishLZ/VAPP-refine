function out = hasTwigOtherThan(thisNode, twig)
% HASTWIGOTHERTHAN
    out = false;
    if thisNode.hasBranch(twig) == false
        error('This node does not have this twig (%s)!', twig.getLabel());
    end

    for branch = thisNode.branchVec
        if branch.isTwig() == true && (branch ~= twig)
            out = true;
            break;
        end
    end
end