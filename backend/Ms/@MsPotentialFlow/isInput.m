function out = isInput(thisPF)
% ISINPUT
    out = (thisPF.isIntUnk() == true || thisPF.isOtherIo() == true);
end