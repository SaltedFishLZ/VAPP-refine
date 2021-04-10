function out = visitVar(thisVisitor, varNode)
    % Here varNode can be a parameter or a variable
    module = thisVisitor.module;
    varOrParmName = varNode.get_name();
    out{1} = true;
    isNodeParm = module.isParm(varOrParmName);
    isNodeVar = module.isVar(varOrParmName);
    if isNodeParm == true && isNodeVar == true
        error('The parameter %s was redeclared as a variable!',...
                                                        varOrParmName);
    elseif isNodeParm == false && isNodeVar == false
        error(['The variable or parameter %s was not defined in ',...
                                                'this the module %s!'],...
                                        varOrParmName, module.getName());
    elseif module.isParm(varOrParmName)
        parmObj = module.getParm(varOrParmName);
        out{2} = IrNodeParameter(parmObj);
    elseif module.isVar(varOrParmName)
        varObj = module.getVar(varOrParmName);
        out{2} = IrNodeVariable(varObj);
    end
end