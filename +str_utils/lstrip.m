function out_str = lstrip(in_str)
    % remove whitespace from the beginning of a string
    idx = 1;
    while idx <= length(in_str) && str_utils.is_whitespace_char(in_str(idx))
        idx = idx + 1;
    end
    out_str = in_str(idx:end);
end