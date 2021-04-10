function traverseIr(thisVisitor, irNode)
    % by default we don't use the varargin. Let the individual classes
    % use it if they need it.

    % traverse the tree recursively and visit every node
    traverseSub = irNode.acceptVisitor(thisVisitor);

    if traverseSub == true
        thisVisitor.traverseChildren(irNode);
    end

    if irNode.isModule() == true
        thisVisitor.endTraversal(irNode);
    end
end