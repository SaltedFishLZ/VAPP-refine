function out = isInImplicitEqn(thisBranch)
    % ISINIMPLICITEQN
        if thisBranch.flowObj.isInImplicitEqn() == true || ...
                    thisBranch.potentialObj.isInImplicitEqn() == true
            out = true;
        else
            out = false;
        end
    end