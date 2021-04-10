function setTwig(thisBranch)
    % SETTWIG
    if thisBranch.chord == true
        error(['Cannot set branch as twig because it is marked as',...
               ' a chord.']);
    else
        thisBranch.twig = true;
    end
end