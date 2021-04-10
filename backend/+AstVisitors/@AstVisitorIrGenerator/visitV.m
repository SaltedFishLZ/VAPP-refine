function out = visitV(thisVisitor, vNode)
    %out = thisVisitor.visitIorV(vNode);
    out = thisVisitor.visitPotentialOrFlow(vNode, 0);
end