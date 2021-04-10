function addNode(thisNetwork, nodeObj)
% ADDNODE
    if thisNetwork.hasNode(nodeObj) == false
        thisNetwork.nodeVec = [thisNetwork.nodeVec, nodeObj];

        nodeObj.setNetwork(thisNetwork);

        branchVec = nodeObj.getBranchVec();

        for branchObj = branchVec
            thisNetwork.addBranch(branchObj);
        end
    end
end