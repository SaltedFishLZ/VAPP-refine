function traverseSub = visitIrNodeContribution(thisVisitor, contribNode)
    traverseSub = false;

    module = thisVisitor.module;

    accessIdx = contribNode.getAccessIdx();

    lhsNode = contribNode.getLhsNode();
    lhsPfObj = lhsNode.getPfObj();
    rhsNode = contribNode.getRhsNode();

    % check if we are in a node collapse statement
    if lhsNode.isPotential() == true && ...
            rhsNode.hasType('IrNodeConstant') && ...
                                (rhsNode.getValue() == 0)
        contribNode.setNodeCollapse();
    else
        % create digger and dig through the RHS
        digger = IrVisitorRhsDigger(rhsNode, lhsPfObj);

        % set rhs vars used and rhs potentials and flows as probed
        rhsVarVec = digger.getVarVec();

        for varObj = rhsVarVec
            varObj.setUsed();
        end

        rhsPfVec = digger.getPfVec();
        for pfObj = rhsPfVec
            pfObj.setProbe(accessIdx);
        end

        % now check if the equation is an implicit one
        % we have to do this here because e.g. if lhsNode is a dummy node
        % in an implicit equation, we don't mark its pfObj as a contrib.
        lhsPfObj = lhsNode.getPfObj();
        nMatch = digger.getNMatch();
        if nMatch == 0
            % set lhs PF as contrib
            lhsPfObj.setContrib(accessIdx);
            % mark the lhsNode as lhs
            lhsNode.setLhs();
        elseif nMatch > 0
            % add this contribution to the implicitContribVec of the module
            module.addImplicitContrib(contribNode);
            matchedPfNode = digger.getMatchedPfNode();
            isAdditive = matchedPfNode.isAdditive()*lhsNode.isAdditive();
            if nMatch == 1 && isAdditive == 1
                % we might have dummy node here or a regular implicit equation
                % let's check if the matchedPf is the lhsPf
                % Here the lhsNode can also be an inverse PF. Hence, we
                % multiply isAdditive with the sign of the lhsPfObj
                % we have a dummy PF
                contribNode.setNullEqn();
                contribNode.setRhsDummyNode(matchedPfNode);
                matchedPfNode.setDummy();
                lhsNode.setDummy();
            else % we have a genuine implicit equation with a lhs
                lhsPfObj.setProbe(accessIdx);
                % originally we had here the following
                lhsPfObj.setContrib(accessIdx);
                % we should replace this with something else in the new
                % node_branch_design
            end

            for pfObj = rhsPfVec
                pfObj.setInImplicitEqn();
            end
        end
    end
end
