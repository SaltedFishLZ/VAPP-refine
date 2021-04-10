classdef MsDifferentiable < handle
% MSDIFFERENTIABLE abstract class representing a ModSpec object that can be
% differentiated
%
% MsPotentialFlow and MsVariable are subclasses of this class.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Sat Dec 10, 2016  07:23PM
%==============================================================================

    properties (Access = protected)
        dependPfVec = MsPotential.empty; % list of PotentialFlow objects this
                                         % MsDifferentiable depends on
        dependVarVec = MsVariable.empty; % list of Variables this variables depends on.
        dependParmVec = MsParameter.empty;
    end

    methods
    
    % end methods
    end
    
% end classdef
end
