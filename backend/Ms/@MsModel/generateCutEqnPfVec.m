function [defFlowVec, signVec] = generateCutEqnPfVec(thisModel, branchObj)
    network = thisModel.network;
    [defBranchVec, signVec] = network.getCutDef(branchObj);
    defFlowVec = MsFlow.empty;
    for defBranch = defBranchVec
        defFlowVec = [defFlowVec, defBranch.getFlow()];
    end
end