function out = visitCase_candidates(thisVisitor, ccNode)
    out{1} = true;
    irNode = IrNodeCaseCandidates();
    if ccNode.has_attr('is_default', 'True')
        irNode.setDefault();
    end
    out{2} = irNode;
end