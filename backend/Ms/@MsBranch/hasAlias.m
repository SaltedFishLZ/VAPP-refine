function out = hasAlias(thisBranch, aliasStr)
    out = thisBranch.aliasMap.isKey(aliasStr);
end
