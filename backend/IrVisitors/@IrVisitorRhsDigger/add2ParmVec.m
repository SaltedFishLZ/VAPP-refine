function add2ParmVec(thisVisitor, parmObj)
    if all(thisVisitor.parmVec ~= parmObj)
        thisVisitor.parmVec = [thisVisitor.parmVec, parmObj];
    end
end