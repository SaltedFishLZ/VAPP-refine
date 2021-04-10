function [twigLabelList, chordLabelList] = getTwigChordLabelList(thisNetwork)
% GETTWIGCHORDLABELLIST
    twigLabelList = {};
    chordLabelList = {};

    [twigVec, chordVec] = thisNetwork.getTwigChordVec();

    for twigObj = twigVec
        twigLabelList = [twigLabelList, {twigObj.getLabel}];
    end

    for chordObj = chordVec
        chordLabelList = [chordLabelList, {chordObj.getLabel}];
    end
end