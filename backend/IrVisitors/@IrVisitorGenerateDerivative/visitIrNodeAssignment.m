function traverseSub = visitIrNodeAssignment(thisVisitor, assignNode)
    traverseSub = false;

    lhsNode = assignNode.getLhsNode();
    lhsVarObj = lhsNode.getVarObj();

    % now generate derivatives
    % we generate one block to hold the actual assignment node and the
    % derivatives.
    % The derivatives themselves are put into a separate block.
    parentNode = assignNode.getParent();
    joinNode = IrNodeBlock();
    joinNode.setIndentLevel(0);
    parentNode.replaceChild(assignNode, joinNode);

    derBlock = IrNodeDerivativeBlock();
    joinNode.addChild(derBlock);
    % NOTE: we must add assignNode after we have added the derBlock.
    % Otherwise we would use the new value of the variable in the
    % derivatives and they will not be correct.
    joinNode.addChild(assignNode);
    if thisVisitor.generatePfDeriv == true

        % depPfVec contains IOs that the RHS depends on.
        % This includes dependencies through other IOs and variables.
        for depPfObj = thisVisitor.derivPfVec
            derivObj = depPfObj;
            if lhsNode.isDependentOnPf(derivObj)
                derAssignNode = assignNode.generateDerivativeTree(derivObj);
                derBlock.addChild(derAssignNode);
            elseif lhsVarObj.isDependentOnPf(derivObj)
                derAssignNode = lhsNode.resetDerivativeToZero(derivObj);
                derBlock.addChild(derAssignNode);
            end
        end

        % Remember: we are generating derivatives for a variable. We
        % can encounter all kinds of nasty things like bias dependent
        % if-else statements.
        % one example
        % var1 = V(s,b) + V(g,b);
        % ...do something with var1 here...
        % if Vgs < A
        %   var1 = V(s,b);
        % else
        %   var1 = V(g,b);
        % end
        % ...do something else with var1...
        % 
        % In the example above, we have to generate derivatives in the
        % if-else block. We have to generate derivatives with respect
        % to both V(s,b) and V(g,b) in both lines even though the
        % assignment itself depends only on one IO. Otherwise those
        % derivatives will retain their values from the previous
        % assignment and won't be set to zero.
        %
        % This is the reason why the above code does not only generate
        % derivatives for the IOs on the RHS of the assignment. It
        % implements a resetDerivativeToZero functionality as well!

    end

    % do we generate derivatives with respect to a variable?
    % That is, do we consider a variable to be an "independent
    % variable"?
    if thisVisitor.generateVarDeriv == true

        for depVarObj = thisVisitor.derivVarVec
            derivObj = depVarObj;
            if lhsVarObj ~= depVarObj
                if lhsNode.isDependentOnVar(depVarObj)
                    derAssignNode = assignNode.generateDerivativeTree(derivObj);
                    derBlock.addChild(derAssignNode);
                elseif lhsVarObj.isDependentOnPf(derivObj)
                    derAssignNode = lhsNode.resetDerivativeToZero(derivObj);
                    derBlock.addChild(derAssignNode);
                end
            end
        end
    end
end
