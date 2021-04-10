function out = visitIrNodeVariable(thisVisitor, varNode, indentLevel)
    out = true;
    outStr = sprintf('Variable: %s, connected=%d', varNode.getName(),...
                                           varNode.isConnectedToModule);
    thisVisitor.printIndent(outStr, indentLevel);
end