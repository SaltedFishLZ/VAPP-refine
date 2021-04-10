function [potentialEqnBlock, flowEqnBlock] = generateIntUnkEqn(thisModel)
    % GENERATEINTERNALEQUATIONS generates loop and cutset (kvl, kcl) and
    % constitutive equations for internal unknowns.
    % These equations will appear at the end of the module and will be
    % assigned to the entries of the fi and qi vectors.
    % Possible cases:
    % First look at if a branch is a twig or a chord.
    % 1. A branch is a twig
    %   1.1 A twig can only have a potential as an internal unk.
    %   Does it have one?
    %   If yes, there are two more possibilities:
    %       1.1.1 twig has a POTENTIAL contribution
    %
    %           constitutive equation
    %               e.g.,
    %                   V(p,n) <+ fnc(I(p,i))
    %               then
    %                   fi(idx) = potential_pi - fnc(flow_pi);
    %       1.1.2 twig has a FLOW contribution
    %
    %           cutset equation:
    %               e.g.,
    %                   I(p,i) <+ fnc(V(p,i));
    %               then
    %                   fi(idx) = flow_pi - (cutset flow definition of flow_pi)
    %
    % 2. A branch is a chord
    %   2.1 A chord can only have a flow as an internal unk.
    %   Does it have one?
    %       2.1.1 chord has FLOW contrib
    %           constitutive equation
    %           I(p,i) <+ fnc(V(p,i))
    %           => fi(idx) = flow_pi - fnc(potential_pi);
    %       2.1.2 chord has POTENTIAL contrib
    %           loop equation
    %           => fi(idx) = potential_pi - (loop potential definition for
    %                                        potential_pi)

    % we get the lists from module properties:
    % intlUnkPotentialVec
    % intlUnkFlowVec
    intUnkIdx = 0;
    potentialEqnBlock = IrNodeBlock();
    flowEqnBlock = IrNodeBlock();
    potentialEqnBlock.setIndentLevel(0); 
    flowEqnBlock.setIndentLevel(0); 
    intEqnNameList = {};

    for potential = thisModel.intUnkPotentialVec
        twig = potential.getBranch();
        flow = twig.getFlow();

        % branch has to be a twig.
        if potential.isContrib() == true || flow.isContrib() == true

            % set outIdx of the potential internal unk
            intUnkIdx = intUnkIdx + 1;
            potential.setOutIdx(intUnkIdx);
            outNode = IrNodeOutput(potential);
            outNode.setOutIdx(intUnkIdx);
            if potential.isContrib() == true 
                % use the constitutive equation for this potential
                % the lhs is an output.
                % below we are going to subtract two nodes. This will be of
                % the form 
                % (potentail_pi_int_unk) - (potential_pi_from_contributions)
                % potential_pi is the variable we will use during
                % computations in the module body. And
                % potential_pi_from_contributions is the variable we will
                % assign all the contributions for this potential. For
                % those contributions potential_pi_from_contributions will
                % be on the LHS of the contribution assignment. Although in
                % the equation we are constructing here
                % potential_pi_from_contributions is on the RHS, we will
                % set it as LHS so that the right variable name gets
                % printed.
                intEqnName = ['constitutive equation for ', ...
                                                potential.getLabel()];
                lhsNode = IrNodePotentialFlow(potential);
                rhsPfVec = potential;
                signVec = 1;
                % the line below is no typo. We really set the rhsNode as
                % lhs. For an explanation see the comment immediately
                % above.
            else % flow.isContrib() == true
                % use the cutset equation for this twig's flow
                intEqnName = ['KCL for ', flow.getLabel()];
                lhsNode = IrNodePotentialFlow(flow);
                [rhsPfVec, signVec] = ...
                    thisModel.generateCutEqnPfVecWithTerminalFlows(twig);
            end

            lhsNode.setLhs();
            outNode.addChild(lhsNode);
            outNode.setRhsPfVec(rhsPfVec);
            outNode.setRhsSignVec(signVec);
            potentialEqnBlock.addChild(outNode);

            intEqnNameList = [intEqnNameList, {intEqnName}];
            thisModel.nFiQi = thisModel.nFiQi + 1;

        else
            % I don't know if this situation can occur.
            % TODO: do a formal analysis for this situation
            % UPDATE: this situation can occur when twig is an outer
            % banch
            % this situation can occur when there is an implicit
            % equation for this potential
        end

    end


    for flow = thisModel.intUnkFlowVec
        chord = flow.getBranch();
        potential = chord.getPotential();

        if flow.isContrib() == true || potential.isContrib() == true
            % set outIdx of the flow internal unk
            intUnkIdx = intUnkIdx + 1;
            flow.setOutIdx(intUnkIdx);
            outNode = IrNodeOutput(flow);
            outNode.setOutIdx(intUnkIdx);
            if flow.isContrib() == true
                % use the constitutive equation
                intEqnName = ['constitutive equation for ', ...
                                                     flow.getLabel()];
                lhsNode = IrNodePotentialFlow(flow);
                rhsPfVec = flow;
                signVec = 1;
                % the below line is no typo. See comment in the first half
                % of this method.
            else % potential.isContrib() == true
                % use the loop equation for this chord's potential
                intEqnName = ['KVL for ', potential.getLabel()];
                lhsNode = IrNodePotentialFlow(potential);
                [rhsPfVec, signVec] = thisModel.generateLoopEqnPfVec(chord);
            end

            lhsNode.setLhs();
            outNode.addChild(lhsNode);
            outNode.setRhsPfVec(rhsPfVec);
            outNode.setRhsSignVec(signVec);
            flowEqnBlock.addChild(outNode);

            intEqnNameList = [intEqnNameList, {intEqnName}];
            thisModel.nFiQi = thisModel.nFiQi + 1;
        else
            % this situation can occur when there is an implicit
            % equation for this flow
            %continue;
        end

    end

    thisModel.intEqnIdx = intUnkIdx;
    thisModel.intEqnNameList = [thisModel.intEqnNameList, intEqnNameList];

% end generateIntUnkEqn
end