function labelStr = getLabel(thisPF)
% GETLABEL
    labelPrefix = thisPF.labelPrefix;
    if isempty(labelPrefix) == true
        labelPrefix = '[empty_label_prefix]:';
    end
    labelStr = [labelPrefix, '_', thisPF.branch.getLabel()];
end