classdef MsFlow < MsPotentialFlow
% MSFLOW a flow through a branch (e.g., an electrical current)

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods
        
        function obj = MsFlow(branchObj)
        % MSFLOW
            obj.labelPrefix = 'flow';
            obj.setBranch(branchObj);
        end
    
    % end methods
    end

    methods (Static)
        function out = isFlow()
        % ISFLOW
            out = true;
        end
    end
    
% end classdef
end
