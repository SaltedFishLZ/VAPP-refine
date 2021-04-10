function out = visitAnalog_func(thisVisitor, afNode)
    % create an IrNodeAnalogFunction node which is a subclass of the
    % IrNodeModule class.
    out{1} = false;
    module = thisVisitor.module;
    funcName = afNode.get_name();
    afunc = IrNodeAnalogFunction(funcName);
    funcGen = AstVisitors.AstVisitorIrGenerator();
    funcGen.module = afunc; % NOTE: this seems a bit ugly
    % we set the function hashtable (funcMap) of afunc below
    % this is because we later check for valid functions (see
    % IrVisitorMark1). This check is performed in user defined
    % functions as well. Hence, a user defined function (afunc below)
    % must be aware of other functions.
    % Note that the map returned by module.getFuncMap is a pointer to
    % the hashtable object. Hence, future changes on this object will
    % be visible within afunc.
    afunc.setFuncMap(module.getFuncMap);
    % Skip the analog_func AST node and traverse its children.
    funcGen.traverseChildren(afNode, afunc);
    module.addFunc(afunc);
    out{2} = afunc;
end