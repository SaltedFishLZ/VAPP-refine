function traverseChildren(thisVisitor, irNode)
    nChild = irNode.getNChild();
    for i=1:nChild
        thisVisitor.traverseIr(irNode.getChild(i));
    end
end