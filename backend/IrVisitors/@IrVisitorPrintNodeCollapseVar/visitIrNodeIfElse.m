function traverseSub = visitIrNodeIfElse(thisVisitor, ifElseNode)
    % VISITIRNODEIFELSE
    traverseSub = false;
    condNode = ifElseNode.getChild(1);

    thenNode = ifElseNode.getChild(2);
    thenVisitor = IrVisitorPrintNodeCollapseVar(thenNode);
    thenStr = thenVisitor.getNcStr();

    elseStr = '';
    if ifElseNode.getNChild() > 2
        elseNode = ifElseNode.getChild(3);
        elseVisitor = IrVisitorPrintNodeCollapseVar(elseNode);
        elseStr = elseVisitor.getNcStr();
    end

    % switch thenStr with elseStr if thenStr isempty (and thenStr is
    % not).
    if isempty(thenStr) == true && isempty(elseStr) == false
        condNode = IrNodeNumerical.getNegationOfNode(condNode.copyDeep());
        thenStr = elseStr;
        elseStr = '';
    end

    % at this point if thenStr is empty, we don't print the if else
    % statement.
    ncStr = '';
    if isempty(thenStr) == false
        ncStr = ['if ', condNode.sprintAll(), '\n'];
        ncStr = [ncStr, ...
                 ifElseNode.sprintfIndent(thenStr)];
        if isempty(elseStr) == false
            ncStr = [ncStr, 'else\n'];
            ncStr = [ncStr, ...
                    ifElseNode.sprintfIndent(elseStr)];
        end
        ncStr = [ncStr, 'end\n'];
    end
    thisVisitor.ncStr = [thisVisitor.ncStr, ncStr];
end