function add2VarVec(thisVisitor, varObj)
    if all(thisVisitor.varVec ~= varObj)
        thisVisitor.varVec = [thisVisitor.varVec, varObj];
    end
end