function saveState(thisNetwork)
% SAVESTATE
% save the state of terminalFlows
    for nodeObj = thisNetwork.nodeVec
        if nodeObj.isTerminal() == true
            flowObj = nodeObj.getTerminalFlow();
            flowObj.saveState();
        end
    end

    % save the state of branch potentials/flows
    for branchObj = thisNetwork.branchVec
        potential = branchObj.getPotential();
        flow = branchObj.getFlow();
        potential.saveState();
        flow.saveState();
    end
end