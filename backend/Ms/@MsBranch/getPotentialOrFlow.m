function pfObj = getPotentialOrFlow(thisBranch, accessLabel)
    % GETPOTENTIALORFLOW
    potentialAccess = thisBranch.discipline.potential.access;
    flowAccess = thisBranch.discipline.flow.access;

    if strcmp(accessLabel, potentialAccess)
        pfObj = thisBranch.potentialObj;
    elseif strcmp(accessLabel, flowAccess)
        pfObj = thisBranch.flowObj;
    else
        error(['Access label (%s) does not match neither the flow',...
               ' (%s) nor the potential (%s) access of this branch!'],...
                                        flowAccess, potentialAccess);
    end
end