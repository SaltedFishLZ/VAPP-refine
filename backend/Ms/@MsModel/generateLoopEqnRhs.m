function rhsNode = generateLoopEqnRhs(thisModel, branchObj)
    % GENERATELOOPEQNRHS
    
    [defPotentialVec, signVec] = ...
                            thisModel.generateLoopEqnPfVec(branchObj);
    defPotentialNodeVec = IrNodePotentialFlow.empty;
    for defPotential = defPotentialVec
        potentialNode = IrNodePotentialFlow(defPotential);
        defPotentialNodeVec = [defPotentialNodeVec, potentialNode];
    end
    % defPotentialNodeVec can be empty: this happens if a branch is
    % collapsed by proxy, i.e. collapse a_b and b_c => a_c is collapsed
    % by proxy
    if isempty(defPotentialNodeVec)
        rhsNode = IrNodeNumerical.getConstantNode(0);
    else
        rhsNode = IrNodeNumerical.getLinearCombination(...
                                                defPotentialNodeVec,...
                                                signVec);
    end
end
