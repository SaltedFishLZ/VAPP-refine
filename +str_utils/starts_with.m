function out = starts_with(str, prefix, pos)

    % Returns true if str starts with prefix at index pos, false otherwise (pos
    % is an optional argument that defaults to 1). That is, this function 
    % returns true if str(pos:(pos+length(prefix)-1)) is equal to prefix, and 
    % false otherwise.

    if nargin == 2
        pos = 1;
    end

    try
        out = strcmp(str(pos:(pos+length(prefix)-1)), prefix);
    catch
        out = false;
    end

end