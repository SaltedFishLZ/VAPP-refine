function out = visitAccess(thisVisitor, accessNode)
    % here we request the branch from the module and then return its
    % potential or flow object wrapped around an IrNodePotentialFlow
    out{1} = false; % do not traverse further
    module = thisVisitor.module;
    inverseNodeOrder = false;
    accessLabel = accessNode.get_name();

    % accessNode will either have one or two children
    % one child -> branch name supplied
    % two children -> node names supplied
    nChild = accessNode.get_num_children();
    if nChild == 1
        % we are given a branch or a port


        childNode = accessNode.get_child(1);

        if childNode.has_type('var') == true
            % the argument is a branch label
            branchLabel = accessNode.get_child_names();
            branchObj = module.getBranch(branchLabel);
            if isempty(branchObj)
                % the branch label used in the VA file was not declared
                pfLabel = [accessLabel, '(', branchLabel, ')'];
                errMsg = sprintf(['Error accessing %s. ',...
                       'There is no branch with the label ''%s''!'],...
                                                            pfLabel,...
                                                            branchLabel);
                errorAtAstNode(errMsg, accessNode);
                error('Exiting IR generator!');
            end

            inverseNodeOrder = branchObj.isAliasReversed(branchLabel);
            pfObj = branchObj.getPotentialOrFlow(accessLabel);
        elseif childNode.has_type('port') == true
            portLabel = accessNode.get_child_names();
            portObj = module.getNode(portLabel);
            if isempty(portObj)
                % the port was not there
                pfLabel = [accessLabel, '(<', portLabel, '>)'];
                errMsg = sprintf(['Error accessing %s. ',...
                       'There is no port with the label ''%s''!'],...
                                                            pfLabel,...
                                                            portLabel);
                errorAtAstNode(errMsg, accessNode);
                error('Exiting IR generator!');
            end

            pfObj = portObj.getTerminalFlow();
        else
            childLabel = accessNode.get_child_names();
            pfLabel = [accessLabel, '(', childLabel, ')'];
            errMsg = sprintf(['Access node ''%s'' has an invalid',...
                                              ' argument!'], pfLabel);
            errorAtAstNode(errMsg, accessNode);
            error('Exiting IR generator!');
        end

    elseif nChild == 2
        [nodeLabel1, nodeLabel2] = accessNode.get_child_names();

        % if the nodes are connected, get the branch object.
        nodeObj1 = module.getNode(nodeLabel1);
        nodeObj2 = module.getNode(nodeLabel2);

        if isempty(nodeObj1) == true
            errMsg = sprintf('"%s", is not a node identfier!', nodeLabel1);
            errorAtAstNode(errMsg, accessNode);
            error('Exiting IR generator!');
        end

        if isempty(nodeObj2) == true
            errMsg = sprintf('"%s", is not a node identfier!', nodeLabel2);
            errorAtAstNode(errMsg, accessNode);
            error('Exiting IR generator!');
        end

        if nodeObj1.isConnectedTo(nodeObj2)
            branchObj = nodeObj1.getBranch(nodeObj2);
            inverseNodeOrder = branchObj.areNodesReversed(nodeObj1, nodeObj2);
        else
            % if not, create a branch.
            branchLabel = [nodeLabel1, nodeLabel2];
            inverseBranchLabel = [nodeLabel2, nodeLabel1];
            branchObj = module.addBranch(branchLabel, nodeLabel1, nodeLabel2);
            % add the same branch with the inverted label as well
            module.addBranch(inverseBranchLabel, nodeLabel1, nodeLabel2);
            inverseNodeOrder = false;
        end

        pfObj = branchObj.getPotentialOrFlow(accessLabel);
    else
        error(['Found a Potential or Flow node with a number of ',...
               'children that is not equal to ONE or TWO! ',...
               'Something is wrong.']);
    end

    out{2} = IrNodePotentialFlow(pfObj, inverseNodeOrder);
end
