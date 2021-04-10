function out = visitIrNodeParameter(thisVisitor, parmNode, indentLevel)
    out = true;
    outStr = sprintf('Parameter: %s', parmNode.getName());
    thisVisitor.printIndent(outStr, indentLevel);
end