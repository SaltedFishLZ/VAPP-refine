function derivLabel = getDerivLabel(thisDiffable, derivObj)
    % GETDERIVATIVELABEL
    % disp(class(thisDiffable))
    % DEBUG: getLabel method defined in subclasses but missing in MsDiff
    derivLabel = ['d_', thisDiffable.getLabel(), ...
                                 '_d_', derivObj.getLabel()];
end