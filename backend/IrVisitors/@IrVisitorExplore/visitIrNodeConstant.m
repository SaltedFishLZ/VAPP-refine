function out = visitIrNodeConstant(thisVisitor, constNode, indentLevel)
    out = true;
    outStr = sprintf('Constant: type = %s, value = %g, onDdtPath = %d',...
                                             constNode.getDataType(),...
                                             constNode.getValue(),...
                                             constNode.isOnDdtPath());
    thisVisitor.printIndent(outStr, indentLevel);
end