function out = str_arr_to_str(str_arr)

    % Convert a cell array of strings into a single string

    quoted_str_arr = {};
    for idx = 1:1:length(str_arr)
        quoted_str = ['''', str_arr{idx}, ''''];
        quoted_str_arr = [quoted_str_arr, {quoted_str}];
    end
    
    out = ['{', join(', ', quoted_str_arr), '}'];

end