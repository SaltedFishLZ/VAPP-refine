function derivLabel = getDerivLabel(thisDiffable, derivObj)
    % GETDERIVATIVELABEL
    derivLabel = ['d_', thisDiffable.getLabel(), ...
                                 '_d_', derivObj.getLabel()];
end