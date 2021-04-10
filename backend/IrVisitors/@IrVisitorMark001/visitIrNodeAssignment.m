function traverseSub = visitIrNodeAssignment(thisVisitor, assignNode)
    traverseSub = false;
    % if I set this to true, I must handle the statements below that
    % call setUsed for rhs variables

    accessIdx = assignNode.getAccessIdx();

    rhsNode = assignNode.getRhsNode();
    digger = IrVisitorRhsDigger(rhsNode);

    % Note that it is important to first set the rhs vars as used before
    % setting the lhs var as initialized.
    rhsVarVec = digger.getVarVec();

    for varObj = rhsVarVec
        varObj.setUsed();
    end

    lhsNode = assignNode.getLhsNode();
    lhsVarObj = lhsNode.getVarObj();
    lhsVarObj.setInit();

    rhsPfVec = digger.getPfVec();
    for pfObj = rhsPfVec
        pfObj.setProbe(accessIdx);
    end

end