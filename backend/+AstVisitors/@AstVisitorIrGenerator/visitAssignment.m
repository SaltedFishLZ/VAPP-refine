function out = visitAssignment(thisVisitor, assignNode)
    % Create assignment node, traverse further down the tree.
    out{1} = true;
    aIrNode = IrNodeAssignment();
    aIrNode.setAccessIdx(thisVisitor.getNextAccessIdx());
    out{2} = aIrNode;

end