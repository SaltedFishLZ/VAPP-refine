classdef MsModel < handle
% MSMODEL

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Dec 06, 2016  12:52PM
%==============================================================================
    properties (Constant)
        VARSFX = '__';
    end

    properties
        refNode = MsNode.empty;

        % note that contrary to vars and parms funcs are not ModSpec objects.
        % They are IrNode objects.
        nFeQe = 0;          %
        nFiQi = 0;   % number of internal equations (includes implicit equations)

        implicitContribVec = IrNodeContribution.empty;
        nImplicitContrib = 0;

        expOutList = {};
        intUnkList = {};

        analogNode = IrNodeAnalog.empty;
        intEqnIdx = 0; % internal equation index (includes internal nodes, 
                       % otherIO equations and implicit equations).
        intEqnNameList = {};
        nodeCollapseTree = IrNode.empty;

        % prev
        module = IrNodeModule.empty;
        network = MsNetwork.empty;
        parmMap = containers.Map();
        expOutPotentialVec  = MsPotential.empty
        expOutFlowVec       = MsFlow.empty;
        intUnkPotentialVec  = MsPotential.empty;
        intUnkFlowVec       = MsFlow.empty;
        otherIoPotentialVec = MsPotential.empty;
        otherIoFlowVec      = MsFlow.empty;
        expOutPfVec         = MsPotential.empty;
        intUnkPfVec         = MsPotential.empty;
        otherIoPfVec        = MsPotential.empty;

        nExpOut  = 0;
        nIntUnk  = 0;
        nOtherIo = 0;
        
        ioDefTree = IrNode.empty;
        outputTree = IrNode.empty;
        collapsedBranchVec = MsBranch.empty;
    end

    methods

        function obj = MsModel(module, collapsedBranchVec)
        % MSMODEL
            obj.module = module;
            network = module.getNetwork();
            obj.network = network;
            obj.refNode = network.getRefNode();
            obj.parmMap = containers.Map();
            if nargin > 1
                obj.collapsedBranchVec = collapsedBranchVec;
            end
            obj.seal();
        end





























































    % end methods
    end

% end classdef
end
