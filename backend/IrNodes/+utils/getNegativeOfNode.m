function uMinusNode = getNegativeOfNode(irNode)
% GETNEGATIVEOFNODE
    if isa(irNode, 'IrNodeNumerical') == false
        error(['This node cannot be used in the getNegativeOfNode ',...
            'function because it is not of class IrNodeNumerical!']);
    end
    
    uMinusNode = IrNodeOperation('u-');
    uMinusNode.addChild(irNode);
end