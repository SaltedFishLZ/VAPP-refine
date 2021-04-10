function  traverseSub = visitIrNodeVariable(thisVisitor, varNode)
    %
    % THIS VISIT METHOD MUST BE IN LOCATED IN THIS VISITOR. DON'T MOVE
    % THIS METHOD. 
    %
    % Variables can be used in assignments/conditionals/contributions
    % the only time when we don't want to mark a variable as used is if
    % it's on the rhs of an assignment. This case is handled by the
    % visitAssignment method above. This means a lhs variable is never
    % visited by this visitor.
    % This visit method only handles conditional statements
    % since assignments and contributions are handled by their own
    % methods.
    traverseSub = true;
    varObj = varNode.getVarObj();
    varObj.setUsed();
end
