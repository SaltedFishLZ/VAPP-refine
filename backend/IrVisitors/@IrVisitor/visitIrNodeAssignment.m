function out = visitIrNodeAssignment(thisVisitor, irNode, varargin)
    out = thisVisitor.visitGeneric(irNode, varargin{:});
end