function traverseChildren(thisVisitor, astNode, irNode)
    nChild = astNode.get_num_children();
    for i=1:nChild
        childTree = thisVisitor.traverseAst(astNode.get_child(i));
        if isempty(childTree) == false
            irNode.addChild(childTree);
        end
    end
end