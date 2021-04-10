function out = isIntUnk(thisPotential)
% ISINTUNK
    out = false;
    branchObj = thisPotential.branch;
    if branchObj.isReference() == false && ...
                       branchObj.isTwig() == true
        if thisPotential.isContrib() == false
            out = true;
        elseif thisPotential.isProbe() == true
            out = true;
        end
    end
end