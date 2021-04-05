function out = ends_with(str, suffix, pos)

    % Returns true if str ends with suffix at index pos, false otherwise (pos
    % is an optional argument that defaults to length(str)). That is, this 
    % function returns true if str((pos-length(suffix)+1):pos) is equal to 
    % suffix, and false otherwise.

    if nargin == 2
        pos = length(str);
    end

    try
        out = strcmp(str((pos-length(suffix)+1):pos), suffix);
    catch
        out = false;
    end

end