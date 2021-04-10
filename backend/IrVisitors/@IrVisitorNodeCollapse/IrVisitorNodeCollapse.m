classdef IrVisitorNodeCollapse < IrVisitor
% IRVISITORNODECOLLAPSE discovers node collapse statements and constructs a
% decision tree for collapsing nodes
%

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Tue Feb 21, 2017  12:15PM
%==============================================================================
    properties (Access = private)
        ifElseTree = IrNode.empty;
        ifElseTreeVec = IrNode.empty; % this is a vector IrNodeIfElse objects
        nestedIfElseTree = IrNode.empty;
        nestedIfElseTreeVec = IrNode.empty;
    end

    methods

        function obj = IrVisitorNodeCollapse(irTree)
            if nargin > 0
                obj.traverseIr(irTree);
            end
        end
    
    % end methods
    end

% end classdef
end
