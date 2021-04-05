function ast = va2ast(inFileName, varargin)
% VA2MODSPEC translates a Verilog-A model into ModSpec format.
%
% va2modspec is the main user interface for VAPP. It translates a Verilog-A
% model into ModSpec format and prints the result into an output file. The name
% of the output file will be the module name with an ".m" extension. Note that
% the module name in the Verilog-A file can be different from the name of the
% file itself. 
%
% VAPP will require an 'include' directory where the files inserted into the
% model with the `include directives (such as `include "disciplines.vams") in
% the Verilog-A file are located. By default this directory is assumed to be in
% the same directory as the Verilog-A input file.
%       
% Usage:
%       va2modspec(path_to_input_file)
%           will take the path_to_input_file as the Verilog-A source, generate
%           the ModSpec model and write the output file to the current
%           directory. 
%
%       va2modspec(path_to_input_file, 'outputDir', path_to_output_directory)
%           will write the translated ModSpec file to path_to_output_directory 
%
%       va2modspec(path_to_input_file, 'include', path_to_include_directory)
%           will search for files in the path_to_include_directory that are
%           inserted into the mail Verilog-A file with `include statements.
%       
% Example:
% 
%   Given a Verilog-A file with the name 'example.va' and the module name
%   'example':
%
%       va2modspec('example.va');
%
%   will translate it into Modspec and write the output file to 'example.m'.
%   If there are any `include statements in example.va, VAPP will look for an
%   include directory (with the actual name 'include') in the same path as the
%   file.
%
%       va2modspec('example.va', 'outputDir', '~/modspec_models');
%
%   will translate 'example.va' and write the output to the '~/modspec_models'
%   directory. This directory has to exist prior to calling va2modspec.
%
%       va2modspec('example.va', 'outputDir', '~/modspec_models', ...
%                  'include', '~/va_models/include');
%
%   will look for an include directory at the location '~/va_models/inlcude'.
%
%   va2modspec can be called with only one of the options and the order of the
%   options can be arbitrary. I.e.,
%
%       va2modspec('example.va', 'include', '~/va_models/include');
%
%       va2modspec('example.va', 'include', '~/va_models/include', ...
%                  'outputDir', '~/modspec_models');
%
%See also
%--------
%VAPPquickstart, VAPPexamples, aboutVAPP
%

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================

    inPar = inputParser;
    inPar.addRequired('inFileName', @isstr);
    inPar.addParamValue('outFileName', '', @ischar);
    inPar.addParamValue('outputDir', '', @ischar);
    inPar.addParamValue('includeDir', '', @ischar);
    inPar.parse(inFileName, varargin{:});
    outFileName = inPar.Results.outFileName;
    outputDir = inPar.Results.outputDir;
    includeDir = inPar.Results.includeDir;

    % str_utils = VAPP_str_utils();

    % pre-process
    macro_definitions = {};
    working_dir = fileparts(inFileName);

    pre_process_parms.combine_lines_allow_whitespace = true;

    if isempty(includeDir)
        includeDir = fullfile(working_dir, 'include');
    end
    pre_process_parms.include_dirs = {includeDir};


    fprintf('Pre-processing and tokenizing...\n');
    tic;
    if exist(inFileName, 'file') == 2 % 2 excludes directories
        toks  = frontend.VAPP_pre_process(inFileName, macro_definitions, pre_process_parms);
        if isempty(toks)
            error(['Error while tokenizing the file. Please make sure that',...
                   ' the input file is syntactically correct.']);
        end
    else
        error('The file "%s" could not be found!' , inFileName);
    end

    processingTime = toc;
    fprintf('%.2f seconds\n', processingTime);

    % parse
    fprintf('Parsing...\n');
    tic;
    Ast = frontend.VAPP_parse(toks);

    % if error parsing
    if isempty(Ast)
        fprintf(2, 'Error while parsing the input file. Could not create AST.\n');
        return;
    end

    processingTime = toc;
    fprintf('%.2f seconds\n', processingTime);

    ast = Ast;
end
