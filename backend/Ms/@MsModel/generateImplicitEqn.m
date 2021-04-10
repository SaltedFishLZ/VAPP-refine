function implicitEqnBlock = generateImplicitEqn(thisModel)
    % GENERATEIMPLICITEQN
    intEqnIdx = thisModel.intEqnIdx;
    intEqnNameList = {};
    implicitEqnBlock = IrNodeBlock();
    implicitEqnBlock.setIndentLevel(0);
    nImplicitContrib = thisModel.nImplicitContrib;

    for i = 1:thisModel.nImplicitContrib
        contrib = thisModel.implicitContribVec(i);
        outNode = IrNodeOutput();
        outNode.setImplicit(contrib);
        outNode.setOutIdx(intEqnIdx + i);
        %outNode.addChild(IrNodeNumericalNull());
        % outNode is to be set implicit and it has to create a dummy
        % pfObj for printing purposes.
        implicitEqnBlock.addChild(outNode);
        intEqnName = ['implicit equation ', num2str(i)];
        intEqnNameList = [intEqnNameList, {intEqnName}];
        thisModel.nFiQi = thisModel.nFiQi + 1;
    end

    thisModel.intEqnIdx = intEqnIdx + thisModel.nImplicitContrib;
    thisModel.intEqnNameList = [thisModel.intEqnNameList, intEqnNameList];
end
