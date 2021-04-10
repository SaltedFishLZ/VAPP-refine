function traverseSub = visitIrNodeAnalogFunction(thisVisitor, funcNode)
    traverseSub = false;
    funcVisitor = IrVisitorMark001();
    funcVisitor.module = funcNode; % again, this is ugly!
    funcVisitor.traverseChildren(funcNode);
end