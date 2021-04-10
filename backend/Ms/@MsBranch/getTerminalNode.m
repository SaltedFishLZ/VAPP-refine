function tNode = getTerminalNode(thisBranch)
    if thisBranch.isReference() == true
        nodeObj1 = thisBranch.node1;
        nodeObj2 = thisBranch.node2;
        if nodeObj1.isTerminal() == true
            tNode = nodeObj1;
        else
            tNode = nodeObj2;
        end
    else
        error(['Cannot get terminal node. This branch is not a',...
               ' reference branch!']);
    end

end