function rhsNode = generateCutEqnRhsWithTerminalFlows(thisModel, ...
    branchObj)
    % GENERATECUTEQNRHSWITHTERMINALFLOWS
    [defFlowVec, signVec] = ...
    thisModel.generateCutEqnPfVecWithTerminalFlows(branchObj);
    defFlowNodeVec = IrNodePotentialFlow.empty;
    for defFlow = defFlowVec
    flowNode = IrNodePotentialFlow(defFlow);
    defFlowNodeVec = [defFlowNodeVec, flowNode];
    end
    
    % defFlowNodeVec can be empty: this happens if a branch is
    % collapsed by proxy, i.e. collapse a_b and b_c => a_c is collapsed
    % by proxy
    if isempty(defFlowNodeVec)
    rhsNode = IrNodeNumerical.getConstantNode(0);
    else
    rhsNode = IrNodeNumerical.getLinearCombination(...
      defFlowNodeVec,...
      signVec);
    end
end