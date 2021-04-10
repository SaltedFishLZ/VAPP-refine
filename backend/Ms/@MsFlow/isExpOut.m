function out = isExpOut(thisFlow)
    % ISEXPOUT
    % a branch flow is never an explicit out. Only terminal node flows
    % can be explicit outs.
    out = false;
end