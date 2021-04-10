function setBranch(thisFlow, branchObj)
    setBranch@MsPotentialFlow(thisFlow, branchObj);
    nature = branchObj.getFlowNature();
    thisFlow.nature = nature;
    thisFlow.labelPrefix = lower(nature.access);
end