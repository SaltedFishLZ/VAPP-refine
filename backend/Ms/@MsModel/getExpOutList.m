function expOutList = getExpOutList(thisModel)
    % GETEXPOUTLIST
    expOutList = {};
    refLabel = thisModel.refNode.getLabel();

    for expOut = thisModel.expOutPotentialVec
        expOutList = [expOutList, {expOut.getModSpecLabel()}];
    end

    for expOut = thisModel.expOutFlowVec
        expOutList = [expOutList, {[expOut.getModSpecLabel(), refLabel]}];
    end
end