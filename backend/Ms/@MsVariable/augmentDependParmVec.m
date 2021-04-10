function augmentDependParmVec(thisVar, parmObj)
    augmentDependParmVec@MsDifferentiable(thisVar, parmObj);
    if thisVar.inNodeCollapse == true
        parmObj.setInNodeCollapse();
    end
end