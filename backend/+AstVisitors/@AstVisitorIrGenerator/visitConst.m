function out = visitConst(thisVisitor, constNode)
    out{1} = false;
    dataType = constNode.get_attr('dtype');
    value = constNode.get_attr('value');
    out{2} = IrNodeConstant(dataType, value);
end