function traverseSub = visitIrNodeIfElse(thisVisitor, ifElseNode)
    % VISITIRNODEIFELSE mark if-else nodes -> to be used later in node
    % collapse operations.
        traverseSub = false;
        nChild = ifElseNode.getNChild();

        % nChild is at least 2.
        % if nChild == 2 => no else statement
        % if nChild == 3 => else statement

        condNode = ifElseNode.getChild(1);

        condDigger = IrVisitorRhsDigger(condNode);
        condParmVec = condDigger.getParmVec();
        condVarVec = condDigger.getVarVec();

        %pfVec = condDigger.getPfVec();
        %if isempty(pfVec) == false
        %    errorStr = sprintf(['Error in node collapse condition: the',...
        %                        ' condition %s dependens on a bias',...
        %                        ' dependent quantity.\n'], condNode.sprintAll());
        %    errorStr = sprintf([errorStr, 'Dependencies:\n']);
        %    for pfObj = pfVec
        %        errorStr = sprintf([errorStr, pfObj.getLabel(), '\n']);
        %    end
        %    error(errorStr);
        %end


        thenNode = ifElseNode.getChild(2);

        childVisitorThen = IrVisitorNodeCollapse(thenNode);
        thenTreeVec = childVisitorThen.getIfElseTreeVec();
        nestedThenTree = childVisitorThen.getNestedIfElseTree();

        if nChild == 3
            elseNode = ifElseNode.getChild(3);
            childVisitorElse = IrVisitorNodeCollapse(elseNode);
            elseTreeVec = childVisitorElse.getIfElseTreeVec();
            nestedElseTree = childVisitorElse.getNestedIfElseTree();
        else
            elseTreeVec = IrNode.empty;
            nestedElseTree = IrNode.empty;
        end

        condNode = condNode.copyDeep();
        if isempty(thenTreeVec) == true && isempty(elseTreeVec) == false
            condNode = IrNodeNumerical.getNegationOfNode(condNode);
            thenTreeVec = elseTreeVec;
            elseTreeVec = IrNode.empty;
            nestedThenTree = nestedElseTree;
            nestedElseTree = IrNode.empty;
        end

        % at this point there is no chance of the then block being empty
        % while the else block is not.
        ifElseTree = IrNode.empty;
        nestedIfElseTree = IrNode.empty;
        if isempty(thenTreeVec) == false
            for varObj = condVarVec
                varObj.setInNodeCollapse();
            end

            for parmObj = condParmVec
                parmObj.setInNodeCollapse();
            end

            ifElseTree = IrNodeIfElse();
            nestedIfElseTree = IrNodeIfElse();

            ifElseTree.addChild(condNode.copyDeep());
            thenBlock = IrNodeBlock();
            thenBlock.setIndentLevel(0);
            ifElseTree.addChild(thenBlock);
            for thenTree = thenTreeVec
                thenBlock.addChild(thenTree.copyDeep());
            end

            nestedIfElseTree.addChild(condNode.copyDeep());
            nestedIfElseTree.addChild(nestedThenTree);

            if isempty(elseTreeVec) == false
                elseBlock = IrNodeBlock();
                elseBlock.setIndentLevel(0);
                ifElseTree.addChild(elseBlock);
                for elseTree = elseTreeVec
                    elseBlock.addChild(elseTree.copyDeep());
                end

                nestedIfElseTree.addChild(nestedElseTree);
            end
        end

        thisVisitor.ifElseTreeVec = [thisVisitor.ifElseTreeVec, ifElseTree];
        thisVisitor.nestedIfElseTreeVec = ...
                        [thisVisitor.nestedIfElseTreeVec, nestedIfElseTree];
        thisVisitor.ifElseTree = IrNode.empty;
end
