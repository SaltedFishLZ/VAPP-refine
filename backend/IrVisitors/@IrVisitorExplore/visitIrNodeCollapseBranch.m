function out = visitIrNodeCollapseBranch(thisVisitor, cbNode, indentLevel)
    out = true;
    outStr = sprintf('CollapseBranch: %s', cbNode.getBranch().getLabel());
    thisVisitor.printIndent(outStr, indentLevel);
end
