function out = isExpOut(thisPotential)
% ISEXPOUT
    out = false;
    branchObj = thisPotential.branch;

    if branchObj.isReference() == true
        if thisPotential.isOtherIo() == false
            out = true;
        end
    end
end
