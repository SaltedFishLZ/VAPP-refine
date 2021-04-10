function traverseSub = visitIrNodeIfElse(thisVisitor, ifElseNode)
    % VISITIRNODEIFELSE
    traverseSub = false;

    condNode = ifElseNode.getChild(1);
    condDigger = IrVisitorRhsDigger(condNode);

    thenNode = ifElseNode.getChild(2);
    thenDigger = IrVisitorGenerateDependency();
    thenDigger.setIfElseVecs(thisVisitor, condDigger);
    thenDigger.traverseIr(thenNode);

    if ifElseNode.getNChild() > 2
        elseNode = ifElseNode.getChild(3);
        elseDigger = IrVisitorGenerateDependency();
        elseDigger.setIfElseVecs(thisVisitor, condDigger);
        elseDigger.traverseIr(elseNode);
    end
end