function setBranch(thisPF, branchObj)
% SETBRANCH
    thisPF.branch = branchObj;
    [nodeObj1, nodeObj2] = branchObj.getNodes();
    thisPF.node1 = nodeObj1;
    thisPF.node2 = nodeObj2;
end