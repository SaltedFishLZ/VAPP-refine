function setInit(thisVar)
    if thisVar.init == false
        thisVar.init = true;
        if thisVar.used == true
            thisVar.usedBeforeInit = true;
        else
            thisVar.usedBeforeInit = false;
        end
    end
end