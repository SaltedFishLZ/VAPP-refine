function add2PfVec(thisVisitor, pfObj)
    if all(thisVisitor.pfVec ~= pfObj)
        thisVisitor.pfVec = [thisVisitor.pfVec, pfObj];
    end
end