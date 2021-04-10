% ISOUTER
function out = isOuter(thisBranch)
    nodeObj1 = thisBranch.node1;
    nodeObj2 = thisBranch.node2;
    out = (nodeObj1.isTerminal() && nodeObj2.isTerminal());
end