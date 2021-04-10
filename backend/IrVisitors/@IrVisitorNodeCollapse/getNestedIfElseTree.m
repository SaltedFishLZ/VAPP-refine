function nestedTree = getNestedIfElseTree(thisVisitor)
    % GETNESTEDTREEVEC
        if isempty(thisVisitor.nestedIfElseTree)
            thisVisitor.nestIfElseTreeVec();
        end
        nestedTree = thisVisitor.nestedIfElseTree;
end