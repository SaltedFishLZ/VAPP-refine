function [cutNodeVec, direction] = getCutNodes(thisNetwork, twigObj)
    % GETCUTNODES returns the node objects that are inside of a given cut
    % The cut is described by the twigObj (since every twig corresponds to
    % a cut).
    if twigObj.isTwig() == false
        error(['The argument to this function must be a branch',...
               ' object which has been marked as a twig!']);
    end

    % A cut separates a network into two unconnected components.
    % One of these components will inlcude the reference node.
    % Because we don't have access to the flow into the reference
    % node (unless we sum all the other flows into the remaining
    % terminals), we will always use the set of nodes that don't
    % include the reference node.

    [twigNode1, twigNode2] = twigObj.getNodes();
    refNode = thisNetwork.getRefNode();

    cutNodeVec = MsNetwork.traverseTreeComponent(twigNode1, twigObj);
    direction = 1;
    if any(cutNodeVec == refNode) == true
        cutNodeVec = MsNetwork.traverseTreeComponent(twigNode2, twigObj);
        direction = -1;
        % note: this should be cheaper than doing a setdiff
    end
end