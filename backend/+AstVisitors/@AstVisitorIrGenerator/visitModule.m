function out = visitModule(thisVisitor, moduleNode)
    out{1} = true;

    name = moduleNode.get_name();
    terminalList = moduleNode.get_attr('terminals');
    module = IrNodeModule(name, terminalList);
    thisVisitor.module = module;
    out{2} = module;
end