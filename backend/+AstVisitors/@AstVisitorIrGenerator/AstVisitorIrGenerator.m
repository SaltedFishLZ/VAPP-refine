classdef AstVisitorIrGenerator < AstVisitors.AstVisitor
% ASTVISITORIRGENERATOR generate and intermediate representation from an AST
%
% AstVisitorIrGenerator will traverse the abstract syntax tree and generate an
% intermediate representation tree from the AST. The nodes of an IR tree is
% derived from the IrNode class and have this prefix, e.g., IrNodeContribution.
%
% See also ASTVISITOR

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Feb 21, 2017  12:15PM
%==============================================================================

% NOTE: out{1}, out{2} expressions below are ugly. The reason I am using
% them is because there is no other way in MATLAB of making the visitor
% pattern generic enough in order to use a variable number of outputs in
% the visit methods. varargout does not work because it's a one time thing:
% We can't pass varargout from function to function.
%
% function varargout = fun1()
%     varargout = fun2();
% end
%
% function varargout = fun2()
%     varargout{1} = 'foo';
%     varargout{2} = 'bar';
% end
%
% does not work.
% This would work if we knew the nargout for fun2 beforehand,
%
% function varargout = fun1()
%     varargout = cell(nargoutFun2,1);
%     [varargout{:}] = fun2();
% end
%
% but this is exactly what we don't know.
%
% If, in the future, we settle down to a fixed number of outputs for the
% visit methods, then we can implement that version and get rid of the cell
% array output.
%
% TODO: The error messages emanating from the semantic checks in this class
% should ideally be done in a separate class with a design that can support a
% sort of a "rule book".
    properties (Access = protected)
        irTree = IrNode.empty;
        module = IrNodeModule.empty; % for now assume there is only a single module
        accessIdx = 0;
    end

    methods
        function obj = AstVisitorIrGenerator(astRoot)
            if nargin > 0
                obj.generateIrTree(astRoot);
            end
        end
        
        function irTree = getIrTree(thisVisitor)
            irTree = thisVisitor.irTree;
        end

        function printModSpec(thisVisitor, outFileId)
            thisVisitor.module.fprintAll(outFileId);
        end

        function module = getModule(thisVisitor)
            module = thisVisitor.module;
        end
    % end methods
    end

    methods (Access = private)
        function naIdx = getNextAccessIdx(thisVisitor)
        % INCREASEACCESSIDX
            thisVisitor.accessIdx = thisVisitor.accessIdx + 1;
            naIdx = thisVisitor.accessIdx;
        end
    % end private methods
    end
% end classdef
end
