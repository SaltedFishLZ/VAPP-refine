function [expOutPotentialEqnBlock, expOutFlowEqnBlock] = generateExpOutEqn(thisModel)
    % GENERATEEXPOUTEQN
    expOutPotentialEqnBlock = IrNodeBlock();
    expOutPotentialEqnBlock.setIndentLevel(0);
    expOutFlowEqnBlock = IrNodeBlock();
    expOutFlowEqnBlock.setIndentLevel(0);
    expOutIdx = 0;

    for potential = thisModel.expOutPotentialVec
        outNode = IrNodeOutput(potential);
        expOutIdx = expOutIdx + 1;
        outNode.setOutIdx(expOutIdx);
        lhsNode = IrNodeNumericalNull();

        if potential.isContrib() == true
            rhsPfVec = potential;
            signVec = 1;
        else
            chord = potential.getBranch();
            [rhsPfVec, signVec] = thisModel.generateLoopEqnPfVec(chord);
        end

        outNode.addChild(lhsNode);
        outNode.setRhsPfVec(rhsPfVec);
        outNode.setRhsSignVec(signVec);
        expOutPotentialEqnBlock.addChild(outNode);
        thisModel.nFeQe = thisModel.nFeQe + 1;
    end

    for flow = thisModel.expOutFlowVec
        % a terminal flow cannot have a contribution
        terminal = flow.getTerminal();
        twig = terminal.getBranch(thisModel.refNode);
        outNode = IrNodeOutput(flow);
        expOutIdx = expOutIdx + 1;
        outNode.setOutIdx(expOutIdx);

        [rhsPfVec, signVec] = thisModel.generateCutEqnPfVecWithTerminalFlows(twig);
        if twig.isZeroFlow() == true
            lhsNode = IrNodeNumericalNull();
        else
            lhsNode = IrNodePotentialFlow(twig.getFlow());
            lhsNode.setInverse();
            lhsNode.setLhs();
        end
        selfIdx = (rhsPfVec == flow);
        rhsPfVec(selfIdx) = [];
        signVec(selfIdx) = [];
        % because in ModSpec terminal flows are going into the terminal
        % get the negative of signVec;
        signVec = -signVec;
        outNode.addChild(lhsNode);
        outNode.setRhsPfVec(rhsPfVec);
        outNode.setRhsSignVec(signVec);

        expOutFlowEqnBlock.addChild(outNode);
        thisModel.nFeQe = thisModel.nFeQe + 1;
    end
end