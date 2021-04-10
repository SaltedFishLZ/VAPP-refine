function traverseSub = visitIrNodePotentialFlow(thisVisitor, pfNode)
    % VISITIRNODEPOTENTIALFLOW
        traverseSub = false;
        pfObj = pfNode.getPfObj();
        lhsPfObj = thisVisitor.lhsPfObj;
        
        if isempty(lhsPfObj) == false && pfObj == lhsPfObj
            thisVisitor.nMatch = thisVisitor.nMatch + 1;
            thisVisitor.matchedPfNode = pfNode;
        else
            thisVisitor.add2PfVec(pfObj);
        end
end