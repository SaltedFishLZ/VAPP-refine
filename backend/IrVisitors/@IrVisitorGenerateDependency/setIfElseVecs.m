
function setIfElseVecs(thisVisitor, parentVisitor, digger)
    % SETIFELSEVEC
    thisVisitor.ifElseVarVec  = [parentVisitor.ifElseVarVec, ...
                                                  digger.getVarVec()];
    thisVisitor.ifElsePfVec   = [parentVisitor.ifElsePfVec, ...
                                                   digger.getPfVec()];
    thisVisitor.ifElseParmVec = [parentVisitor.ifElseParmVec, ...
                                                 digger.getParmVec()];
end