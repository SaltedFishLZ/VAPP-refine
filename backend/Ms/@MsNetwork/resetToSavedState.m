function resetToSavedState(thisNetwork)
% RESETTOSAVEDSTATE
    % warning('MsNewtwork: reset to saved state')
    
    % reset the state of terminalFlows
    for nodeObj = thisNetwork.nodeVec
        if nodeObj.isTerminal() == true
            flowObj = nodeObj.getTerminalFlow();
            flowObj.resetToSavedState();
        end
    end

    % reset the state of branch potentials/flows
    for branchObj = thisNetwork.branchVec
        potential = branchObj.getPotential();
        flow = branchObj.getFlow();
        potential.resetToSavedState();
        flow.resetToSavedState();
    end
end