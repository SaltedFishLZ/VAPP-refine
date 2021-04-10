function out = visitIrNodeInputOutput(thisVisitor, ioNode, indentLevel)
    out = true;
    outStr = sprintf('InputOutput: %s, dummy: %d',...
                                     ioNode.getIoObj.getLabel(),...
                                     ioNode.isDummy());
    thisVisitor.printIndent(outStr, indentLevel);
end
