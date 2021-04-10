function out = visitDiscipline(thisVisitor, discipNode)
    % Don't create a tree node. Just import electrical nodes into the
    % module.
    module = thisVisitor.module;
    discipName = discipNode.get_name();
    nodeList = discipNode.get_attr('terminals');
    discip = struct();
    discipline.name = discipName;
    discipline.flow = discipNode.get_attr('flow');
    discipline.potential = discipNode.get_attr('potential');
    module.addDiscipline(discipline);
    % addDiscipline has to be called before addToNodeList
    module.addToNodeList(nodeList, discipName);
    out{1} = false;
    out{2} = IrNode.empty; % don't add an IrNode to the IR
end