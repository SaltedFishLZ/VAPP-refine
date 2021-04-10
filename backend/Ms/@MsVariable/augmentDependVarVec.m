function augmentDependVarVec(thisVar, varObj)
    augmentDependVarVec@MsDifferentiable(thisVar, varObj);
    if thisVar.inNodeCollapse == true
        varObj.setInNodeCollapse();
    end
end