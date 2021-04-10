classdef IrVisitorGenerateDerivative < IrVisitor
% IRVISITORGENERATEDERIVATIVE crawls the IR tree and augments it with
% derivatives.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Sat Dec 10, 2016  07:34PM
%==============================================================================
    properties (Constant)
        VARSFX = '__';
    end

    properties (Access = private)
        generatePfDeriv = false;
        generateVarDeriv = false;
        derivVarVec = MsVariable.empty;
        derivPfVec = MsPotential.empty;
    end

    methods

        function obj = IrVisitorGenerateDerivative(derivPfVec, derivVarVec, irTree)

            obj.derivPfVec = derivPfVec;
            obj.derivVarVec = derivVarVec;
            obj.generatePfDeriv = (isempty(derivPfVec) == false);
            obj.generateVarDeriv = (isempty(derivVarVec) == false);

            if nargin > 2
                obj.traverseIr(irTree);
            end
        end

        function setDerivVarVec(thisVisitor, varVec)
            if isempty(varVec) == false
                thisVisitor.derivVarVec = varVec;
                thisVisitor.generateVarDeriv = true;
            end
        end
             
    % end methods
    end
    
% end classdef
end
