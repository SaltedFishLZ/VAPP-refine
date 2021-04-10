function out = visitAnalog(thisVisitor, analogNode)
    out{1} = true;
    analog = IrNodeAnalog();
    analog.setIndentLevel(0);
    thisVisitor.module.setAnalogNode(analog);
    out{2} = analog;
end
