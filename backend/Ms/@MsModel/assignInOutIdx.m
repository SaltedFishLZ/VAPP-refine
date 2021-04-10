function assignInOutIdx(thisModel)
    % ASSIGNINOUTIDX assigns input/output indices to potential/flow objects
    % to be used in fe/qe/fi/qi vectors. 
    % TODO: do this for implicit equations as well
    
    for i = 1:thisModel.nOtherIo
        thisModel.otherIoPfVec(i).setInIdx(i);
    end

    for i = 1:thisModel.nIntUnk
        thisModel.intUnkPfVec(i).setInIdx(i);
    end

    for i = 1:thisModel.nExpOut
        thisModel.expOutPfVec(i).setOutIdx(i);
    end

end