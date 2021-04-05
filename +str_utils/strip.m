function out_str = strip(in_str)
    % remove whitespace from either end of a string
    out_str = str_utils.lstrip(str_utils.rstrip(in_str));
end