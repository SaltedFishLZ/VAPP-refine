function otherIoEqnBlock = generateOtherIoEqn(thisModel)
    % GENERATEOTHERIOEQN
    % below we generate fi/qi outputs for otherIOs.
    % There is only one scenario where we have to supply an extra
    % equation for otherIOs: if a branch voltage is an otherIO AND the
    % terminalFlow to the non-reference node (terminal) of that branch
    % is an otherIO as well.
    % In cases where only one of them is an otherIO (i.e., the other
    % one is an explicit output), the required equation is supplied by
    % the explicit output.
    %
    % Now, for a potential to be an otherIO, it has to be a twig (see
    % the MsPotential.isOtherIO method). There are three possible cases
    % after this.
    %
    % 1. The twig has no potential contribution
    %    1.1. twig has flow contribution
    %    1.2. twig has no flow contribution either
    % 2. twig has potential contribution + potential probe
    %
    % These cases are handle in the following manner:
    % 1.1 -> write down constitutive equation for twig flow.
    % 1.2 -> not applicable because in this case the terminal flow is
    %        not an otherIO. It is an explicitOut.
    % 2.  -> write down constitutive equation for twig potential

    intEqnIdx = thisModel.intEqnIdx;
    intEqnNameList = {};
    otherIoEqnBlock = IrNodeBlock();
    otherIoEqnBlock.setIndentLevel(0); 

    for pfObj = thisModel.otherIoPotentialVec
        potential = pfObj;
        branch = potential.getBranch();
        flow = branch.getFlow();
        % here we get the terminal flow that is associated with this
        % outer potential
        terminal = branch.getTerminalNode();
        terminalFlow = terminal.getTerminalFlow();

        if terminalFlow.isOtherIo() == true
            outNode = IrNodeOutput(terminalFlow);
            intEqnIdx = intEqnIdx + 1;
            outNode.setOutIdx(intEqnIdx);
            % if the terminalFlow is an otherIO that means that
            % branch here is not a nullFlow branch. That means we
            % either have a potential contribution for it or a flow
            % contribution. If this is not the case we will receive an
            % ERROR below.
            if potential.isContrib()
                % write down constitutive equation for twig potential
                intEqnName = ['constitutive equation for ', ...
                                                potential.getLabel()];
                lhsNode = IrNodePotentialFlow(potential);
                lhsNode.setLhs();
                rhsPfVec = potential;
                signVec = 1;
                % the line below is no typo. We really set the rhsNode as
                % lhs. For an explanation see the comment immediately
                % above.
            elseif flow.isContrib()
                % write down cutset equation for twig flow
                intEqnName = ['KCL for ', flow.getLabel()];
                lhsNode = IrNodePotentialFlow(flow);
                lhsNode.setLhs();
                [rhsPfVec, signVec] = ...
                thisModel.generateCutEqnPfVecWithTerminalFlows(branch);
            else
                intEqnName = ['KCL for ', flow.getLabel()];
                lhsNode = IrNodeNumericalNull();
                [rhsPfVec, signVec] = ...
                thisModel.generateCutEqnPfVecWithTerminalFlows(branch);
            end

            outNode.addChild(lhsNode);
            outNode.setRhsPfVec(rhsPfVec);
            outNode.setRhsSignVec(signVec);
            otherIoEqnBlock.addChild(outNode);

            intEqnNameList = [intEqnNameList, {intEqnName}];
            thisModel.nFiQi = thisModel.nFiQi + 1;
        end
    end

    thisModel.intEqnIdx = intEqnIdx;
    thisModel.intEqnNameList = [thisModel.intEqnNameList, intEqnNameList];
end
