function aFuncAst = parseAnalogFunc(fileName)
    funcPath = mfilename('fullpath');
    fileDir = fileparts(funcPath);
    filePath = fullfile(fileDir, '/', fileName);

    ppArgs.combine_lines_allow_whitespace = true;
    ppArgs.include_dirs = {};
    % strUtils = VAPP_str_utils();
    toks = frontend.VAPP_pre_process(filePath, {}, ppArgs);
    aFuncRoot = frontend.VAPP_parse(toks);
    aFuncAst = aFuncRoot.get_child(1);
end
