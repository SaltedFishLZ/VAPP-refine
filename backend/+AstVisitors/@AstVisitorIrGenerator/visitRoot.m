function out = visitRoot(thisVisitor, rootNode)
    % for now assume that the model has only one module and do nothing
    % here. Just pass the ball on.
    out{1} = false;
    out{2} = thisVisitor.traverseAst(rootNode.get_child(1));
end