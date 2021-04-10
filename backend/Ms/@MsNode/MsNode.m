classdef MsNode < handle
% MSNODE class for representing nodes (in ModSpec)
%

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    properties (Access = private)
       label = '';
       terminal = false;
       reference = false;
       branchVec = MsBranch.empty; % vector of branches to/fro this node.
       network = MsNetwork.empty;
       terminalFlow = MsTerminalFlow.empty;
       discipline = struct([]); % fields: name, potential (nature struct),
                              % flow (nature struct)
    end

    methods

        function obj = MsNode(label)
            obj.label = label;
        end
        
    % end methods
    end

% end classdef
end
