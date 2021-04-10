function [defPotentialVec, signVec] = generateLoopEqnPfVec(thisModel, branchObj)
            
    network = thisModel.network;
    [defBranchVec, signVec] = network.getLoopDef(branchObj);
    defPotentialVec = MsPotential.empty;
    for defBranch = defBranchVec
        defPotentialVec = [defPotentialVec, defBranch.getPotential()];
    end
end