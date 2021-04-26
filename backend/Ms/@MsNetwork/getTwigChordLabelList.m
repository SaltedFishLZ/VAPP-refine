function [twigLabelList, chordLabelList] = getTwigChordLabelList(thisNetwork)
% GETTWIGCHORDLABELLIST
    twigLabelList = {};
    chordLabelList = {};

    [twigVec, chordVec] = thisNetwork.getTwigChordVec();

    for twigObj = twigVec
        % DEBUG: why append a method here?
        disp(twigLabelList)
        twigLabelList = [twigLabelList, {twigObj.getLabel}];
    end

    for chordObj = chordVec
        % DEBUG: why append a method here?
        disp(chordLabelList)
        chordLabelList = [chordLabelList, {chordObj.getLabel}];
    end
end