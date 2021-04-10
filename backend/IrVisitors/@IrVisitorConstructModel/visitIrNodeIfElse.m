function traverseSub = visitIrNodeIfElse(thisVisitor, ifElseNode)
% VISITIRNODEIFELSE
    traverseSub = false;
    module = thisVisitor.module;
    thisVisitor.foundNestedIfElse = true;
    thenNode = ifElseNode.getChild(2);
    thenVisitor = IrVisitorConstructModel(module, thenNode, ...
                                        thisVisitor.collapsedBranchVec);
    if thenVisitor.foundNestedIfElse == false
        % construct model
        module.resetCollapsedBranches();
        for branchObj = thenVisitor.collapsedBranchVec
            branchObj.setCollapsed();
        end
        model = module.initModel(thenVisitor.collapsedBranchVec);
        %model.setCollapsedBranchVec(thenVisitor.collapsedBranchVec);
        modelNode = IrNodeModel(model);
        thenNode.addChild(modelNode);
    end
    if ifElseNode.getNChild() > 2
        elseNode = ifElseNode.getChild(3);
        elseVisitor = IrVisitorConstructModel(module, elseNode, ...
                                        thisVisitor.collapsedBranchVec);
        if elseVisitor.foundNestedIfElse == false
            % construct model
            module.resetCollapsedBranches();
            for branchObj = elseVisitor.collapsedBranchVec
                branchObj.setCollapsed();
            end
            model = module.initModel(elseVisitor.collapsedBranchVec);
            %model.setCollapsedBranchVec(elseVisitor.collapsedBranchVec);
            modelNode = IrNodeModel(model);
            elseNode.addChild(modelNode);
        end
    end
end