function joinNode = joinNodesWithOperation(opStr, varargin)
    nChild = nargin - 1;
    joinNode = IrNodeOperation(opStr);
    for i = 1:nChild
        joinNode.addChild(varargin{i});
    end
end