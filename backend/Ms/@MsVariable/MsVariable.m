classdef MsVariable < MsDifferentiable
% MSVARIABLE represents a variable in a ModSpec model.
%
% Variables keep track of their states in the model, and initialize themselves
% to zero at the beginning of the analog block if they are used before they are
% set.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Dec 08, 2016  09:39PM
%==============================================================================

    properties (Access = private)
        name = '';
        used = false;
        init = false; % is this var initialized?
        usedBeforeInit = false;
        valTree = IrNode.empty;
        module = IrNodeModule.empty;
        derivative = false;
        inNodeCollapse = false;
    end

    methods
        function obj = MsVariable(varName, valTree)
            obj.name = varName;
            if nargin > 1
                obj.valTree = valTree;
            else
                % error('cannot create IrNodeNumerical object here!\n');
                obj.valTree = utils.getConstantNode(0);
            end
        end
    %end methods
    end
% end classdef
end
