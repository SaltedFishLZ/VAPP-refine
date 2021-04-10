function setInNodeCollapse(thisVar)
% SETINNODECOLLAPSE
    if isempty(thisVar.dependPfVec) == false
        varLabel = thisVar.getLabel();
        errorStr = sprintf(['A node collapse statement depends on',...
                            ' the variable %s whose value is bias',...
                            ' dependent!\n%s depends on:\n'],...
                                                 varLabel, varLabel);
        for pfObj = thisVar.dependPfVec
            errorStr = sprintf([errorStr, pfObj.getLabel(), '\n']);
        end
        error(errorStr);
    else
        thisVar.inNodeCollapse = true;
    end
end
