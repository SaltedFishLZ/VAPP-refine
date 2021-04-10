function traverseSub = visitIrNodeAnalogFunction(thisVisitor, afNode)
    traverseSub = false;

    inList = afNode.getInputList();
    outList = afNode.getOutputList();
    funcName = afNode.getName();
    varSfx = thisVisitor.VARSFX;

    derivOutList = {};

    joinNode = IrNodeBlock();
    afParent = afNode.getParent();
    afParent.replaceChild(afNode, joinNode);
    afNode.removeParent();
    joinNode.addChild(afNode);
    
    derivVis = IrVisitorGenerateDerivative([],[]);

    for i = 1:afNode.getNOutput()
        outputName = outList{i};
        for j = 1:afNode.getNInput()
            inputName = inList{j};

            derivOutputName = ['d_', outputName, '_d_' inputName, varSfx];
            derivFuncName = ['d_', funcName, '_d_arg', num2str(j), varSfx];

            derivFuncNode = afNode.copyDeep();
            derivFuncNode.setName(derivFuncName);
            derivFuncNode.setOutputList({derivOutputName});
            % line below will add derivFuncNode to the list of known
            % functions in afNode. But afNode shares this list with the
            % top module. So it will be added there as well.
            afNode.addFunc(derivFuncNode);

            joinNode.addChild(derivFuncNode);
            afParent.addFunc(derivFuncNode);

            derivVis.setDerivVarVec(afNode.getVar(inputName));
            derivVis.traverseChildren(derivFuncNode);

            % here we want to add assignment nodes for the outputs
            % (derivatives in this case). This is necessary because
            % VAPP does not print derivatives that are 0 (in order to
            % save computation time). If a derivative is zero and we do
            % not print it anywhere in the fuction, it will be an
            % unassigned output variable and will cause an error in
            % matlab. This is usually the case for functions that have
            % if/else statements in them.
            outputVar = derivFuncNode.addVar(derivOutputName,...
                                             IrNodeConstant('real', 0));
            outputVarNode = IrNodeVariable(outputVar);

            outputInitNode = IrNodeAssignment();
            outputInitNode.addChild(outputVarNode);
            outputInitNode.addChild(IrNodeConstant('real', 0));

            % now add this assignment to a block
            outputInitJoinNode = IrNodeBlock();
            outputInitJoinNode.setIndentLevel(0);
            outputInitJoinNode.addChild(outputInitNode);
            derivFuncBlockNode = derivFuncNode.getChild(1);
            derivFuncNode.replaceChild(derivFuncBlockNode, outputInitJoinNode);
            outputInitJoinNode.addChild(derivFuncBlockNode);

        end
    end
end