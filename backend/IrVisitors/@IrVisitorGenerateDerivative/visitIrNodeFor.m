function traverseSub = visitIrNodeFor(thisVisitor, forNode)
    traverseSub = false;
    blockNode = forNode.getChild(4);
    IrVisitorGenerateDerivative(thisVisitor.derivPfVec,...
                                 thisVisitor.derivVarVec,...
                                 blockNode);
end