function out = ch_in_str(ch, str)
    % returns true if ch is in str, else returns false
    for idx = 1:1:length(str)
        if ch == str(idx)
            out = true;
            return;
        end
    end
    out = false;
end
