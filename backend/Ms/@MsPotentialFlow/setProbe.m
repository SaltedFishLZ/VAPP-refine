function setProbe(thisPF, pIdx)
% SETPROBE
    thisPF.probe = true;
    if pIdx < thisPF.probeIdx
        thisPF.setProbeIdx(pIdx);
    end
end
