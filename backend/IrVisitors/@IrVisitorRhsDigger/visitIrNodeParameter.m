function traverseSub = visitIrNodeParameter(thisVisitor, parmNode)
    % VISITIRNODEPARAMETER
        traverseSub = false;
        parmObj = parmNode.getParmObj();
        thisVisitor.add2ParmVec(parmObj);
end