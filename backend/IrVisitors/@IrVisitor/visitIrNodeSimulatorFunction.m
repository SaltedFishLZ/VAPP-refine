function out = visitIrNodeSimulatorFunction(thisVisitor, irNode, varargin)
    out = thisVisitor.visitGeneric(irNode, varargin{:});
end