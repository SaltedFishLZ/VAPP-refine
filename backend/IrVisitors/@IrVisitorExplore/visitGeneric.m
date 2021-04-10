function traverseSub = visitGeneric(thisVisitor, irNode, indentLevel)
    traverseSub =  true;
    thisVisitor.printIndent(class(irNode), indentLevel);
end