function setTerminal(thisNode)
% SETTERMINAL
    thisNode.terminal = true;
    thisNode.terminalFlow = MsTerminalFlow(thisNode);
end