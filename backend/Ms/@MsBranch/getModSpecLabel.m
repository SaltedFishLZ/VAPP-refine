function label = getModSpecLabel(thisBranch)
    % GETMODSPECLABEL returns a label that can be used when marking
    % explicit outputs and internal unks in the ModSpec wrapper.
    % For this, we exchange the order of nodes if the first node is the
    % reference node.

    node1 = thisBranch.node1;
    node2 = thisBranch.node2;

    if node1.isReference() == false
        label = thisBranch.label;
    else
        label = strcat(node2.getLabel(), node1.getLabel());
    end

end
