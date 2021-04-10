function [loopEqnBlock, cutEqnBlock, collapsedBlock] = generateIoDef(thisModel)
    % GENERATEIODEF generates definition equations for chord potentials and
    % twig flows.
    % A chord potential/twig flow is a dependent variable in the network.
    % It can be written as a linear combination of twig potentials/chord
    % flows. The elements of these linear combinations are determined by
    % the loop/cutset equations of the network.
    % NOTE: In general, lhs nodes of assignments are variables and lhs
    % nodes of contributions are potential/flow nodes. This case is the
    % only exception in VAPP. Here we use an assignment to define a
    % potential/flow because conceptually this is really an assignment and
    % not a contribution. Why? Because we know that all the quantities on
    % the RHS of the assignment are inputs, i.e., internal unknowns or
    % other IOs. They won't have any ddt type contributions. This is a
    % plainly an assignment---not a contribution.

    collapsedBlock = IrNodeBlock(0);
    loopEqnBlock = IrNodeBlock(0);
    cutEqnBlock = IrNodeBlock(0);

    % set collapsed branch potentials/flows to zero
    for branchObj = thisModel.collapsedBranchVec
        lhsPotentialNode = IrNodePotentialFlow(branchObj.getPotential());
        lhsFlowNode = IrNodePotentialFlow(branchObj.getFlow());

        zeroNodePotential = IrNodeNumerical.getConstantNode(0);
        zeroNodeFlow = IrNodeNumerical.getConstantNode(0);

        assignNodePotential = IrNodeAssignment(lhsPotentialNode, ...
                                                    zeroNodePotential);
        assignNodeFlow = IrNodeAssignment(lhsFlowNode, zeroNodeFlow);

        collapsedBlock.addChild(assignNodePotential);
        collapsedBlock.addChild(assignNodeFlow);
    end

    % loop definitions for potentials
    branchVec = thisModel.getBranchVec();
    for branchObj = branchVec
        if branchObj.isChord() == true
            potentialObj = branchObj.getPotential();
            if potentialObj.isProbe() == true
                lhsPotentialNode = IrNodePotentialFlow(potentialObj);
                % call the loop equation generation method of thisModel
                rhsNode = thisModel.generateLoopEqnRhs(branchObj);
                assignNode = IrNodeAssignment(lhsPotentialNode, rhsNode);
                loopEqnBlock.addChild(assignNode);
            end

            if branchObj.isZeroFlow() == true
                flowObj = branchObj.getFlow();
                lhsFlowNode = IrNodePotentialFlow(flowObj);
                zeroNode = IrNodeNumerical.getConstantNode(0);
                assignNode = IrNodeAssignment(lhsFlowNode, zeroNode);
                cutEqnBlock.addChild(assignNode);
            end
        end
    end

    % cut definitions for flows
    for branchObj = branchVec
        if branchObj.isTwig() == true
            flowObj = branchObj.getFlow();
            if flowObj.isProbe() == true
                % call the cut equation generation method of thisModel
                lhsFlowNode = IrNodePotentialFlow(flowObj);
                rhsNode = thisModel.generateCutEqnRhsWithTerminalFlows(branchObj);
                assignNode = IrNodeAssignment(lhsFlowNode, rhsNode);
                cutEqnBlock.addChild(assignNode);
            end
        end
    end

    % KCL for the reference node terminalFlow
    refNode = thisModel.refNode;
    refTermFlowObj = refNode.getTerminalFlow();
    if refTermFlowObj.isProbe() == true
        lhsFlowNode = IrNodePotentialFlow(refTermFlowObj);
        termFlowNodeVec = IrNodePotentialFlow.empty;
        signVec = [];
        nodeVec = thisModel.getNodeVec();
        refNodeDiscip = refNode.getDisciplineName();
        for nodeObj = nodeVec
            if nodeObj.isTerminal() == true && (nodeObj ~= refNode) && ...
                    strcmp(nodeObj.getDisciplineName(), refNodeDiscip) == true
                termFlowObj = nodeObj.getTerminalFlow();
                termFlowNodeVec(end+1) = IrNodePotentialFlow(termFlowObj);
                signVec(end+1) = -1;
            end
        end
        rhsNode = IrNodeNumerical.getLinearCombination(...
                                            termFlowNodeVec, signVec);
        assignNode = IrNodeAssignment(lhsFlowNode, rhsNode);
        cutEqnBlock.addChild(assignNode);
    end
    
end
