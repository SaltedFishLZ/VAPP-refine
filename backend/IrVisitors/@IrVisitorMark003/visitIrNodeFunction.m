function traverseSub = visitIrNodeFunction(thisVisitor, funcNode)
    % VISITIRNODEFUNCTION discovers ddt functions
    % This is the place where we use the functionality provided by
    % IrNodeNumerical.
    
        funcName = funcNode.getName();
        % check if the function name is valid.
        % There are two cases
        % 1. funcName is one of the built-in functions
        % 2. funcName is one of the functions defined by the model
        if any(strcmp(funcName, IrNodeFunction.VALIDFUNCTIONNAMES)) || ...
                                    thisVisitor.module.isFunc(funcName)
            % reserved for later
        else
            error(['The function "%s" is not one of VAPP''s built-in ',...
                'functions; nor is it defined by the Verilog-A model!'],...
                                                                funcName);
        end


        % ddt rules
        if funcNode.hasName('ddt')
            parentNode = funcNode.getParent();
            childNode = funcNode;
            
            % we allow the parent node to be either a contribution node or
            % an operation

            % start with a ddt node
            % go on until you hit an operation that is not multiplicative
            while parentNode.isMultiplicative() == true
                childNode = parentNode();
                parentNode = childNode.getParent();
            end

            % set it ddtTopNode
            childNode.setDdtTopNode();

            % go on traversing the tree upwards until you find a node that
            % breaks the chain to the ddtTopNode
            % set all the nodes in between onDdtPath
            while parentNode.isAffine() == true
                parentNode.setOnDdtPath();
                childNode = parentNode();
                parentNode = childNode.getParent();
            end

            % now we require the parentNode to be a Contribution: I.e., we
            % require a ddt node to have an affine path to a contribution
            % node. Note that how this requirement precludes ddt nodes
            % appering in assignments.

            if isa(parentNode, 'IrNodeContribution') == false
                error(['Error at ddt(%s). The ddt function has no ',...
                    'valid path to a contribution node!'],...
                                            funcNode.getChild(1).sprintAll());

            end


        % end if ddt
        end
        traverseSub = true;
    % end visitFunc
end