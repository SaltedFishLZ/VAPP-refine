function out = hasContrib(thisBranch)
    % HASCONTRIB
    if thisBranch.flowObj.isContrib() == true || ...
                thisBranch.potentialObj.isContrib() == true
        out = true;
    else
        out = false;
    end
end