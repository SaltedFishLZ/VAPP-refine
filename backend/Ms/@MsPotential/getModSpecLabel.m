function label = getModSpecLabel(thisPotential)
% GET
    branchLabel = thisPotential.branch.getModSpecLabel();
    label = ['v', branchLabel];
end
