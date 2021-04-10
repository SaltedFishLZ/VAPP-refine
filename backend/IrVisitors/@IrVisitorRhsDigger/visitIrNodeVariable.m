function traverseSub = visitIrNodeVariable(thisVisitor, varNode)
    traverseSub = false;
    varObj = varNode.getVarObj();
    thisVisitor.add2VarVec(varObj);
end