function traverseSub = visitIrNodeModule(thisVisitor, moduleNode)
    traverseSub = true;
    moduleNode.setDerivLevel(1);
end