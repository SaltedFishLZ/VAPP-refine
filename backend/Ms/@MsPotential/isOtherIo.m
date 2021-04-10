function out = isOtherIo(thisPotential)
% ISOTHERIO
    out = false;
    branchObj = thisPotential.branch;

    if branchObj.isReference() == true && ...
                        branchObj.isTwig() == true
        if thisPotential.isContrib() == false
            out = true;
        elseif thisPotential.isProbe() == true
            out = true;
        end
    end
end