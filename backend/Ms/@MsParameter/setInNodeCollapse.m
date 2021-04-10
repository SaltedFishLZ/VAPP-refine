function setInNodeCollapse(thisParm)
% SETINNODECOLLAPSE
    thisParm.inNodeCollapse = true;
    for dependParm = thisParm.dependParmVec
        dependParm.setInNodeCollapse();
    end
end