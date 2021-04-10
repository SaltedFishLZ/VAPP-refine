function out = visitIrNodeFunction(thisVisitor, funcNode, indentLevel)
    out = true;
    outStr = sprintf('Function: %s, ddtTopNode: %d', ...
                                                funcNode.getName(),...
                                                funcNode.isDdtTopNode);
    thisVisitor.printIndent(outStr, indentLevel);
end