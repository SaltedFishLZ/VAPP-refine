
        function out = visitOutput(thisVisitor, outputNode)
            % this will be only used if we  are inside of a function body
            out{1} = true;
            out{1} = true;
            out{2} = IrNode.empty;

            func = thisVisitor.module;
            outputList = outputNode.get_attr('outputs');
            func.setOutputList(outputList);
        end