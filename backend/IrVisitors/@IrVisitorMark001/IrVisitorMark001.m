classdef IrVisitorMark001 < IrVisitor
% IRVISITORMARKDEVICECOMPONENTS (Visitor order) = 1
%
% This visitor has to be run first.
% It traverses assignments and contributions and marks nodes and branches.
% Nodes and branches are marked as contributed or probed
%
% The job of IrVisitorMark1 is the following:
% 1. Visit assignments and find out which variables are being initialized
% 2. Visit contributions and mark them as explicit/implicit/nullEqn
%    discover dummy IOs if any. 
% 3. mark variables as initialized/uninitialized and as used/unused
% 4. mark Potential and Flow objects as contribs and probes
% 5. mark potential and flows as lhs if they are on the LHS of a contribution

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================

% NOTE: when implementing contrib/probe tokens ->
% probe token is assigned at the first probe and does not chage afterwards
% contrib token is assigned anew at every encounter with a contribution

    properties
        module = IrNodeModule.empty;
    end

    methods

        function obj = IrVisitorMark001(irTree)
            if nargin > 0
                obj.traverseIr(irTree);
            end
        end
    
    % end methods
    end

% end classdef
end 
