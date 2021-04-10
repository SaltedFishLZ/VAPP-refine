function traverseSub = visitIrNodeIfElse(thisVisitor, ifElseNode)
    % VISITIRNODEIFELSE
        traverseSub = false;
        subTree = thisVisitor.subTree;
        thisVisitor.foundNestedIfElse = true;

        % ifElseNode has at least two nodes
        condNode = ifElseNode.getChild(1);
        thenNode = ifElseNode.getChild(2);
        
        thenVisitor = IrVisitorNestIfElseTree(thenNode, subTree);

        if thenVisitor.foundNestedIfElse == false
            if isempty(subTree) == false
                thenNode.addChild(subTree.copyDeep());
            end
        end

        if ifElseNode.getNChild() > 2
            elseNode = ifElseNode.getChild(3);
            elseVisitor = IrVisitorNestIfElseTree(elseNode, subTree);

            if elseVisitor.foundNestedIfElse == false
                if isempty(subTree) == false
                    elseNode.addChild(subTree.copyDeep());
                end
            end
        else
            elseNode = IrNodeBlock(0);
            ifElseNode.addChild(elseNode);
            if isempty(subTree) == false
                elseNode.addChild(subTree.copyDeep());
            end
        end
end