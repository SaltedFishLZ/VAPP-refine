classdef IrVisitorConstructModel < IrVisitor
% IRVISITORCONSTRUCTMODEL finds node collapse nodes and adds a IrNodeModel
% object there.
%
% The purpose of a IrNodeModel node is to set appropriate values for the
% properties of flows/potentials of branches.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Thu Feb 16, 2017  05:18PM
%==============================================================================
    properties (Access = private)
        module = IrNodeModule.empty;
        collapsedBranchVec = MsBranch.empty;
        foundNestedIfElse = false;
        modelVec = MsModel.empty;
    end

    methods
        
        function obj = IrVisitorConstructModel(module, irTree, collapsedBranchVec)
            if nargin > 0
                obj.module = module;

                if nargin > 2
                    obj.collapsedBranchVec = collapsedBranchVec;
                end

                obj.traverseIr(irTree);
            end
        end
        
    % end methods
    end
    
% end classdef
end
