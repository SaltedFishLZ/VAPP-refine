function setBranch(thisPotential, branchObj)
    setBranch@MsPotentialFlow(thisPotential, branchObj);
    nature = branchObj.getPotentialNature();
    thisPotential.nature = nature;
    thisPotential.labelPrefix = lower(nature.access);
end