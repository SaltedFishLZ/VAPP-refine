classdef IrVisitorPrintNodeCollapseVar < IrVisitor
% IRVISITORPRINTNODECOLLAPSEVAR prints variables and parameters that are
% required to evaluate the node collapse if/else tree

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Thu Feb 16, 2017  05:18PM
%==============================================================================
    properties (Access = private)
        ncStr = '';
    end

    methods
        
        function obj = IrVisitorPrintNodeCollapseVar(irTree)
            if nargin > 0
                obj.traverseIr(irTree);
            end
        end
    
    % end methods
    end
    
% end classdef
end 
