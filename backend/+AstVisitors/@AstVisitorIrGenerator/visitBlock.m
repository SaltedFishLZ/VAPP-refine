function out = visitBlock(thisVisitor, blockNode)
    out{1} = true;
    block = IrNodeBlock();
    block.setIndentLevel(0);
    out{2} = block;
end