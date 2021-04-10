function out = isDependentOnPf(thisDiffable, pfObj)
    if pfObj == thisDiffable
        out = true;
    else
        out = any(thisDiffable.dependPfVec == pfObj);
    end
end
