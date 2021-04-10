function setCollapsed(thisBranch)
    % SETCOLLAPSED
    if thisBranch.isOuter() == false
        thisBranch.collapsed = true;
    elseif thisBranch.collapsedWarningDisplayed == false
        %error(['The branch %s cannot be collapsed because it',...
        %       ' connects two terminal nodes!'], thisBranch.label);
        % We allow the collapse of a branch that connects two external
        % nodes (terminals) because hicum does it but this should
        % really be disallowed.
        nodeLabelArr = thisBranch.getNodeLabels();
        fprintf(2, ['Warning: a branch is collapsed that connects',...
                    ' two terminals: (%s, %s).\n'], nodeLabelArr{1},...
                                                    nodeLabelArr{2});
        thisBranch.collapsedWarningDisplayed = true;
    end
end