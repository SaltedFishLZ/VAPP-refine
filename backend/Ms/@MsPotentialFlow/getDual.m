function dualPF = getDual(thisPF)
% GETDUAL this method returns the dual quantity of thisPF.
    branch = thisPF.branch;
    if thisPF.isPotential() == true
        dualPF = branch.getFlow();
    elseif thisPF.isFlow() == true
        dualPF = branch.getPotential();
    end
end