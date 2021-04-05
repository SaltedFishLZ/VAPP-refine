function out = str_in_arr(str, arr)
    % returns true if the string str is in the cell array of strings arr, and 
    % false otherwise
    for idx = 1:1:length(arr)
        if strcmp(arr{idx}, str)
            out = true;
            return;
        end
    end
    out = false;
end