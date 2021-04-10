function generatePotentialFlowDependencies(thisModel)
    % CREATEPOTENTIALFLOWDEPENDENCIES
    
    network = thisModel.network;
    % get twig and chords.
    % NOTE: MsNetwork sets the appropriate flags.
    [twigVec, chordVec] = network.getTwigChordVec();

    % mark potentials and flows as probed according to the probing
    % status of their dependent quantities.
    % For twig potentials, we will look at chord potentials that depend
    % on them and update the twig potential's probe index.
    for twig = twigVec
        twigPotential = twig.getPotential();
        depChordVec = network.getDependentBranch(twig);
        probeIdx = Inf;
        for depChord = depChordVec
            depChordPotential = depChord.getPotential();
            % don't consider this branch if it does not have a probe
            if depChordPotential.isProbe() == true
                newProbeIdx = depChordPotential.getProbeIdx();
                if newProbeIdx < probeIdx
                    probeIdx = newProbeIdx;
                end
            end
        end

        if probeIdx < twigPotential.getProbeIdx()
            twigPotential.setProbe(probeIdx);
        end
    end

    % do the same thing with chords and their flows
    % For chords flows, we will look at twig flows that depend on them
    % and update the chord flow's probe index
    for chord = chordVec
        chordFlow = chord.getFlow();
        depTwigVec = network.getDependentBranch(chord);
        probeIdx = Inf;
        for depTwig = depTwigVec
            depTwigFlow = depTwig.getFlow();
            % don't consider this branch if it does not have a probe
            if depTwigFlow.isProbe() == true
                newProbeIdx = depTwigFlow.getProbeIdx();
                if newProbeIdx < probeIdx
                    probeIdx = newProbeIdx;
                end
            end
        end

        if probeIdx < chordFlow.getProbeIdx()
            chordFlow.setProbe(probeIdx);
        end

    end

    % check if the terminal flow of the reference node is a probe. This
    % can only occur if this flow is explicitely probed.
    refNode = thisModel.refNode;
    refNodeDiscip = refNode.getDisciplineName();
    nodeVec = thisModel.getNodeVec();
    refTermFlow = refNode.getTerminalFlow();
    if refTermFlow.isProbe() == true
        % this will be computed with the sum of all other terminal
        % currents. So we set them as probes.
        probeIdx = refTermFlow.getProbeIdx();
        for nodeObj = nodeVec
            if nodeObj.isTerminal() == true && (nodeObj ~= refNode) && ...
                    strcmp(nodeObj.getDisciplineName(), refNodeDiscip) == true
                termFlowObj = nodeObj.getTerminalFlow();
                termFlowObj.setProbe(probeIdx);
            end
        end
    end
end