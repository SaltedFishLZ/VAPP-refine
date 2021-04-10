function out = visitOp(thisVisitor, opNode)
    out{1} = true;
    opType = opNode.get_attr('op');
    out{2} = IrNodeOperation(opType);
end