function labelArr = getNodeLabels(thisBranch)
    % GETNODELABELS
    labelArr = {thisBranch.node1.getLabel(), thisBranch.node2.getLabel()};
end