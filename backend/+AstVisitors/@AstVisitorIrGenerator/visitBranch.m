function out = visitBranch(thisVisitor, branchNode)
    % Don't create separate object. Add branch to module's branch list.
    module = thisVisitor.module;
    branchLabel = branchNode.get_name();

    [nodeLabel1, nodeLabel2] = branchNode.get_child_names();
    % does the branch have exactly two children?
    if branchNode.get_num_children() ~= 2
        error(['Error defining brach: %s. A branch must be between ',...
               'exactly two nodes.\n',...
               'Needs compatible Verilog-A does not allow ', ...
               'global ground access from within the model. ',...
               'If you would like to use a probe with reference ',...
               'to the global ground, please explicitly define ',...
               'a ground terminal in your model.'],...
                                            branchLabel);
    end
    nodeObj1 = module.getNode(nodeLabel1);
    if isempty(nodeObj1) == true
        error(['You have defined the branch %s, but its first node',...
               ' %s is unknown to me!'], branchLabel, nodeLabel1);
    end

    nodeObj2 = module.getNode(nodeLabel2);
    if isempty(nodeObj2) == true
        error(['You have defined the branch %s, but its second node',...
               ' %s is unknown to me!'], branchLabel, nodeLabel2);
    end

    % was this branch already defined for this module?
    if module.isBranch(branchLabel)
        exBranch = module.getBranch(branchLabel);
        [exNodeObj1, exNodeObj2] = exBranch.getNodes();
        if nodeObj1 ~= exNodeObj1 || nodeObj2 ~= exNodeObj2
        error(['Error defining branch: the branch %s has been',...
               ' defined previously between nodes %s and %s.'],...
                branchLabel, exNodeObj1.getLabel(), exNodeObj2.getLabel());
        end
    end

    % Add the branch to the module.
    branchObj = module.addBranch(branchLabel, nodeLabel1, nodeLabel2);
    % Add also its canonical label to the module
    % This will not create another branch. It will just add the
    % canonical branch label as an alias to the circuit
    module.addBranch([nodeLabel1, nodeLabel2], nodeLabel1, nodeLabel2);
    % add the inverse as well
    module.addBranch([nodeLabel2, nodeLabel1], nodeLabel1, nodeLabel2);
    out{1} = false;
    out{2} = IrNode.empty;
end