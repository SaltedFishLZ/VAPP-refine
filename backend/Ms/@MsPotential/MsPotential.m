classdef MsPotential < MsPotentialFlow
% MSPOTENTIAL a potential across a branch (like a voltage)

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods

        function obj = MsPotential(branchObj)
        % MSPOTENTIAL
            obj.labelPrefix = 'potential';
            obj.setBranch(branchObj);
        end
        
    % end methods
    end

    methods (Static)
        function out = isPotential()
        % ISPOTENTIAL
            out = true;
        end
    end
    
% end classdef
end
