function out = visitVar_decl(thisVisitor, varNode)
    % Create MsVariable object and add it to the module.
    varName = varNode.get_name();
    % if the variable has a child, it has been assigned a default value
    if varNode.get_num_children() > 0
        defNode = varNode.get_child(1);
        valGen = AstVisitors.AstVisitorParmValTreeGenerator(thisVisitor.module);
        defValTree = valGen.generateIrTree(defNode);
    else % otherwise set it to zero
        defValTree = IrNodeConstant('real', 0);
    end

    thisVisitor.module.addVar(varName, defValTree);

    out{1} = false;
    out{2} = IrNode.empty;
end