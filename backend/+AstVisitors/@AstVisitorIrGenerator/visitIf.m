function out = visitIf(thisVisitor, ifNode)
    % create if/else node, traverse further.
    out{1} = true;
    out{2} = IrNodeIfElse();
end