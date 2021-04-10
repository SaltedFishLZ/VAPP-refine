function addDependPf(thisVar, pfObj)
% ADDDEPENDPF
    if thisVar.inNodeCollapse == true
        error(['A node collapse statement depends on the variable',...
               ' "%s" whose value depends on the potential/flow',...
               ' "%s". Bias dependent node collapse statements are',...
               ' not allowed!'], thisVar.getLabel(), pfObj.getLabel());
    end
    addDependPf@MsDifferentiable(thisVar, pfObj);
end