function inPfVec = getInputPfVec(thisModel)
    % GETINPUTPFVEC
    inPfVec = [thisModel.otherIoPfVec, thisModel.intUnkPfVec];
end
