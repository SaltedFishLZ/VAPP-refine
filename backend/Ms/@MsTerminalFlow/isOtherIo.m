function out = isOtherIo(thisFlow)
% ISOTHERIO
    out = false;
    terminalNode = thisFlow.terminal;
    if terminalNode.isReference() == false
        if thisFlow.isExpOut() == false
            out = true;
        end
    end
end