function out = isDependentOnParm(thisDiffable, parmObj)
    % ISDEPENDENTONPARM
    if parmObj == thisDiffable
        out = true;
    else
        out = any(thisDiffable.dependParmVec == parmObj);
    end
end