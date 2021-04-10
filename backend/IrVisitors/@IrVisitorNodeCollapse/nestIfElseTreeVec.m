function nestIfElseTreeVec(thisVisitor)
    % NESTIFELSETREES
        nestedIfElseTreeVec = [thisVisitor.nestedIfElseTreeVec, ...
                                                    thisVisitor.ifElseTree];

        nTree = numel(nestedIfElseTreeVec);

        if nTree > 0
            %innerTree = IrNodeBlock();
            %innerTree.setIndentLevel(0);
            %innerTree.addChild(nestedIfElseTreeVec(nTree).copyDeep());
            innerTree = IrNode.empty;
            for i = nTree:-1:1
                outerTree = nestedIfElseTreeVec(i).copyDeep();
                IrVisitorNestIfElseTree(outerTree, innerTree);

                innerTree = outerTree;
            end

            thisVisitor.nestedIfElseTree = innerTree;
        end
end