classdef MsPotentialFlow < MsDifferentiable & matlab.mixin.Heterogeneous
% MSPOTENTIALFLOW superclass for potentials and flows

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Dec 13, 2016  11:22AM
%==============================================================================
    properties (Access = protected)
        node1 = MsNode.empty;
        node2 = MsNode.empty;
        branch = MsBranch.empty;
        contrib = false;
        probe = false;
        source = false;
        contribAfterProbe = false;
        inImplicitEqn = false;
        contribIdx = 0; % assinged by an IrVisitorMark001 class.
        probeIdx = Inf;   % these indices are incremented by one,
                        % everytime an access node is encountered
        outIdx = 0; % index (if any) in fe/qe/fi/qi vectors
        inIdx = 0; % input index in vecX, vecY
        labelPrefix = '';
        nature; % struct. fields: access, abstol, name, etc.
        savedState; % used to save the properties of this PF that depend on the
                    % model, i.e., for different configurations of the network
                    % caused by node collapse
    end

    methods (Abstract)
        out = isExpOut(thisPF);
        out = isIntUnk(thisPF);
        out = isOtherIo(thisPF);
        out = isIndependent(thisPF);
        msl = getModSpecLabel(thisPF);
    % end Abstract methods
    end

    methods
        
    % end methods
    end

    methods (Access = private)
        function setContribIdx(thisPF, cIdx)
        % SETCONTRIBIDX
            if thisPF.contribIdx > cIdx
                error(['Error setting contribIdx. The new contribIdx',...
                       ' cannot be smaller than the old one!']);
            else
                thisPF.contribIdx = cIdx;
            end
        end

        function setProbeIdx(thisPF, pIdx)
        % SETPROBEIDX
            if thisPF.probeIdx < pIdx
                error(['Error setting probeIdx. The new probeIdx cannot be',...
                       ' greater than the old one!']);
            else
                thisPF.probeIdx = pIdx;
            end
        end
    % end private methods
    end

    methods (Sealed)
        function out = eq(thisPF, otherPF)
            out = eq@handle(thisPF, otherPF);
        end

        function out = ne(thisPF, otherPF)
            out = ne@handle(thisPF, otherPF);
        end
    end

    methods (Static)
        function out = isPotential()
        % ISPOTENTIAL
            out = false;
        end

        function out = isFlow()
        % ISFLOW
            out = false;
        end

        function out = isInNodeCollapse()
        % ISINNODECOLLAPSE
        % required for IrVisitorPrintNodeCollapseVar. Because the
        % dependent PF assignments right at the beginning at the module return
        % an error otherwise when probed with
        % IrVisitorPrintNodeCollapseVar.
            out = false;
        end
    end
    
% end classdef
end
