function addSubDependency(thisDiffable, otherDiffable)
    % ADDSUBDEPENDEN

    for pfObj = otherDiffable.getDependPfVec()
        thisDiffable.augmentDependPfVec(pfObj);
    end

    for varObj = otherDiffable.getDependVarVec()
        thisDiffable.augmentDependVarVec(varObj);
    end

    for parmObj = otherDiffable.getDependParmVec()
        thisDiffable.augmentDependParmVec(parmObj);
    end
end