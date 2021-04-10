function determineExpOutIntUnk(thisModel)
    % determine explicit outputs and internal unknowns
    nodeVec = thisModel.getNodeVec();
    branchVec = thisModel.getBranchVec();
    refNodeLabel = thisModel.refNode.getLabel();

    expOutPotentialVec = MsPotential.empty;
    expOutFlowVec = MsTerminalFlow.empty; % flows of terminals can be exp outs
    intUnkPotentialVec = MsPotential.empty;
    intUnkFlowVec = MsFlow.empty;
    otherIoPotentialVec = MsPotential.empty;
    otherIoFlowVec = MsTerminalFlow.empty;


    % we want the expOutPfVec to contain explicit outputs and other IOs
    % in a sorted manner. 
    % The sorting is based on the node order given to the module in
    % setTerminalList
    for node = nodeVec
        if node.isTerminal() == true && node.isReference() == false
            % get the branch from terminal node to the ref node
            branchLabel = [node.getLabel(), refNodeLabel];
            branch = thisModel.getBranch(branchLabel);
            potential = branch.getPotential();
            if potential.isExpOut() == true
                expOutPotentialVec = [expOutPotentialVec, potential];
            else
                otherIoPotentialVec = [otherIoPotentialVec, potential];
            end

            flow = branch.getFlow();

            % note that the flow on a terminal-to-reference branch
            % cannot be an explicit output or an other IO.
            if flow.isIntUnk() == true
                intUnkFlowVec = [intUnkFlowVec, flow];
            end

            % determine which of the external flows to terminals are
            % explicit outs
            terminalFlow = node.getTerminalFlow();
            if terminalFlow.isExpOut() == true
                expOutFlowVec = [expOutFlowVec, terminalFlow];
            else
                otherIoFlowVec = [otherIoFlowVec, terminalFlow];
            end
        end
    end

    for branch = branchVec
        % NOTE: here we loop over reference branches as well but the
        % potentials on those branches cannot be internalUnks. See
        % MsPoetential.isIntUnk.
        if branch.isTwig() == true
            potential = branch.getPotential();
            if potential.isIntUnk() == true
                intUnkPotentialVec = [intUnkPotentialVec, potential];
            end
        else
            % branch is a chord
            flow = branch.getFlow();
            if flow.isIntUnk() == true
                intUnkFlowVec = [intUnkFlowVec, flow];
            end
        end
    end

    thisModel.expOutPotentialVec = expOutPotentialVec;
    thisModel.expOutFlowVec = expOutFlowVec;
    thisModel.intUnkPotentialVec = intUnkPotentialVec;
    thisModel.intUnkFlowVec = intUnkFlowVec;
    thisModel.otherIoPotentialVec = otherIoPotentialVec;
    thisModel.otherIoFlowVec = otherIoFlowVec;
    thisModel.expOutPfVec = [expOutPotentialVec, expOutFlowVec];
    thisModel.intUnkPfVec = [intUnkPotentialVec, intUnkFlowVec];
    thisModel.otherIoPfVec = [otherIoPotentialVec, otherIoFlowVec];

    
    thisModel.nExpOut = numel(thisModel.expOutPfVec);
    thisModel.nIntUnk = numel(thisModel.intUnkPfVec);
    thisModel.nOtherIo = numel(thisModel.otherIoPfVec);
    % nFiQi has to be determined after implicit equations are factored
    % in.
end
