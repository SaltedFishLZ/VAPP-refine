classdef IrVisitorNestIfElseTree < IrVisitor
% IRVISITORNESTIFELSETREE is used by IrVisitorNodeCollapse to construct a
% nested if/else tree (i.e., a decision tree)

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Thu Feb 16, 2017  05:18PM
%==============================================================================
    properties (Access = private)
        nestedTree = IrNode.empty;
        subTree = IrNode.empty;
        foundNestedIfElse = false;
    end

    methods

        function obj = IrVisitorNestIfElseTree(irTree, subTree)
            if nargin > 1
                obj.subTree = subTree;
                % the subtree might not have an else node, if so, append a
                % block to it (notice an if-else tree must have at least 2
                % children).
                if isempty(subTree) == false && subTree.getNChild() < 3
                    subTreeCp = subTree.copyDeep();
                    subTreeCp.addChild(IrNodeBlock(0));
                    obj.subTree = subTreeCp;
                end

            end

            if nargin > 0
                obj.traverseIr(irTree);
            end
        end
    
    % end methods
    end
    
% end classdef
end
