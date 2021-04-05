function out = is_whitespace(str)
    % returns true if str is full of whitespace chars, else returns false
    for idx = 1:1:length(str)
        ch = str(idx);
        if ~str_utils.is_whitespace_char(ch)
            out = false;
            return
        end
    end
    out = true;
end