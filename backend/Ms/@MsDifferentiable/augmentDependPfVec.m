function augmentDependPfVec(thisDiffable, pfObj)
    % AUGMENTDEPENDPFVEC
    if thisDiffable.isDependentOnPf(pfObj) == false
        thisDiffable.dependPfVec(end+1) = pfObj;
    end
end