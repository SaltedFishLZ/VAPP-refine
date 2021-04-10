function out = visitContribution(thisVisitor, contribNode)
    out{1} = true;
    accessIdx = thisVisitor.getNextAccessIdx();
    cIrNode = IrNodeContribution();
    cIrNode.setAccessIdx(accessIdx);
    out{2} = cIrNode;
end