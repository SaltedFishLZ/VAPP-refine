function augmentDependVarVec(thisDiffable, varObj)
    % AUGMENTDEPENDVARVEC
    if thisDiffable.isDependentOnVar(varObj) == false
        thisDiffable.dependVarVec(end+1) = varObj;
    end
end
