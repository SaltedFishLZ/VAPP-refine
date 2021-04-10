function addDependParm(thisVar, parmObj)
    addDependParm@MsDifferentiable(thisVar, parmObj);
    if thisVar.inNodeCollapse == true
        parmObj.setInNodeCollapse();
    end
end