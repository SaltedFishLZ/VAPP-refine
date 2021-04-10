classdef MsBranch < handle
% MSBRANCH represents a branch in ModSpec
%
% Branches are created by supplying two MsNode objects to its constructor.
% In the process of creating a branch, we attach a potential and a flow object
% to it as well. This way when we are creating *intermediate representation
% tree* nodes, we can directly access these objects through nodes or branches.
% This saves us the trouble of keeping an array for flows and potentials in the
% module.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Tue Jan 31, 2017  11:41AM
%==============================================================================
    properties (Access = private)
        node1 = MsNode.empty;
        node2 = MsNode.empty;
        label = ''; % this will be the concatenation of the two node names.
        aliasMap = containers.Map;
        potentialObj = MsPotential.empty;
        flowObj = MsFlow.empty;
        twig = false;
        chord = false;
        discipline = struct([]); % fields: name, potential (nature struct),
                              % flow (nature struct)
        collapsed = false;
        toBeCollapsed = false;
        collapsedWarningDisplayed = false;
    end

    methods

        function obj = MsBranch(nodeObj1, nodeObj2)
        % MSBRANCH

            % NOTE: we will receive an error if the two nodes are already
            % connected
            if nodeObj1.hasCompatibleDiscipline(nodeObj2) == false
                error(['Cannot create branch: node "%s" and node "%s" do',...
                       ' not have the same discipline!'], nodeObj1.getLabel,...
                                                          nodeObj2.getLabel);
            end

            obj.node1 = nodeObj1;
            obj.node2 = nodeObj2;
            nodeObj1.addBranch(obj);
            nodeObj2.addBranch(obj);

            discipline = nodeObj1.getDiscipline();
            obj.discipline = discipline;

            obj.label = strcat(nodeObj1.getLabel(), nodeObj2.getLabel());

            % create flow and potential objects
            obj.flowObj = MsFlow(obj);
            obj.potentialObj = MsPotential(obj);
            obj.aliasMap = containers.Map();
        end
        
    % end methods
    end

% end classdef
end
