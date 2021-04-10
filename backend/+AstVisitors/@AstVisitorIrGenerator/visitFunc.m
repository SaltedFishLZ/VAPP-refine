function out = visitFunc(thisVisitor, funcNode)
    out{1} = true;
    funcName = funcNode.get_name();

    % NOTE: the below if condition should be removed when the noise
    % functions are implemented in MAPP.
    if funcNode.has_name('ddx')
        warningAtAstNode('ddx function was ignored.', funcNode);
        out{2} = IrNodeNumericalNull();
    elseif funcNode.has_name({'white_noise', 'flicker_noise'})
        out = thisVisitor.visitSim_func(funcNode);
    else
        out{2} = IrNodeFunction(funcName);

        % the treatment for special functions follows
        % the list below can be augmented with additional functions
        module = thisVisitor.module;
        if funcNode.has_name({'limexp', 'pow'}) == true
            % check if this function is defined in the module
            vappFuncName = strcat(funcName, '_vapp');
            if module.isFunc(vappFuncName) == false
                funcAst = parseAnalogFunc([vappFuncName, '.va']);
                temp = thisVisitor.visitAnalog_func(funcAst);
                aFunc = temp{2};
                module.addChild(aFunc);
            end
        end
    end
end