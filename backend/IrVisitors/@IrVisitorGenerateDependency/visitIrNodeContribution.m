function traverseSub = visitIrNodeContribution(thisVisitor, contribNode)
    traverseSub = false;

    digger = IrVisitorRhsDigger();
    rhsNode = contribNode.getRhsNode();
    digger.traverseIr(rhsNode);

    lhsNode = contribNode.getLhsNode();
    lhsPfObj = lhsNode.getPfObj();

    thisVisitor.setRhsVecs(digger);

    if contribNode.isImplicit() == false
        thisVisitor.addRhsVecsToDifferentiable(lhsPfObj);

        lhsNode.setDependPfVec(lhsPfObj.getDependPfVec());
        lhsNode.setDependVarVec(lhsPfObj.getDependVarVec());
    else
        tempVarObj = MsVariable();
        thisVisitor.addRhsVecsToDifferentiable(tempVarObj);
        tempPfVec = tempVarObj.getDependPfVec();
        if contribNode.isNullEqn() == false
            % if this contribution is implicit and is not a
            % nullEquation, add the lhs IO to the rhsDependPfVec
            tempPfVec = [tempPfVec, thisVisitor.addRhsDependPf(lhsPfObj)];
        end
        % we have no lhsPfObj. Create a temporary MsVar obj and use its
        % addDependPf/addDependVar functions
        contribNode.setImplicitEqnDependPfVec(tempPfVec);
        contribNode.setImplicitEqnDependVarVec(tempVarObj.getDependVarVec());
    end
end