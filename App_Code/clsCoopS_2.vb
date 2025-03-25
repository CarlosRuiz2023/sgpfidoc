Public Class clsCoopS_2


#Region "variables privadas"
    Private _obr_clv_int As Integer = 0
    Private _obr_clv2 As String = String.Empty
    Private _obr_call As String = String.Empty
    Private _col_nom As String = String.Empty
    Private _obr_tramo As String = String.Empty
    Private _obr_mts As Double = 0
    Private _obr_cost As Double = 0
    Private _obr_fecha As Date
    Private _obr_cost_total As Double = 0
    Private _obr_inc As Double = 0
    Private _obr_int As Integer = 0
    Private _descrip_tipo_obr As String = String.Empty
    Private _obr_fecinip As Date
    Private _obr_fecvenp As Date
    Private _obr_npago As Integer = 0
    Private _obr_opergob As String = String.Empty
    Private _obr_ubic As Integer = 0
    Private _obr_fec_ini_proc As Date
    Private _obr_fec_ini_cob As Date
    Private _obr_fec_pub1 As Date
    Private _obr_fec_pub2 As Date
    Private _evid_pub1 As String = String.Empty
    Private _evid_pub2 As String = String.Empty
    Private _col_clv2 As Integer = 0
    Private _obr_prog2 As Integer = 0
    Private _nomprog As String = String.Empty
    Private _obr_status As Integer = 0
    Private _cestatus As String = String.Empty
    Private _coo_clv1 As String = String.Empty
    Private _coo_clv2 As Integer = 0
    Private _coo_pat As String = String.Empty
    Private _coo_mat As String = String.Empty
    Private _coo_nom As String = String.Empty
    Private _coo_nombre As String = String.Empty
    Private _coo_nof As String = String.Empty
    Private _coo_mts As Double = 0
    Private _coo_pred As String = String.Empty
    Private _coo_inc As Double = 0
    Private _coo_tel As String = String.Empty
    Private _suma_acces_6 As Double = 0
    Private _mov_fec_acces_6 As Date
    Private _suma_acces_7 As Double = 0
    Private _mov_fec_acces_7 As Date
    Private _fec_act As Date
    Private _sum_pag_antes_221119 As Double = 0
    Private _sum_pag_desp_221119 As Double = 0
    Private _sum_pag_antes_fec_ent As Double = 0
    Private _sum_pag_desp_fec_ent As Double = 0
    Private _suerte_princ As Double = 0
    Private _saldo_act1 As Double = 0
    Private _clv_inpc_ant As String = String.Empty
    Private _clv_inpc_actual As String = String.Empty
    Private _clv_inpc_actual_2 As String = String.Empty
    Private _factor1 As Double = 0
    Private _factor2 As Double = 0
    Private _factor3 As Double = 0
    Private _factor_act As Double = 0
    Private _saldo_act2 As Double = 0
    Private _monto_act As Double = 0
    Private _saldo_act3 As Double = 0
    Private _sum_recargos As Double = 0
    Private _sum_recargos_tipo_8 As Double = 0
    Private _sum_recargos_tipo_10 As Double = 0
    Private _sum_desctos As Double = 0
    Private _sum_desctos_xap As Double = 0
    Private _sum_pagos As Double = 0
    Private _sum_bonific As Double = 0
    Private _sum_bonific_xap As Double = 0
    Private _saldo_act4 As Double = 0
    Private _saldo_depurar As Double = 0
    Private _saldo_act5 As Double = 0
    Private _sum_rec_act_saldo As Double = 0
    Private _fec_ult_rec_act_saldo As Date
    Private _fact_act_ant As Double = 0
    Private _fec_notif_det As Date
    Private _fec_notif_req As Date
    Private _fec_notif_ejec As Date


    Shared conn As New clsConexion
#End Region

#Region "Propiedades"

    Public Property obr_clv_int() As Integer        Get            Return _obr_clv_int        End Get        Set(ByVal Value As Integer)            _obr_clv_int = Value        End Set    End Property
    Public Property obr_clv2() As String        Get            Return _obr_clv2        End Get        Set(ByVal Value As String)            _obr_clv2 = Value        End Set    End Property
    Public Property obr_call() As String        Get            Return _obr_call        End Get        Set(ByVal Value As String)            _obr_call = Value        End Set    End Property
    Public Property col_nom() As String        Get            Return _col_nom        End Get        Set(ByVal Value As String)            _col_nom = Value        End Set    End Property
    Public Property obr_tramo() As String        Get            Return _obr_tramo        End Get        Set(ByVal Value As String)            _obr_tramo = Value        End Set    End Property
    Public Property obr_mts() As Double        Get            Return _obr_mts        End Get        Set(ByVal Value As Double)            _obr_mts = Value        End Set    End Property
    Public Property obr_cost() As Double        Get            Return _obr_cost        End Get        Set(ByVal Value As Double)            _obr_cost = Value        End Set    End Property
    Public Property obr_fecha() As Date        Get            Return _obr_fecha        End Get        Set(ByVal Value As Date)            _obr_fecha = Value        End Set    End Property
    Public Property obr_cost_total() As Double        Get            Return _obr_cost_total        End Get        Set(ByVal Value As Double)            _obr_cost_total = Value        End Set    End Property
    Public Property obr_inc() As Double        Get            Return _obr_inc        End Get        Set(ByVal Value As Double)            _obr_inc = Value        End Set    End Property
    Public Property obr_int() As Integer        Get            Return _obr_int        End Get        Set(ByVal Value As Integer)            _obr_int = Value        End Set    End Property
    Public Property descrip_tipo_obr() As String        Get            Return _descrip_tipo_obr        End Get        Set(ByVal Value As String)            _descrip_tipo_obr = Value        End Set    End Property
    Public Property obr_fecinip() As Date        Get            Return _obr_fecinip        End Get        Set(ByVal Value As Date)            _obr_fecinip = Value        End Set    End Property
    Public Property obr_fecvenp() As Date        Get            Return _obr_fecvenp        End Get        Set(ByVal Value As Date)            _obr_fecvenp = Value        End Set    End Property
    Public Property obr_npago() As Integer        Get            Return _obr_npago        End Get        Set(ByVal Value As Integer)            _obr_npago = Value        End Set    End Property
    Public Property obr_opergob() As String        Get            Return _obr_opergob        End Get        Set(ByVal Value As String)            _obr_opergob = Value        End Set    End Property
    Public Property obr_ubic() As Integer        Get            Return _obr_ubic        End Get        Set(ByVal Value As Integer)            _obr_ubic = Value        End Set    End Property
    Public Property obr_fec_ini_proc() As Date        Get            Return _obr_fec_ini_proc        End Get        Set(ByVal Value As Date)            _obr_fec_ini_proc = Value        End Set    End Property
    Public Property obr_fec_ini_cob() As Date        Get            Return _obr_fec_ini_cob        End Get        Set(ByVal Value As Date)            _obr_fec_ini_cob = Value        End Set    End Property
    Public Property obr_fec_pub1() As Date        Get            Return _obr_fec_pub1        End Get        Set(ByVal Value As Date)            _obr_fec_pub1 = Value        End Set    End Property
    Public Property obr_fec_pub2() As Date        Get            Return _obr_fec_pub2        End Get        Set(ByVal Value As Date)            _obr_fec_pub2 = Value        End Set    End Property
    Public Property evid_pub1() As String        Get            Return _evid_pub1        End Get        Set(ByVal Value As String)            _evid_pub1 = Value        End Set    End Property
    Public Property evid_pub2() As String        Get            Return _evid_pub2        End Get        Set(ByVal Value As String)            _evid_pub2 = Value        End Set    End Property
    Public Property col_clv2() As Integer        Get            Return _col_clv2        End Get        Set(ByVal Value As Integer)            _col_clv2 = Value        End Set    End Property
    Public Property obr_prog2() As Integer        Get            Return _obr_prog2        End Get        Set(ByVal Value As Integer)            _obr_prog2 = Value        End Set    End Property
    Public Property nomprog() As String        Get            Return _nomprog        End Get        Set(ByVal Value As String)            _nomprog = Value        End Set    End Property
    Public Property obr_status() As Integer        Get            Return _obr_status        End Get        Set(ByVal Value As Integer)            _obr_status = Value        End Set    End Property
    Public Property cestatus() As String        Get            Return _cestatus        End Get        Set(ByVal Value As String)            _cestatus = Value        End Set    End Property
    Public Property coo_clv1() As String        Get            Return _coo_clv1        End Get        Set(ByVal Value As String)            _coo_clv1 = Value        End Set    End Property
    Public Property coo_clv2() As Integer        Get            Return _coo_clv2        End Get        Set(ByVal Value As Integer)            _coo_clv2 = Value        End Set    End Property
    Public Property coo_pat() As String        Get            Return _coo_pat        End Get        Set(ByVal Value As String)            _coo_pat = Value        End Set    End Property
    Public Property coo_mat() As String        Get            Return _coo_mat        End Get        Set(ByVal Value As String)            _coo_mat = Value        End Set    End Property
    Public Property coo_nom() As String        Get            Return _coo_nom        End Get        Set(ByVal Value As String)            _coo_nom = Value        End Set    End Property
    Public Property coo_nombre() As String        Get            Return _coo_nombre        End Get        Set(ByVal Value As String)            _coo_nombre = Value        End Set    End Property
    Public Property coo_nof() As String        Get            Return _coo_nof        End Get        Set(ByVal Value As String)            _coo_nof = Value        End Set    End Property
    Public Property coo_mts() As Double        Get            Return _coo_mts        End Get        Set(ByVal Value As Double)            _coo_mts = Value        End Set    End Property
    Public Property coo_pred() As String        Get            Return _coo_pred        End Get        Set(ByVal Value As String)            _coo_pred = Value        End Set    End Property
    Public Property coo_inc() As Double        Get            Return _coo_inc        End Get        Set(ByVal Value As Double)            _coo_inc = Value        End Set    End Property
    Public Property coo_tel() As String        Get            Return _coo_tel        End Get        Set(ByVal Value As String)            _coo_tel = Value        End Set    End Property    Public Property suma_acces_6() As Double        Get            Return _suma_acces_6        End Get        Set(ByVal Value As Double)            _suma_acces_6 = Value        End Set    End Property
    Public Property mov_fec_acces_6() As Date        Get            Return _mov_fec_acces_6        End Get        Set(ByVal Value As Date)            _mov_fec_acces_6 = Value        End Set    End Property
    Public Property suma_acces_7() As Double        Get            Return _suma_acces_7        End Get        Set(ByVal Value As Double)            _suma_acces_7 = Value        End Set    End Property
    Public Property mov_fec_acces_7() As Date        Get            Return _mov_fec_acces_7        End Get        Set(ByVal Value As Date)            _mov_fec_acces_7 = Value        End Set    End Property
    Public Property fec_act() As Date        Get            Return _fec_act        End Get        Set(ByVal Value As Date)            _fec_act = Value        End Set    End Property
    Public Property sum_pag_antes_221119() As Double        Get            Return _sum_pag_antes_221119        End Get        Set(ByVal Value As Double)            _sum_pag_antes_221119 = Value        End Set    End Property
    Public Property sum_pag_desp_221119() As Double        Get            Return _sum_pag_desp_221119        End Get        Set(ByVal Value As Double)            _sum_pag_desp_221119 = Value        End Set    End Property
    Public Property sum_pag_antes_fec_ent() As Double        Get            Return _sum_pag_antes_fec_ent        End Get        Set(ByVal Value As Double)            _sum_pag_antes_fec_ent = Value        End Set    End Property
    Public Property sum_pag_desp_fec_ent() As Double        Get            Return _sum_pag_desp_fec_ent        End Get        Set(ByVal Value As Double)            _sum_pag_desp_fec_ent = Value        End Set    End Property
    Public Property suerte_princ() As Double        Get            Return _suerte_princ        End Get        Set(ByVal Value As Double)            _suerte_princ = Value        End Set    End Property
    Public Property saldo_act1() As Double        Get            Return _saldo_act1        End Get        Set(ByVal Value As Double)            _saldo_act1 = Value        End Set    End Property
    Public Property clv_inpc_ant() As String        Get            Return _clv_inpc_ant        End Get        Set(ByVal Value As String)            _clv_inpc_ant = Value        End Set    End Property
    Public Property clv_inpc_actual() As String        Get            Return _clv_inpc_actual        End Get        Set(ByVal Value As String)            _clv_inpc_actual = Value        End Set    End Property
    Public Property clv_inpc_actual_2() As String        Get            Return _clv_inpc_actual_2        End Get        Set(ByVal Value As String)            _clv_inpc_actual_2 = Value        End Set    End Property
    Public Property factor1() As Double        Get            Return _factor1        End Get        Set(ByVal Value As Double)            _factor1 = Value        End Set    End Property
    Public Property factor2() As Double        Get            Return _factor2        End Get        Set(ByVal Value As Double)            _factor2 = Value        End Set    End Property
    Public Property factor3() As Double        Get            Return _factor3        End Get        Set(ByVal Value As Double)            _factor3 = Value        End Set    End Property
    Public Property factor_act() As Double        Get            Return _factor_act        End Get        Set(ByVal Value As Double)            _factor_act = Value        End Set    End Property
    Public Property saldo_act2() As Double        Get            Return _saldo_act2        End Get        Set(ByVal Value As Double)            _saldo_act2 = Value        End Set    End Property
    Public Property monto_act() As Double        Get            Return _monto_act        End Get        Set(ByVal Value As Double)            _monto_act = Value        End Set    End Property
    Public Property saldo_act3() As Double        Get            Return _saldo_act3        End Get        Set(ByVal Value As Double)            _saldo_act3 = Value        End Set    End Property
    Public Property sum_recargos() As Double        Get            Return _sum_recargos        End Get        Set(ByVal Value As Double)            _sum_recargos = Value        End Set    End Property
    Public Property sum_recargos_tipo_8() As Double        Get            Return _sum_recargos_tipo_8        End Get        Set(ByVal Value As Double)            _sum_recargos_tipo_8 = Value        End Set    End Property
    Public Property sum_recargos_tipo_10() As Double        Get            Return _sum_recargos_tipo_10        End Get        Set(ByVal Value As Double)            _sum_recargos_tipo_10 = Value        End Set    End Property
    Public Property sum_desctos() As Double        Get            Return _sum_desctos        End Get        Set(ByVal Value As Double)            _sum_desctos = Value        End Set    End Property
    Public Property sum_desctos_xap() As Double        Get            Return _sum_desctos_xap
        End Get        Set(ByVal Value As Double)            _sum_desctos_xap = Value        End Set    End Property
    Public Property sum_pagos() As Double        Get            Return _sum_pagos        End Get        Set(ByVal Value As Double)            _sum_pagos = Value        End Set    End Property
    Public Property sum_bonific() As Double        Get            Return _sum_bonific        End Get        Set(ByVal Value As Double)            _sum_bonific = Value        End Set    End Property
    Public Property sum_bonific_xap() As Double        Get            Return _sum_bonific_xap        End Get        Set(ByVal Value As Double)            _sum_bonific_xap = Value        End Set    End Property
    Public Property saldo_act4() As Double        Get            Return _saldo_act4        End Get        Set(ByVal Value As Double)            _saldo_act4 = Value        End Set    End Property
    Public Property saldo_depurar() As Double        Get            Return _saldo_depurar        End Get        Set(ByVal Value As Double)            _saldo_depurar = Value        End Set    End Property
    Public Property saldo_act5() As Double        Get            Return _saldo_act5        End Get        Set(ByVal Value As Double)            _saldo_act5 = Value        End Set    End Property
    Public Property sum_rec_act_saldo() As Double        Get            Return _sum_rec_act_saldo        End Get        Set(ByVal Value As Double)            _sum_rec_act_saldo = Value        End Set    End Property
    Public Property fec_ult_rec_act_saldo() As Date        Get            Return _fec_ult_rec_act_saldo        End Get        Set(ByVal Value As Date)            _fec_ult_rec_act_saldo = Value        End Set    End Property
    Public Property fact_act_ant() As Double        Get            Return _fact_act_ant        End Get        Set(ByVal Value As Double)            _fact_act_ant = Value        End Set    End Property
    Public Property fec_notif_det() As Date        Get            Return _fec_notif_det        End Get        Set(ByVal Value As Date)            _fec_notif_det = Value        End Set    End Property
    Public Property fec_notif_req() As Date        Get            Return _fec_notif_req        End Get        Set(ByVal Value As Date)            _fec_notif_req = Value        End Set    End Property
    Public Property fec_notif_ejec() As Date        Get            Return _fec_notif_ejec        End Get        Set(ByVal Value As Date)            _fec_notif_ejec = Value        End Set    End Property

#End Region

#Region "Metodos"

#End Region


End Class
