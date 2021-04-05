function out_str = rstrip(in_str)
    % remove whitespace from the end of a string
    idx = length(in_str);
    while idx > 0 && str_utils.is_whitespace_char(in_str(idx))
        idx = idx - 1;
    end
    out_str = in_str(1:idx);
end