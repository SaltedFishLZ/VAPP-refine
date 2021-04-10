function addRhsVecsToDifferentiable(thisVisitor, differentiable)
        
    for dependPf = thisVisitor.rhsPfVec
        differentiable.addDependPf(dependPf);
    end

    for dependVar = thisVisitor.rhsVarVec
        differentiable.addDependVar(dependVar);
    end

    for dependParm = thisVisitor.rhsParmVec
        differentiable.addDependParm(dependParm);
    end
    
end