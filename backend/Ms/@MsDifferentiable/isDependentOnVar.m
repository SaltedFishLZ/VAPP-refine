function out = isDependentOnVar(thisDiffable, varObj)
    if varObj == thisDiffable
        out = true;
    else
        out = any(thisDiffable.dependVarVec == varObj);
    end
end