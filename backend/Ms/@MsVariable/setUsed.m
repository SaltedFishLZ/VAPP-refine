function setUsed(thisVar)
    if thisVar.used == false
        thisVar.used = true;
        if thisVar.init == true
            thisVar.usedBeforeInit = false;
        else
            thisVar.usedBeforeInit = true;
        end
    end
end