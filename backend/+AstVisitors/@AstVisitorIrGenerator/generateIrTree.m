function irTree = generateIrTree(thisVisitor, rootNode)
    irTree = thisVisitor.traverseAst(rootNode);
    thisVisitor.irTree = irTree;
end