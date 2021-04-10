function discipStruct = getDiscipline(thisNode)
% GETDISCIPLINE
    if isempty(thisNode.discipline) == false
        discipStruct = thisNode.discipline;
    else
        error(['The node %s has no discipline set for it.',...
               ' Discipline statements have to come before, e.g.,',...
               ' branch declarations.'], thisNode.label);
    end
end
