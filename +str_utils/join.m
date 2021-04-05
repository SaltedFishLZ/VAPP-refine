function out_str = join(join_chars, strs)

    % similar to Python's join_chars.join(list_of_strings) function
        % except here, strs is a cell array of strings

    if length(strs) == 0
        out_str = '';
        return;
    end

    out_str = strs{1};
    for idx = 2:1:length(strs)
        out_str = [out_str, join_chars, strs{idx}];
    end

end