function out = visitIrNodeWhile(thisVisitor, irNode, varargin)
    out = thisVisitor.visitGeneric(irNode, varargin{:});
end