classdef MsNetwork < handle
% MSNETWORK represents the topology (nodes/branches) of a ModSpec device
%
% MsNetwork will implement various ways of mapping Verilog-A contributions onto
% ModSpec IOs. We will use a graph theoretic approach to accomplish this. Since
% nodes and branches of the network are already given to us, there remain two
% important questions in determining the ModSpec IOs:
%
% 1. Which spanning tree do we choose?
% 2. Which IO (explicit output, internal unknown or other IO) do we assign to a
% tree branch or a chord of the spanning tree?
%
% If we see a contribution such as
%
%       I(p,i) <+ f(V(p,i))
%
% There are two canonical ways to go about this.
%
% 1. Because we use vpi as a variable, and need to access its value here, we
%    make it a tree branch and an "internal unknown" or "other IO".
% 2. Because we are producing the value of ipi here and may use it in other
%    equations, we associate the contribution with a chord of the spanning
%    tree. In this case, the value of vpi, that needs to be accessed in this
%    contribution, will be computed from the tree branches. This is always
%    possible since every chord voltage of the spanning tree can be computed as
%    a linear combination of its branches.
%
% There are advantages and disadvantages to each method. The second method will
% in general generate a fewer number of internal unknowns. But because we are
% computing chord flows and branch potentials on the fly, we need to take care
% about when they are accessed. There is nothing to prevent a Verilog-A code to
% access the potential of a tree branch before it is computed.
% (Note that most of the branch potential/chord flow accesses will be to
% generate chord potentials/branch flows).
%
% I will call the first method above the anteBody (variables) method and the
% second method onTheFly (variables) method.
%
% This class has to know which of the above it is to use before it can generate
% the spanning tree of the device network.
%
% Right now, I will only implement the anteBody method.
%
% Terminology:
%   twig: an edge of the network that is in the spanning tree
%   chord: an edge of the network that is not in the spanning tree

% NOTE: right now we are unnecessarily recomputing the spanning tree and the
% following steps in every operation. This class should have a sealing function
% and save stuff like the B and D matrices for future use.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Dec 15, 2016  10:26AM
%==============================================================================

    properties
        nodeVec = MsNode.empty;
        branchVec = MsBranch.empty;
        refNode = MsNode.empty;
        collapsedBranchIdxVec = [];
    end

    methods
        
    % end methods
    end

    methods (Static)
        function compNodeVec = traverseTreeComponent(nodeObj, noGoTwigObj)
        % TRAVERSETREECOMPONENT traverses two components of a tree starting
        % from nodeObj and ignoring the twigObj.
        % This function separates a tree into two components and returns the
        % component that contains nodeObj.

            % do this recursively
            twigVec = nodeObj.getTwigVec();
            compNodeVec = nodeObj;

            for twigObj = twigVec
                if twigObj ~= noGoTwigObj
                    childNode = twigObj.getOtherNode(nodeObj);
                    childNodeVec = MsNetwork.traverseTreeComponent(childNode, twigObj);
                    compNodeVec = [compNodeVec, childNodeVec];
                end
            end
        end

    end

% end classdef
end
