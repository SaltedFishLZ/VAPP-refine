function traverseSub = visitIrNodeAssignment(thisVisitor, assignNode)
    traverseSub = false;

    % first generate dependency structure using diggers
    % This cannot be done in IrVisitorMark1 because we need information
    % about independent variables (i.e., which IOs are explicitOuts etc).

    digger = IrVisitorRhsDigger();
    rhsNode = assignNode.getRhsNode();
    digger.traverseIr(rhsNode);

    lhsNode = assignNode.getLhsNode();
    lhsVarObj = lhsNode.getVarObj();

    thisVisitor.setRhsVecs(digger);
    thisVisitor.addRhsVecsToDifferentiable(lhsVarObj);

    % once we add the dependencies to lhsVarObj, lhsVarObj will contain
    % all the dependecies of the objects in digger.varVec and
    % digger.PfVec. So we can just copy them over to the node.
    lhsNode.setDependPfVec(lhsVarObj.getDependPfVec());
    lhsNode.setDependVarVec(lhsVarObj.getDependVarVec());
end