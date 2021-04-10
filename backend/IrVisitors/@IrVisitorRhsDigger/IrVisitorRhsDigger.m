classdef IrVisitorRhsDigger < IrVisitor
% IRVISITORRHSDIGGER dig through the RHS of an assignment or a contribution.
%
% The instances of this class is to be used by other visitors when they are
% visiting contribution or assignment nodes. The idea is: create an instance of
% RhsDigger and let it loose on the rhs of the assignment or contribution and
% then collect info from the RhsDigger when it comes back home.
%
% TODO: this class lacks the functionality for discovering implicit equations.
% It can be coppied here from IrVisitorIoVarParmDigger.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================

    properties (Access = private)
        pfVec = MsFlow.empty; % potential-flow vector
        parmVec = MsParameter.empty;
        varVec = MsVariable.empty;
        lhsPfObj = MsPotential.empty;
        matchedPfNode = IrNodePotentialFlow.empty();
        nMatch = 0;
    end

    methods

        function obj = IrVisitorRhsDigger(irTree, lhsPfObj)
            if nargin > 0
                if nargin == 2
                    obj.lhsPfObj = lhsPfObj;
                end
                obj.traverseIr(irTree);
            end
        end
        
    % end methods
    end
    
% end classdef
end
