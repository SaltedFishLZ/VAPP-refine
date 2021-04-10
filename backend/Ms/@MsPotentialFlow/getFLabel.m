function fLabel = getFLabel(thisPF)
% GETFLABEL
% The business of F/Q labels is a bit tricky.
% Inputs will never have f_pflabel type labels. They will always appear
% with their original labels.
% On the other hand, non input PFs that are also independent (note that
% this can only happen if that PF has a contribution and no probe) will
% have f_ and q_ parts.
% See also IrNodeOutput.getFLabel
    if thisPF.isIndependent() == true && thisPF.isInput() == false
        fLabel = ['f_', thisPF.getLabel()];
    else
        fLabel = thisPF.getLabel();
    end
end