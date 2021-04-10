function traverseSub = visitIrNodeAssignment(thisVisitor, assignNode)
    % VISITIRNODEASSIGNMENT
        traverseSub = false;
        lhsNode = assignNode.getLhsNode();
        lhsVarObj = lhsNode.getVarObj();
        if lhsVarObj.isInNodeCollapse() == true
            thisVisitor.ncStr = [thisVisitor.ncStr, assignNode.sprintAll()];
        end
end