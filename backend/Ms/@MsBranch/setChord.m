function setChord(thisBranch)
    %  SETCHORD
    if thisBranch.twig == true
        error(['Cannot set branch as chord because it is marked as',...
               ' a twig.']);
    else
        thisBranch.chord = true;
    end
end