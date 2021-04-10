function out = visitI(thisVisitor, iNode)
    %out = thisVisitor.visitIorV(iNode);
    out = thisVisitor.visitPotentialOrFlow(iNode, 1);
end