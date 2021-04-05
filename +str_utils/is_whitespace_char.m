function out = is_whitespace_char(ch)
    % returns true if ch is a whitespace character, else returns false
    whitespace_chars = sprintf(' \t\n\r');
    out = str_utils.ch_in_str(ch, whitespace_chars);
end