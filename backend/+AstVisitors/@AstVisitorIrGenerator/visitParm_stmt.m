function out = visitParm_stmt(thisVisitor, parmStmtNode)
    % create a MsParameter object and add it to the module
    % TODO: print parameter ranges as comments
    module = thisVisitor.module;
    parmNode = parmStmtNode.get_child(1);
    parmName = parmNode.get_name();
    defNode = parmNode.get_child(1);
    defValGen = AstVisitors.AstVisitorParmValTreeGenerator(module);
    % the line below can be a solution to the
    % "paramaeters depending on other parameters" problem
    defValGen.generateIrTree(defNode);
    defValTree = defValGen.getIrTree();

    parmObj = module.addParm(parmName, defValTree);

    % find out if there were any other parameters on the RHS
    rhsParmVec = defValGen.getParmVec();
    parmObj.setDependParmVec(rhsParmVec);
    if isempty(rhsParmVec) == false
        % this parameter depends on other parameters
        % We go over its default value tree one more time, this time
        % keeping the parameters on the RHS as they are (as opposed to
        % what we are doing with defValGen above).
        insValGen = AstVisitorIrGenerator();
        insValGen.module = module;
        insValGen.generateIrTree(defNode);
        insValTree = insValGen.getIrTree();
        parmObj.setDependentOnOtherParm();
        parmObj.setInsValTree(insValTree);
    end

    out{1} = false;
    out{2} = IrNode.empty; % don't add an IrNode to the IR
end