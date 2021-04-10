function traverseSub = visitIrNodeContribution(thisVisitor, contribNode)
    traverseSub = false;

    lhsNode = contribNode.getLhsNode();
    lhsPfObj = lhsNode.getPfObj();
    rhsNode = contribNode.getRhsNode();

    % check if we are in a node collapse statement
    if lhsNode.isPotential() == true && ...
            rhsNode.hasType('IrNodeConstant') && ...
                                (rhsNode.getValue() == 0)
        if isempty(thisVisitor.ifElseTree) == true
            treeBlock = IrNodeBlock();
            treeBlock.setIndentLevel(0);
            thisVisitor.ifElseTree = treeBlock;
        end
        cbNode = IrNodeCollapseBranch(lhsPfObj.getBranch());
        thisVisitor.ifElseTree.addChild(cbNode);
    end
end