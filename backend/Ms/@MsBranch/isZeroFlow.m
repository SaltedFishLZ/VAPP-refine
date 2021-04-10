function out = isZeroFlow(thisBranch)
    % ISZEROFLOW
    if thisBranch.isInImplicitEqn() == false && ...
                                    thisBranch.hasContrib() == false
        out = true;
    else
        out = false;
    end
end