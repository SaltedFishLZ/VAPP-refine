function out = isIndependent(thisPotential)
% ISINDEPENDENT
    if thisPotential.branch.isTwig() == true
        out = true;
    else
        out = false;
    end
end