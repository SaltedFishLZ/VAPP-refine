classdef IrVisitorMark003 < IrVisitor
% IRVISITORMARK3 runs the third pass over the IRT.
% The task of this marker is 
%   * check if function names are valid
%   * construct ddt paths

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Sat Dec 10, 2016  07:23PM
%==============================================================================
    properties
        module = IrNodeModule.empty;
    end

    methods
        
        function obj = IrVisitorMark003(irTree)
            if nargin > 0
                obj.traverseIr(irTree);
            end
        end
        
    % end methods
    end
    
% end classdef
end
