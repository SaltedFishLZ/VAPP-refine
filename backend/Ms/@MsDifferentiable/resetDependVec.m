function resetDependVec(thisDiffable)
    % RESETDEPENDVEC
    thisDiffable.dependPfVec = MsPotential.empty;
    thisDiffable.dependVarVec = MsVariable.empty;
    thisDiffable.dependParmVec = MsParameter.empty;
end