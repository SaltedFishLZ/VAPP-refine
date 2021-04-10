function resetToSavedState(thisPf)
% RESETTOSAVEDSTATE
    if isempty(thisPf.savedState)
        error(['Error trying to reset the state of the',...
               ' potential/flow %s. This potential/flow does not',...
               ' have a saved state!'], thisPf.getLabel());
    else
        savedState = thisPf.savedState;
        thisPf.contrib           = savedState.contrib;
        thisPf.probe             = savedState.probe;
        thisPf.source            = savedState.source;
        thisPf.contribAfterProbe = savedState.contribAfterProbe;
        thisPf.inImplicitEqn     = savedState.inImplicitEqn;
        thisPf.contribIdx        = savedState.contribIdx;
        thisPf.probeIdx          = savedState.probeIdx;
        thisPf.outIdx            = savedState.outIdx;
        thisPf.inIdx             = savedState.inIdx;
    end
end
