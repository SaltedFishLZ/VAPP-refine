function qLabel = getQLabel(thisPF)
% GETQLABEL
% see comments in the getFLabel method above
    if thisPF.isIndependent() == true && thisPF.isInput() == false
        qLabel = ['q_', thisPF.getLabel()];
    else
        qLabel = '';
    end
end