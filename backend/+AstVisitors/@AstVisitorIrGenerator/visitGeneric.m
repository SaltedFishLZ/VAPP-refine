function out = visitGeneric(thisVisitor, astNode)
    out{1} = true;
    out{2} = IrNode();
    % the warning below should tell the programmer that a specific
    % IrNode for the astNode is missing and a generic one is being
    % created that will do nothing but pass the ball on when it gets
    % visited by an IrVisitor object.
    warning('IrGen: Created generic node for %s: %s!', astNode.get_type())
end