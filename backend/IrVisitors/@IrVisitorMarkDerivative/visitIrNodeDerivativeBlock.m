function traverseSub = visitIrNodeDerivativeBlock(thisVisitor, dbNode)
    % IRNODEDERIVATIVEBLOCK
        traverseSub = false;
        if thisVisitor.derivOrder == 1
            mark1Vis = IrVisitorMark001();
            mark1Vis.traverseChildren(dbNode);
        else
            derivVis = IrVisitorMarkDerivative(thisVisitor.deriVOrder-1);
            derivVis.traverseChildren(dbNode);
        end
end