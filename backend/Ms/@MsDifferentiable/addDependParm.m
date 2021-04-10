function addDependParm(thisDiffable, parmObj)
    % ADDDEPENDPARM
    thisDiffable.augmentDependParmVec(parmObj);
    for depParmObj = parmObj.getDependParmVec()
        thisDiffable.augmentDependParmVec(depParmObj);
    end
end