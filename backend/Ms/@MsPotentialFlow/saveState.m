function saveState(thisPf)
% SAVESTATE
    if isempty(thisPf.savedState) == true
        savedState = struct();
        savedState.contrib = thisPf.contrib;
        savedState.probe = thisPf.probe;
        savedState.source= thisPf.source;
        savedState.contribAfterProbe = thisPf.contribAfterProbe;
        savedState.inImplicitEqn = thisPf.inImplicitEqn;
        savedState.contribIdx = thisPf.contribIdx;
        savedState.probeIdx = thisPf.probeIdx;
        savedState.outIdx = thisPf.outIdx;
        savedState.inIdx = thisPf.inIdx;
        thisPf.savedState = savedState;
    else
        error(['Error trying to save the contrib/probe status of',...
               ' the potential/flow %s. This potential/flow has',...
               ' already a saved state.'], thisPf.getLabel());
    end
end
