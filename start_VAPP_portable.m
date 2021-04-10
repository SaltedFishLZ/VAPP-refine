% START_VAPP setup VAPP paths
%
% Call start_VAPP from the top-level directory where the VAPP files are located
% in order to setup paths to all the source files.
%
% See also VA2MODSPEC

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Fri Feb 24, 2017  06:14PM
%==============================================================================

VAPPTOP='/home/vapp/VAPP-refine';
addpath(VAPPTOP);
addpath(sprintf('%s/backend',                            VAPPTOP));
addpath(sprintf('%s/backend/IrVisitors',                  VAPPTOP));
addpath(sprintf('%s/backend/Ms',                         VAPPTOP));
addpath(sprintf('%s/backend/IrNodes',                     VAPPTOP));
addpath(sprintf('%s/backend/utils',                      VAPPTOP));
addpath(sprintf('%s/backend/print_templates',            VAPPTOP));
addpath(sprintf('%s/include',                            VAPPTOP));
addpath(sprintf('%s/doc',                                VAPPTOP));
fprintf('VAPP paths have been set up.\n\n');
