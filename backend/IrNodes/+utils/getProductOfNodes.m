function prodNode = getProductOfNodes(irNode1, irNode2)
    prodNode = IrNodeNumerical.joinNodesWithOperation('*', irNode1,...
                                                      irNode2);
end