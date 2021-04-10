function branchVec = getOrderedBranchVec(thisNetwork)
% GETORDEREDBRANCHVEC order the branches to generate a spanning tree
%
% This method will generate an ordering of the edges of the network.
% In generating a spanning tree, the edges that come first in this
% ordering will be preferred as spanning tree branches.
%
% NOTE: IrNodeModule produces edges between a terminal and the
% reference node even if it is not there in the Verilog-A code.

    % oder branches of the network
    branchVec = thisNetwork.branchVec;
    collapseBranchVec = MsBranch.empty; % branches that get collapsed
                                        % eventually, i.e., not
                                        % necessarily collapsed now 
    psBranchVec = MsBranch.empty; % potential source branches
    refBranchVec = MsBranch.empty; % reference branches
    indRefBranchVec = MsBranch.empty; % inductive reference branches
    capRefBranchVec = MsBranch.empty; % capacitive reference branches
    remRefBranchVec = MsBranch.empty; % remaining reference branches
    indOuterBranchVec = MsBranch.empty; % inductive terminal branches branches
    capOuterBranchVec = MsBranch.empty; % capacitive terminal branches branches
    remOuterBranchVec = MsBranch.empty; % remaining terminal branches branches
    capBranchVec = MsBranch.empty; % capacitive branches
    indBranchVec = MsBranch.empty; % inductive branches
    fsBranchVec = MsBranch.empty; % flow source branches
    remBranchVec = MsBranch.empty; % remaining branches (no contrib
                                   % reference branches)

    refNode = thisNetwork.refNode;
    if isempty(refNode)
        error(['Error ordering branch vector: this network does ',...
               'not have a reference node!']);
    end

    for branchObj = branchVec
        potential = branchObj.getPotential();
        flow = branchObj.getFlow();

        %if branchObj.isToBeCollapsed() == true
        %    collapseBranchVec = [collapseBranchVec, branchObj];
        if branchObj.isReference() == true
            refBranchVec = [refBranchVec, branchObj];
            if flow.isContrib() == true
                capRefBranchVec = [capRefBranchVec, branchObj];
            elseif potential.isContrib() == true
                indRefBranchVec = [indRefBranchVec, branchObj];
            else
                remRefBranchVec = [remRefBranchVec, branchObj];
            end
        elseif branchObj.isOuter() == true
            if flow.isContrib() == true
                capOuterBranchVec = [capOuterBranchVec, branchObj];
            elseif potential.isContrib() == true
                indOuterBranchVec = [indOuterBranchVec, branchObj];
            else
                remOuterBranchVec = [remOuterBranchVec, branchObj];
            end
        elseif potential.isSource() == true
            psBranchVec = [psBranchVec, branchObj];
        elseif flow.isContrib() == true
            capBranchVec = [capBranchVec, branchObj];
        elseif potential.isContrib() == true
            indBranchVec = [indBranchVec, branchObj];
        elseif flow.isSource() == true
            fsBranchVec = [fsBranchVec, branchObj];
        else
            remBranchVec = [remBranchVec, branchObj];
        end
    end

    % More ordering rules: 
    % 1. twigs should be ordered from earlier potential contrib to
    %    later. And from latest flow probe to earliest.
    % 2. chords should be ordered from earliest flow contrib to latest.
    %    And from latest potential probe to earliest

    % this ordering determines which branches will be preferred in
    % assigning twigs/chords.
    % our choice here should vary the number of internal unks that is
    % produced at the end but shouldn't interfere with the fundamental
    % algorithm. I.e., it shouldn't crash anything.
    branchVec =  [...
                  collapseBranchVec,...
                  psBranchVec,...
                  indRefBranchVec,...
                  capRefBranchVec,...
                  remRefBranchVec,...
                  indOuterBranchVec,...
                  indBranchVec,...
                  capOuterBranchVec,...
                  capBranchVec,...
                  remOuterBranchVec,...
                  remBranchVec,...
                  fsBranchVec,...
                 ];
    % NOTE: in the above ordering, we always prefer inductive branches
    % as twigs. Note that for reference branches, remaining branches
    % come before capacitive branches. This is because we allow
    % reference branches to be zero-flow (i.e., without a
    % contribution).rFor other branches we 
end