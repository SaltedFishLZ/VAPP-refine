classdef  IrVisitorGenerateDependency < IrVisitor
%  IRVISITORDEPENDENCYGENERATOR

% This visitor sets dependencies for MsPotentialFlow and MsVariable objects. It
% also keeps a copy of the same dependencies in IrNodeDifferentiable objects.
% The reason for the copy is:
% When this visitor goes through the whole tree, the potential/flow and
% variable objects will contain all the dependencies in all the equations.
% I.e., if there are multiple assignments to the same variable, this variable
% object will contain the dependencies for both assignments. However, the first
% IrNodeVariable object will only contain the dependencies from the first
% assignment.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Sat Dec 10, 2016  07:23PM
%==============================================================================

    properties
        rhsPfVec = MsPotential.empty;
        rhsVarVec = MsVariable.empty;
        rhsParmVec = MsParameter.empty;
        ifElseParmVec = MsParameter.empty;
        ifElseVarVec = MsVariable.empty;
        ifElsePfVec = MsPotential.empty;
    end

    methods

        function obj = IrVisitorGenerateDependency(irTree)
            if nargin > 0
                obj.traverseIr(irTree);
            end
        end
        
    % end methods
    end
    
% end classdef
end
