function out = isIntUnk(thisFlow)
    % ISINTUNK
    out = false;
    branchObj = thisFlow.branch;
    if branchObj.isChord() == true && branchObj.isZeroFlow() == false
        if thisFlow.isContrib() == false
            out = true;
        elseif thisFlow.isProbe() == true
            out = true;
        end
    end
end