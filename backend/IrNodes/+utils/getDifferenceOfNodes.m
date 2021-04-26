function minusNode = getDifferenceOfNodes(irNode1, irNode2)
% GETNEGATIVEOFNODE
    minusNode = IrNodeNumerical.joinNodesWithOperation('-', irNode1,...
                                                       irNode2);
end