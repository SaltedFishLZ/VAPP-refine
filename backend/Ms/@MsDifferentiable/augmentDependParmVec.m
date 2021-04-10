function augmentDependParmVec(thisDiffable, parmObj)
    % AUGMENTDEPENDPARMVEC
    if thisDiffable.isDependentOnParm(parmObj) == false
        thisDiffable.dependParmVec(end+1) = parmObj;
    end
end