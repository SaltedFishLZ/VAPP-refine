function out = visitSim_var(thisVisitor, svNode)
    %error(['Error at: $%s. ',...
    %      'MAPP currently does not support simulator variables!'],...
    %                                                svNode.get_name());
    out = thisVisitor.visitSim_func(svNode);
end