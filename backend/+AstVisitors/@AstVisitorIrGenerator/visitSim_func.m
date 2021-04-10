function out = visitSim_func(thisVisitor, sfNode)
    out{1} = true;
    name = sfNode.get_name();
    if strcmp(name, 'limexp') == true
        out = thisVisitor.visitFunc(sfNode);
    else
        out{2} = IrNodeSimulatorFunction(name);
    end
end