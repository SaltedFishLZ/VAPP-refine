function [defFlowVec, signVec] = generateCutEqnPfVecWithTerminalFlows(...
    thisModel, branchObj)
    network = thisModel.network;
    [defFlowVec, signVec] = thisModel.generateCutEqnPfVec(branchObj);
    % add the terminal currents to the equation
    [cutNodeVec, direction] = network.getCutNodes(branchObj);
    termFlowVec = MsTerminalFlow.empty;
    for nodeObj = cutNodeVec
    if nodeObj.isTerminal() == true
    termFlowVec = [termFlowVec, nodeObj.getTerminalFlow()];
    signVec = [signVec, direction];
    end
    end

    defFlowVec = [defFlowVec, termFlowVec];
end