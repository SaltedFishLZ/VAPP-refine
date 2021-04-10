function setContrib(thisPF, cIdx)
% SETCONTRIB
    thisPF.contrib = true;
    if cIdx > thisPF.contribIdx
        thisPF.setContribIdx(cIdx);
    end
end