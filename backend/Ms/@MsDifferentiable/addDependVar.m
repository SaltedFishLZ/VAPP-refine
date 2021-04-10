function addDependVar(thisDiffable, varObj)
    thisDiffable.augmentDependVarVec(varObj);
    thisDiffable.addSubDependency(varObj);
end