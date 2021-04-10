function out = visitInput(thisVisitor, inputNode)
    % this will be only used if we  are inside of a function body
    out{1} = true;
    out{2} = IrNode.empty;

    func = thisVisitor.module;
    inputList = inputNode.get_attr('inputs');
    func.setInputList(inputList);
end