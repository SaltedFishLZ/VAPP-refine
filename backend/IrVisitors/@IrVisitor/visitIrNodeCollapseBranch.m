function out = visitIrNodeCollapseBranch(thisVisitor, irNode, varargin)
    out = thisVisitor.visitGeneric(irNode, varargin{:});
end
