classdef MsTerminalFlow < MsPotentialFlow
% MSTERMINALFLOW special flow class for flows into terminals of the model from
% the outside world

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    properties
        terminal = MsNode.empty;
    end

    methods

        function obj = MsTerminalFlow(terminal)
        % MSTERMINALFLOW
            obj.terminal = terminal;
            obj.node1 = terminal;
            obj.node2 = terminal;

            obj.labelPrefix = 'terminalFlow';
        end
        
    % end methods
    end
    
% end classdef
end
