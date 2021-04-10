function addDependVar(thisVar, varObj)
    addDependVar@MsDifferentiable(thisVar, varObj);
    if thisVar.inNodeCollapse == true
        varObj.setInNodeCollapse();
    end
end