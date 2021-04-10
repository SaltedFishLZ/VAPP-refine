function [A, branchVec] = getIncidenceMatrix(thisNetwork)
% INCIDENCEMATRIX generates the incidence matrix for this network
%
% This function has a single input argument: the reference node.
%
% The incidence matrix of a network is a rectangular matrix of size NxM
% where N is the number of nodes and M is the number of branches.
%
% A(i,j) = 1 if branch j goes out of node i
% A(i,j) = -1 if branch j goes into node i
% A(i,j) = 0 if branch j is not connected to node i
%
% When generating A, the order of the branches are important because
% the tree generation algorithms in which we will use A as a parameter
% will generate different trees for different orderings of branches in
% the network.
%
% The default ordering of branches for this function will be the
% following:
% 1. branches of the reference node
% 2. branches with potential sources
% 3. branches with flow contributions (capacitive-resistive branches)
% 4. branches with potential contributions (inductive-resistive branches)
% 5. branches with flow sources

    branchVec = thisNetwork.getOrderedBranchVec();
    nodeVec = thisNetwork.nodeVec;
    % remove the reference node
    refNode = thisNetwork.refNode;
    nodeVec(nodeVec == refNode) = [];

    nNode = numel(nodeVec); % = thisNetwork.nNode-1
    nBranch = numel(branchVec);

    A = zeros(nNode, nBranch);

    for j = 1:nBranch
        for i = 1:nNode
            A(i,j) = branchVec(j).getIncidenceCoeff(nodeVec(i));
        end
    end

    % iterate over all branches and collapse the corresponding column
    % of the incidence matrix if the branch has its collapsed flag set
    columnIdx = 1;
    branchIdx = 1;
    collapsedBranchIdxVec = [];
    while branchIdx <= nBranch
        branchObj = branchVec(branchIdx);
        if branchObj.isCollapsed() == true
            % Now we want to delete one of the rows that correspond to
            % the nodes that were collapsed together.
            % Here the information in A is not enough; we need one
            % additional piece of information: is one of the nodes a
            % terminal. If one of the nodes is a terminal, we want to
            % delete the other node.
            % First, find the node indices
            firstNodeIdx = find(A(:, columnIdx) == 1);
            if isempty(firstNodeIdx)
                firstNodeIdx = 0;
                firstNode = refNode;
            else
                firstNode = nodeVec(firstNodeIdx);
            end

            secondNodeIdx = find(A(:, columnIdx) == -1);
            if isempty(secondNodeIdx)
                secondNodeIdx = 0;
                secondNode = refNode;
            else
                secondNode = nodeVec(secondNodeIdx);
            end

            % sort the nodes (the first node will be the remaining
            % node, the second node will be deleted).
            if secondNodeIdx < firstNodeIdx
                tempIdx = firstNodeIdx;
                tempNode = firstNode;
                firstNodeIdx = secondNodeIdx;
                firstNode = secondNode;
                secondNodeIdx = tempIdx;
                secondNode = tempNode;
            end
            % At this stage, secondNode cannot be the reference node.

            % Now we want to "collapse" the incidence matrix:
            % If firstNode is the reference node, all we have to do is
            % to delete the second row. If not, we add the second row
            % to the first one and then delete it.
            % Here is the different situations that can occur:
            % 1. firstNode == secondNode: possible if other branches
            %    have been collapsed earlier that led to the collapse
            %    of the current branchObj, i.e., collapse by proxy. In
            %    this case we don't do anything.

            if firstNodeIdx ~= secondNodeIdx
                if firstNodeIdx == 0
                    % 2. firstNode is the ground node. Because of the
                    %    collapse, the second node becomes ground as
                    %    well -> simply delete the row with the
                    %    secondNodeIdx.
                    A(secondNodeIdx, :) = [];
                else
                    % 3. none of the nodes is the reference node. check
                    %    if one of them is a terminal or not (both
                    %    cannot be terminals at the same time because
                    %    we don't allow collapsing a branch with two
                    %    terminal nodes).
                    if firstNode.isTerminal() == true
                        % add the second row to the first and delete the
                        % second row
                        A(firstNodeIdx, :) = A(firstNodeIdx, :) + ...
                                                    A(secondNodeIdx, :);
                        A(secondNodeIdx, :) = [];
                    else
                        % do the opposite
                        A(secondNodeIdx, :) = A(secondNodeIdx, :) + ...
                                                    A(firstNodeIdx, :);
                        A(firstNodeIdx, :) = [];
                    end

                end
            end
            % delete the column corresponding to the collapsed branch
            A(:, columnIdx) = [];
            collapsedBranchIdxVec = [collapsedBranchIdxVec, branchIdx];
        else
            columnIdx = columnIdx + 1;
        end
        branchIdx = branchIdx + 1;
    end

    thisNetwork.collapsedBranchIdxVec = collapsedBranchIdxVec;
    branchVec(collapsedBranchIdxVec) = [];
end