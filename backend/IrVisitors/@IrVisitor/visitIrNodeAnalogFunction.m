function out = visitIrNodeAnalogFunction(thisVisitor, irNode, varargin)
    out = thisVisitor.visitGeneric(irNode, varargin{:});
end