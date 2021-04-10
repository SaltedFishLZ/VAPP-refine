function outStr = sprintInit(thisParm, parmIdx)
% INITPARM

    outStr = '';
    parmName = thisParm.getName();
    if thisParm.isDependentOnOtherParm() == false
        outStr = [outStr, parmName, ' = ', ...
                                sprintf('MOD__.parm_vals{%d};\n', parmIdx)];
    else
        insValTree = thisParm.getInsValTree();
        insValStr = insValTree.sprintAll();
        outStr = [outStr,...
                  sprintf(['if MOD__.parm_given_flag(%d) == true\n',...
                            '    ', parmName, ' = MOD__.parm_vals{%d};\n',...
                            'else\n',...
                            '    ', parmName, ' = ', insValStr, ';\n',...
                            'end\n'], parmIdx, parmIdx)];
    end

end