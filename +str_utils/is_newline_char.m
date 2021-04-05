function out = is_newline_char(ch)
    % returns true if ch is a newline character, else returns false
    newline_chars = sprintf('\n\r');
    out = str_utils.ch_in_str(ch, newline_chars);
end