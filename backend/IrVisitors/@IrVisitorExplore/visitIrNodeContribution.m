function out = visitIrNodeContribution(thisVisitor, contribNode, indentLevel)
    out = true;
    outStr = sprintf('Contribution: eqn idx: %d, null: %d',...
                                         contribNode.getEqnIdx(),...
                                         contribNode.isNullEqn());
    thisVisitor.printIndent(outStr, indentLevel);
end