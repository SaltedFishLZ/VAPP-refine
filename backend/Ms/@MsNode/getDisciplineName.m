function discipName = getDisciplineName(thisNode)
% GETDISCIPLINENAME
    if isempty(thisNode.discipline) == false
        discipName = thisNode.discipline.name;
    else
        error(['The node %s has no discipline set for it.',...
               ' Discipline statements have to come before, e.g.,',...
               ' branch declarations.'], thisNode.label);
    end
end