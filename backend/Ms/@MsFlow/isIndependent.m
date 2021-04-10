function out = isIndependent(thisFlow)
    % ISINDEPENDENT
    if thisFlow.branch.isChord() == true
        out = true;
    else
        out = false;
    end
end
