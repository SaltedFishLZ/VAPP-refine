function intUnkList = getIntUnkList(thisModel)
    % GETINTUNKLIST
    intUnkList = {};

    for intUnk = thisModel.intUnkPfVec
        intUnkList = [intUnkList, {intUnk.getLabel()}];
    end
end