function traverseSub = visitIrNodeCollapseBranch(thisVisitor, cbNode)
    % VISITIRNODECOLLAPSEBRANCH
        traverseSub = false;

        thisVisitor.collapsedBranchVec = [thisVisitor.collapsedBranchVec, ...
                                                        cbNode.getBranch()];
end