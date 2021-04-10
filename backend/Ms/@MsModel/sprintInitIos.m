function outStr = sprintInitIos(thisModel)
    outStr = '';
    varSfx = thisModel.VARSFX;
    nI = thisModel.nIntUnk;
    nO = thisModel.nOtherIo;

    % assign IO values
    outStr = [outStr, '// Initializing inputs\n'];
    for i = 1:nO
        pfObj = thisModel.otherIoPfVec(i);
        outStr = [outStr, pfObj.getLabel(), varSfx, ' = ',...
                                sprintf('vecX%s(%d);\n', varSfx, i)];
    end

    for i = 1:nI
        pfObj = thisModel.intUnkPfVec(i);
        outStr = [outStr, pfObj.getLabel(), varSfx ' = ',...
                                sprintf('vecY%s(%d);\n', varSfx, i)];
    end

end
