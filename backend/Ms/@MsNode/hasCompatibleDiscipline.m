function out = hasCompatibleDiscipline(thisNode, otherNode)
% HASCOMPATIBLEDISCIPLINE
    % ground node is compatible with every discipline
    if thisNode.isReference() == true || otherNode.isReference() == true
        out = true;
    else
        out = strcmp(thisNode.getDisciplineName(),...
                     otherNode.getDisciplineName());
    end
end