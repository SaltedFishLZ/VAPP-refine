function addAlias(thisBranch, aliasStr, nodeOrder)
    % Between two nodes only one branch can exist. If the order of the
    % nodes is reversed, it is still the same branch. Since One alias
    % can point to the regular order of nodes and another alias can
    % point to the reverse order, we keep a list of "alias masks".
    % This is the nodeOrder variable below. It can either be 1 or -1.

    if thisBranch.hasAlias(aliasStr) == false
        thisBranch.aliasMap(aliasStr) = nodeOrder;
    end
end