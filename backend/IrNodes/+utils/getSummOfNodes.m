function summNode = getSummOfNodes(irNode1, irNode2)
    summNode = IrNodeNumerical.joinNodesWithOperation('+', irNode1,...
                                                      irNode2);
end