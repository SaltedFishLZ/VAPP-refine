function traverseSub = visitIrNodeOutput(thisVisitor, outNode)
    % VISITIRNODEOUTPUT
    % As opposed to contributions and assigments, IrNodeOutputs can only
    % have IrNodePotentialFlows on their RHS
    traverseSub = false;
    if outNode.isImplicit() == false
        dependPfVec = MsPotential.empty;
        lhsPfNode = outNode.getLhsNode();
        if lhsPfNode.isNull() == false
            dependPfVec = lhsPfNode.getPfObj();
        end
        dependPfVec = [dependPfVec, outNode.getRhsPfVec()];
    else
        contribNode = outNode.getImplicitContrib();
        dependPfVec = contribNode.getImplicitEqnDependPfVec;
    end
    parentNode = outNode.getParent();
    joinNode = IrNodeBlock();
    joinNode.setIndentLevel(0);
    parentNode.replaceChild(outNode, joinNode);
    derBlock = IrNodeDerivativeBlock();
    joinNode.addChild(derBlock);
    % Again, we have to add outNode after we have added derBlock
    joinNode.addChild(outNode);
    if thisVisitor.generatePfDeriv == true
        depPfVec = MsPotential.empty;
        for depPfObj = thisVisitor.derivPfVec
            for pfObj = dependPfVec
                if pfObj.isDependentOnPf(depPfObj)
                    depPfVec = [depPfVec, depPfObj];
                    break;
                end
            end
        end
        for depPfObj = depPfVec
            derivObj = depPfObj;
            derContribNode = outNode.generateDerivativeTree(derivObj);
            derBlock.addChild(derContribNode);
        end
    end
    if thisVisitor.generateVarDeriv == true
        depVarVec = MsVariable.empty;
        for depVarObj = thisVisitor.derivVarVec
            for pfObj = dependPfVec
                if pfObj.isDependentOnVar(depVarObj)
                    depVarVec = [depVarVec, depVarObj];
                    break;
                end
            end
        end
        for depVarObj = depVarVec
            derivObj = depVarObj;
            derContribNode = outNode.generateDerivativeTree(derivObj);
            derBlock.addChild(derContribNode);
        end
    end
    
end