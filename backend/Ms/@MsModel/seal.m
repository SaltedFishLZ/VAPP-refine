function seal(thisModel)
    % SEAL

    thisModel.computeCoreModel();

    ioDefTree = IrNodeBlock(0);
    thisModel.ioDefTree = ioDefTree;
    % generate loop and cutset definition equations for dependent flows
    % and potentials and add them to the beginning of the module.
    [loopEqnBlock, cutEqnBlock, collapsedBlock] = thisModel.generateIoDef();
    ioDefTree.addChild(collapsedBlock);
    ioDefTree.addChild(cutEqnBlock);
    ioDefTree.addChild(loopEqnBlock);


    outputTree = IrNodeBlock(0);
    thisModel.outputTree = outputTree;
    % generate explicit outputs
    [expOutPotentialEqnBlock, expOutFlowEqnBlock] = thisModel.generateExpOutEqn();
    outputTree.addChild(expOutPotentialEqnBlock);
    outputTree.addChild(expOutFlowEqnBlock);

    % generate equations for internal unknowns
    [potentialEqnBlock, flowEqnBlock] = thisModel.generateIntUnkEqn();
    outputTree.addChild(potentialEqnBlock);
    outputTree.addChild(flowEqnBlock);

    % generate equations for otherIOs
    otherIoEqnBlock = thisModel.generateOtherIoEqn();
    outputTree.addChild(otherIoEqnBlock);

    % generate outputs for implicit equations
    implicitEqnBlock = thisModel.generateImplicitEqn();
    outputTree.addChild(implicitEqnBlock);
end
