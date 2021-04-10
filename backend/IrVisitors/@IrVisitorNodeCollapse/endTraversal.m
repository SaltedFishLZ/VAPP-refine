function endTraversal(thisVisitor, module)
    module.setNodeCollapseTree(thisVisitor.getNestedIfElseTree);
end