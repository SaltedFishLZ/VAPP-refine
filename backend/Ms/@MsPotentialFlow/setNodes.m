function setNodes(thisPF, nodeObj1, nodeObj2)
% SETNODES
    thisPF.node1 = nodeObj1;
    thisPF.node2 = nodeObj2;
    if nodeObj1.isConnectedTo(nodeObj2) == true
        branchObj = nodeObj1.getBranch(nodeObj2);
    else
        branchObj = MsBranch(nodeObj1, nodeObj2);
    end
    thisPF.branch = branchObj;
end
