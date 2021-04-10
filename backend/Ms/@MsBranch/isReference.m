function out = isReference(thisBranch)
    % outer branch -> one terminal node and one reference node
    nodeObj1 = thisBranch.node1;
    nodeObj2 = thisBranch.node2;
    out = (nodeObj1.isTerminal() && nodeObj2.isReference()) || ...
          (nodeObj2.isTerminal() && nodeObj1.isReference());

end