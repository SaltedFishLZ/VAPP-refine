function addDependPf(thisDiffable, pfObj)
    thisDiffable.augmentDependPfVec(pfObj);
    thisDiffable.addSubDependency(pfObj);
end