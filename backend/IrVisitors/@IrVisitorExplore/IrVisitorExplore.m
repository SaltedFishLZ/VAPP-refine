classdef IrVisitorExplore < IrVisitor
% IRVISITOREXPLORE print the IR tree

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods

        function obj = IrVisitorExplore(rootNode)
            obj = obj@IrVisitor();
            if nargin>0
                obj.traverseIr(rootNode, 0);
            end
        end

        function traverseIr(thisVisitor, irNode, indentLevel)

            % traverse the tree recursively and visit every node
            
            nChild = irNode.getNChild();

            out = irNode.acceptVisitor(thisVisitor, indentLevel);

            if iscell(out)
                traverseSub = out{1};
            else
                traverseSub = out;
            end

            if traverseSub == true
                indentLevel = indentLevel+1;
                for i=1:nChild
                    thisVisitor.traverseIr(irNode.getChild(i), indentLevel);
                end
            end

            if irNode.isModule() == true
                thisVisitor.endTraversal(irNode);
            end
        end
    
    end

    methods (Static)
        function outStr = printIndent(inStr, indentLevel)
            indentStr = repmat('  ', 1, indentLevel);
            fprintf([indentStr, inStr, '\n']);
        end
    end
end
