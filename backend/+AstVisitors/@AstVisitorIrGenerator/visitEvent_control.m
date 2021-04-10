function out = visitEvent_control(thisVisitor, eventNode)
    if eventNode.has_name('initial_step')
        out{1} = true;
        out{2} = IrNodeBlock(0);
    else
        fprintf(2, ['Warning: The event control statement @(%s) was',...
                                     ' ignored.\n'], eventNode.get_name());
        out{1} = false;
        out{2} = [];
    end
end