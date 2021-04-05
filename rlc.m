function MOD = rlc(uniqID)

%===============================================================================
% This file was created using VAPP, the Berkeley Verilog-A Parser and Processor.   
% Last modified: 04-Apr-2021 17:11:23
% VAPP version: no_branch_name:fffffff
%===============================================================================

    MOD = ModSpec_common_skeleton();

    MOD.parm_types = {};
    MOD.u_names = {};
    MOD.IO_names = {};
    MOD.OtherIO_names = {};
    MOD.NIL.io_types = {};
    MOD.NIL.io_nodenames = {};
    MOD.limited_var_names = {};
    MOD.vecXY_to_limitedvars_matrix = [];
    MOD.uniqID = [];

    MOD.support_initlimiting = 1;

    if nargin > 0
        MOD.uniqID = uniqID;
    end

    MOD.model_name = 'rlc';
    MOD.NIL.node_names = {'p', 'n'};
    MOD.NIL.refnode_name = 'n';

    parmNameDefValArr = {'parm_L', 0.001,...
                         'parm_R', 1000,...
                         'parm_C', 1e-12};

    nParm = 3;
    MOD.parm_names = {};
    MOD.parm_defaultvals = {};
    MOD.parm_vals = {};
    MOD.parm_given_flag = zeros(1, nParm);
    for parmIdx = 1:nParm
        MOD.parm_names{parmIdx} = parmNameDefValArr{2*parmIdx-1};
        MOD.parm_defaultvals{parmIdx} = parmNameDefValArr{2*parmIdx};
        MOD.parm_vals{parmIdx} = parmNameDefValArr{2*parmIdx};
    end

    [eonames, iunames, ienames] = get_oui_names__(MOD);
    MOD.explicit_output_names = eonames;
    MOD.internal_unk_names = iunames;
    MOD.implicit_equation_names = ienames;
    MOD.InternalUnkNames = @get_iu_names__;
    MOD.ImplicitEquationNames = @get_ie_names__;

    MOD = setup_IOnames_OtherIOnames_IOtypes_IOnodenames(MOD);

    MOD.fqeiJ = @fqeiJ;
    MOD.fe = @fe_from_fqeiJ_ModSpec;
    MOD.qe = @qe_from_fqeiJ_ModSpec;
    MOD.fi = @fi_from_fqeiJ_ModSpec;
    MOD.qi = @qi_from_fqeiJ_ModSpec;
    MOD.fqei = @fqei_from_fqeiJ_ModSpec;
    MOD.fqeiJ = @fqeiJ;

    MOD.dfe_dvecX = @dfe_dvecX_from_fqeiJ_ModSpec;
    MOD.dfe_dvecY = @dfe_dvecY_from_fqeiJ_ModSpec;
    MOD.dfe_dvecLim = @dfe_dvecLim_from_fqeiJ_ModSpec;
    MOD.dfe_dvecU = @dfe_dvecU_from_fqeiJ_ModSpec;

    MOD.dqe_dvecX = @dqe_dvecX_from_fqeiJ_ModSpec;
    MOD.dqe_dvecY = @dqe_dvecY_from_fqeiJ_ModSpec;
    MOD.dqe_dvecLim = @dqe_dvecLim_from_fqeiJ_ModSpec;

    MOD.dfi_dvecX = @dfi_dvecX_from_fqeiJ_ModSpec;
    MOD.dfi_dvecY = @dfi_dvecY_from_fqeiJ_ModSpec;
    MOD.dfi_dvecLim = @dfi_dvecLim_from_fqeiJ_ModSpec;
    MOD.dfi_dvecU = @dfi_dvecU_from_fqeiJ_ModSpec;

    MOD.dqi_dvecX = @dqi_dvecX_from_fqeiJ_ModSpec;
    MOD.dqi_dvecY = @dqi_dvecY_from_fqeiJ_ModSpec;
    MOD.dqi_dvecLim = @dqi_dvecLim_from_fqeiJ_ModSpec;
end

function [fqei_out, J_out] = fqeiJ(vecX, vecY, vecLim, vecU, flag, MOD)
    if nargin < 6
        MOD = flag;
        flag = vecU;
        vecU = vecLim;
    end

    [fe, qe, fi, qi, d_fe_d_X, d_qe_d_X, d_fi_d_X, d_qi_d_X,...
    d_fe_d_Y, d_qe_d_Y, d_fi_d_Y, d_qi_d_Y] = fqei_dfqeidXYU(vecX, vecY, MOD);

    fqei_out.fe = fe;
    fqei_out.qe = qe;
    fqei_out.fi = fi;
    fqei_out.qi = qi;

    [nFeQe, nFiQi] = get_nfq__(MOD);

    J_out.Jfe.dfe_dvecX = d_fe_d_X;
    J_out.Jqe.dqe_dvecX = d_qe_d_X;
    J_out.Jfi.dfi_dvecX = d_fi_d_X;
    J_out.Jqi.dqi_dvecX = d_qi_d_X;
    J_out.Jfe.dfe_dvecY = d_fe_d_Y;
    J_out.Jqe.dqe_dvecY = d_qe_d_Y;
    J_out.Jfi.dfi_dvecY = d_fi_d_Y;
    J_out.Jqi.dqi_dvecY = d_qi_d_Y;
    J_out.Jfe.dfe_dvecU = zeros(nFeQe,0);
    J_out.Jfi.dfi_dvecU = zeros(nFiQi,0);
    J_out.Jfe.dfe_dvecLim = zeros(nFeQe, 0);
    J_out.Jqe.dqe_dvecLim = zeros(nFeQe, 0);
    J_out.Jfi.dfi_dvecLim = zeros(nFiQi, 0);
    J_out.Jqi.dqi_dvecLim = zeros(nFiQi, 0);
end

function [fe__, qe__, fi__, qi__,...
          d_fe_d_X__, d_qe_d_X__, d_fi_d_X__, d_qi_d_X__,...
          d_fe_d_Y__, d_qe_d_Y__, d_fi_d_Y__, d_qi_d_Y__] = ...
         fqei_dfqeidXYU(vecX__, vecY__, MOD__)

    % initializing parameters
    parm_L = MOD__.parm_vals{1};
    parm_R = MOD__.parm_vals{2};
    parm_C = MOD__.parm_vals{3};

    [nFeQe__, nFiQi__, nOtherIo__, nIntUnk__] = get_nfq__(MOD__);

    % Initializing outputs
    fe__ = zeros(nFeQe__,1);
    qe__ = zeros(nFeQe__,1);
    fi__ = zeros(nFiQi__,1);
    qi__ = zeros(nFiQi__,1);
    % Initializing derivatives
    d_fe_d_X__ = zeros(nFeQe__,nOtherIo__);
    d_qe_d_X__ = zeros(nFeQe__,nOtherIo__);
    d_fi_d_X__ = zeros(nFiQi__,nOtherIo__);
    d_qi_d_X__ = zeros(nFiQi__,nOtherIo__);
    d_fe_d_Y__ = zeros(nFeQe__,nIntUnk__);
    d_qe_d_Y__ = zeros(nFeQe__,nIntUnk__);
    d_fi_d_Y__ = zeros(nFiQi__,nIntUnk__);
    d_qi_d_Y__ = zeros(nFiQi__,nIntUnk__);
    % initializing variables
    d_CapacitorCharge_d_v_internal2n__ = 0;
    d_CapacitorCharge_d_v_pinternal1__ = 0;
    d_CapacitorCharge_d_v_pn__ = 0;
    d_InductorCurrent_d_i_internal1internal2__ = 0;
    d_f_i_internal1internal2_d_i_internal1internal2__ = 0;
    d_f_i_internal1internal2_d_v_internal2n__ = 0;
    d_f_i_internal1internal2_d_v_pinternal1__ = 0;
    d_f_i_internal1internal2_d_v_pn__ = 0;
    d_f_i_pinternal1_d_v_pinternal1__ = 0;
    d_f_v_internal2n_d_i_internal1internal2__ = 0;
    d_f_v_internal2n_d_v_internal2n__ = 0;
    d_i_internal1internal2_d_v_internal2n__ = 0;
    d_i_internal1internal2_d_v_pinternal1__ = 0;
    d_i_internal1internal2_d_v_pn__ = 0;
    d_i_internal2n_d_i_internal1internal2__ = 0;
    d_q_i_internal1internal2_d_i_internal1internal2__ = 0;
    d_q_i_internal1internal2_d_v_internal2n__ = 0;
    d_q_i_internal1internal2_d_v_pinternal1__ = 0;
    d_q_i_internal1internal2_d_v_pn__ = 0;
    d_q_i_pinternal1_d_v_pinternal1__ = 0;
    d_q_v_internal2n_d_i_internal1internal2__ = 0;
    d_q_v_internal2n_d_v_internal2n__ = 0;
    d_v_internal1internal2_d_v_internal2n__ = 0;
    d_v_internal1internal2_d_v_pinternal1__ = 0;
    d_v_internal1internal2_d_v_pn__ = 0;
    d_v_internal2n_d_i_internal1internal2__ = 0;
    % Initializing inputs
    v_pn__ = vecX__(1);
    v_pinternal1__ = vecY__(1);
    v_internal2n__ = vecY__(2);
    i_internal1internal2__ = vecY__(3);
    % Initializing remaining IOs and auxiliary IOs
    f_i_pinternal1__ = 0;
    q_i_pinternal1__ = 0;
    f_i_internal1internal2__ = 0;
    q_i_internal1internal2__ = 0;
    f_v_internal2n__ = 0;
    q_v_internal2n__ = 0;
    % module body
        d_i_internal2n_d_i_internal1internal2__ = 1;
    i_internal2n__ = i_internal1internal2__;
        d_v_internal1internal2_d_v_pn__ = (1);
        d_v_internal1internal2_d_v_pinternal1__ = -1;
        d_v_internal1internal2_d_v_internal2n__ = (-1);
    v_internal1internal2__ = (v_pn__-v_internal2n__)-v_pinternal1__;
        d_f_i_pinternal1_d_v_pinternal1__ = d_f_i_pinternal1_d_v_pinternal1__+(1/parm_R);
    % contribution for i_pinternal1;
    f_i_pinternal1__ = f_i_pinternal1__ + v_pinternal1__/parm_R;
        d_CapacitorCharge_d_v_pn__ = d_v_internal1internal2_d_v_pn__*parm_C;
        d_CapacitorCharge_d_v_pinternal1__ = d_v_internal1internal2_d_v_pinternal1__*parm_C;
        d_CapacitorCharge_d_v_internal2n__ = d_v_internal1internal2_d_v_internal2n__*parm_C;
    CapacitorCharge = v_internal1internal2__*parm_C;
        d_q_i_internal1internal2_d_v_pn__ = d_q_i_internal1internal2_d_v_pn__+d_CapacitorCharge_d_v_pn__;
        d_q_i_internal1internal2_d_v_pinternal1__ = d_q_i_internal1internal2_d_v_pinternal1__+d_CapacitorCharge_d_v_pinternal1__;
        d_q_i_internal1internal2_d_v_internal2n__ = d_q_i_internal1internal2_d_v_internal2n__+d_CapacitorCharge_d_v_internal2n__;
    % contribution for i_internal1internal2;
    q_i_internal1internal2__ = q_i_internal1internal2__ + CapacitorCharge;
        d_InductorCurrent_d_i_internal1internal2__ = d_i_internal2n_d_i_internal1internal2__;
    InductorCurrent = i_internal2n__;
        d_q_v_internal2n_d_i_internal1internal2__ = d_q_v_internal2n_d_i_internal1internal2__+(parm_L*d_InductorCurrent_d_i_internal1internal2__);
    % contribution for v_internal2n;
    q_v_internal2n__ = q_v_internal2n__ + parm_L*InductorCurrent;
        d_fe_d_X__(1,1) = d_i_internal1internal2_d_v_pn__;
        d_fe_d_Y__(1,1) = d_i_internal1internal2_d_v_pinternal1__;
        d_fe_d_Y__(1,2) = d_i_internal1internal2_d_v_internal2n__;
        d_fe_d_Y__(1,3) = 1;
    % output for terminalFlow_p (explicit out)
    fe__(1) = +i_internal1internal2__;
    qe__(1) = 0;
        d_fi_d_X__(1,1) = d_i_internal1internal2_d_v_pn__;
        d_fi_d_Y__(1,1) = d_i_internal1internal2_d_v_pinternal1__-d_f_i_pinternal1_d_v_pinternal1__;
        d_qi_d_Y__(1,1) = -d_q_i_pinternal1_d_v_pinternal1__;
        d_fi_d_Y__(1,2) = d_i_internal1internal2_d_v_internal2n__;
        d_fi_d_Y__(1,3) = 1;
    % output for v_pinternal1 (internal unknown)
    fi__(1) = +i_internal1internal2__ - f_i_pinternal1__;
    qi__(1) = 0 - q_i_pinternal1__;
        d_fi_d_Y__(2,2) = 1-d_f_v_internal2n_d_v_internal2n__;
        d_qi_d_Y__(2,2) = -d_q_v_internal2n_d_v_internal2n__;
        d_fi_d_Y__(2,3) = d_v_internal2n_d_i_internal1internal2__-d_f_v_internal2n_d_i_internal1internal2__;
        d_qi_d_Y__(2,3) = -d_q_v_internal2n_d_i_internal1internal2__;
    % output for v_internal2n (internal unknown)
    fi__(2) = +v_internal2n__ - f_v_internal2n__;
    qi__(2) = 0 - q_v_internal2n__;
        d_fi_d_X__(3,1) = d_i_internal1internal2_d_v_pn__-d_f_i_internal1internal2_d_v_pn__;
        d_qi_d_X__(3,1) = -d_q_i_internal1internal2_d_v_pn__;
        d_fi_d_Y__(3,1) = d_i_internal1internal2_d_v_pinternal1__-d_f_i_internal1internal2_d_v_pinternal1__;
        d_qi_d_Y__(3,1) = -d_q_i_internal1internal2_d_v_pinternal1__;
        d_fi_d_Y__(3,2) = d_i_internal1internal2_d_v_internal2n__-d_f_i_internal1internal2_d_v_internal2n__;
        d_qi_d_Y__(3,2) = -d_q_i_internal1internal2_d_v_internal2n__;
        d_fi_d_Y__(3,3) = 1-d_f_i_internal1internal2_d_i_internal1internal2__;
        d_qi_d_Y__(3,3) = -d_q_i_internal1internal2_d_i_internal1internal2__;
    % output for i_internal1internal2 (internal unknown)
    fi__(3) = +i_internal1internal2__ - f_i_internal1internal2__;
    qi__(3) = 0 - q_i_internal1internal2__;
end

function [eonames, iunames, ienames] = get_oui_names__(MOD__)
    eonames = {'ipn'};
    iunames = {'v_pinternal1', 'v_internal2n', 'i_internal1internal2'};
    ienames = {'KCL for i_pinternal1', 'constitutive equation for v_internal2n', 'constitutive equation for i_internal1internal2'};
end

function [nFeQe, nFiQi, nOtherIo, nIntUnk] = get_nfq__(MOD__)
    nFeQe = 1;
    nFiQi = 3;
    nOtherIo = 1;
    nIntUnk = 3;
end

function iun = get_iu_names__(MOD)
    [~, iun, ~] = get_oui_names__(MOD);
end

function ien = get_ie_names__(MOD)
    [~, ~, ien] = get_oui_names__(MOD);
end

