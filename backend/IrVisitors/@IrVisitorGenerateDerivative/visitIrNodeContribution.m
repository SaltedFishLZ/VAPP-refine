function traverseSub = visitIrNodeContribution(thisVisitor, contribNode)
    % NOTE
    % constructing derivatives for contributions is different in
    % some important respects than constructing derivatives for
    % variables (assignments).
    % The object on the LHS of a contribution might not always be
    % relevant to the derivatives. This is for instance the case with
    % implicit contributions with dummy IOs. But there are other, more
    % subtle cases. An extra IO that is on the LHS on a contribution
    % but not on a RHS anywhere in the model... The contribution to
    % this IO will be delegated to its two "defPf"s.
    % So, we change the derivative structure here. By this I mean how
    % the dependencies are decided. I.e., do we compute the derivative
    % of this contribution with respect to some particular quantity
    % (variable or IO)?
    % For this, we don't rely on the isDependentOn method of the LHS
    % object (as it is the case for computing assignment derivatives)
    % but we keep a separate dependency array here.
    traverseSub = false;

    lhsNode = contribNode.getLhsNode();
    lhsPfObj = lhsNode.getPfObj();

    % now generate derivatives
    % we generate one block to hold the actual contribution node and the
    % derivatives.
    % The derivatives themselves are put into a separate block.
    parentNode = contribNode.getParent();
    joinNode = IrNodeBlock();
    joinNode.setIndentLevel(0);
    parentNode.replaceChild(contribNode, joinNode);

    derBlock = IrNodeDerivativeBlock();
    joinNode.addChild(derBlock);
    % Again, we have to add contribNode after we have added derBlock
    joinNode.addChild(contribNode);

    if thisVisitor.generatePfDeriv == true

        for depPfObj = thisVisitor.derivPfVec
            if lhsNode.isDependentOnPf(depPfObj)
                derivObj = depPfObj;
                derContribNode = contribNode.generateDerivativeTree(derivObj);
                derBlock.addChild(derContribNode);
            end
        end

    end

    if thisVisitor.generateVarDeriv == true

        for depVarObj = thisVisitor.derivVarVec
            if lhsNode.isDependentOnVar(depVarObj)
                derivObj = depVarObj;
                derContribNode = contribNode.generateDerivativeTree(derivObj);
                derBlock.addChild(derContribNode);
            end
        end
    end
end
