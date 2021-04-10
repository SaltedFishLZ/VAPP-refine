function irTree = traverseAst(thisVisitor, astRoot)
    nChild = astRoot.get_num_children();

    out = astRoot.accept_visitor(thisVisitor);
    traverseSub = out{1};
    irTree = out{2};

    if isempty(irTree) == false
        irTree.setPosition(astRoot.get_pos());
    end

    if traverseSub == true
        thisVisitor.traverseChildren(astRoot, irTree);
    end

    if astRoot.has_type('root')
        thisVisitor.endTraversal();
    end
end