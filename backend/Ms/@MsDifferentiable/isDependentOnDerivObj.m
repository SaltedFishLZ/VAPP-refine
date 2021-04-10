function out = isDependentOnDerivObj(thisDiffable, derivObj)
    % ISDEPENDENTONDERIVOBJ
    if isa(derivObj, 'MsPotentialFlow')
        out = thisDiffable.isDependentOnPf(derivObj);
    elseif isa(derivObj, 'MsVariable')
        out = thisDiffable.isDependentOnVar(derivObj);
    elseif isa(derivObj, 'MsParameter')
        out = thisDiffable.isDependentOnParm(derivObj);
    else
        error(['The supplied derivObj must be of one of the',...
               ' following clases: MsPotentialFlow, MsVariable,',...
               ' MsParameter!']);
    end
end