function out = isAliasReversed(thisBranch, aliasStr)
    % ISALIASREVERSED
    if thisBranch.hasAlias(aliasStr)
        out = thisBranch.aliasMap(aliasStr) == -1;
    else
        error('This branch does not have the alias ''%s''', aliasStr);
    end
end