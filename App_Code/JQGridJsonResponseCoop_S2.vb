Public Class JQGridJsonResponseCoop_S2


#Region "Passive attributes"
    Private _pageCount As Integer
    Private _currentPage As Integer
    Private _recordCount As Integer
    Private _items As List(Of JQGridItem)

    Public Property PageCount() As Integer
        Get
            Return _pageCount
        End Get
        Set(ByVal Value As Integer)
            _pageCount = Value
        End Set
    End Property
    Public Property CurrentPage() As Integer
        Get
            Return _currentPage
        End Get
        Set(ByVal Value As Integer)
            _currentPage = Value
        End Set
    End Property

    Public Property RecordCount() As Integer
        Get
            Return _recordCount
        End Get
        Set(ByVal Value As Integer)
            _recordCount = Value
        End Set
    End Property

    Public Property Items() As List(Of JQGridItem)
        Get
            Return _items
        End Get
        Set(ByVal Value As List(Of JQGridItem))
            _items = Value
        End Set
    End Property
#End Region

    Public Sub JQGridJsonResponseCoop_S2(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, coops_S2 As List(Of clsCoopS_2))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim coop_S2 As clsCoopS_2 = New clsCoopS_2()

        For Each coop_S2 In coops_S2
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = coop_S2.coo_clv2
            objeto.row = New List(Of String)(New String() {
                                                coop_S2.obr_clv_int,
                                                coop_S2.obr_clv2,
                                                coop_S2.coo_clv1,
                                                coop_S2.coo_pat,
                                                coop_S2.coo_mat,
                                                coop_S2.coo_nom,
                                                coop_S2.coo_nombre,
                                                coop_S2.obr_call,
                                                coop_S2.col_nom,
                                                coop_S2.obr_tramo,
                                                coop_S2.coo_nof,
                                                coop_S2.coo_mts,
                                                coop_S2.coo_pred,
                                                coop_S2.obr_mts,
                                                coop_S2.obr_cost,
                                                coop_S2.obr_fecha,
                                                coop_S2.obr_cost_total,
                                                coop_S2.obr_inc,
                                                coop_S2.obr_int,
                                                coop_S2.descrip_tipo_obr,
                                                coop_S2.obr_fecinip,
                                                coop_S2.obr_fecvenp,
                                                coop_S2.obr_npago,
                                                coop_S2.obr_opergob,
                                                coop_S2.obr_ubic,
                                                coop_S2.obr_fec_ini_proc,
                                                coop_S2.obr_fec_ini_cob,
                                                coop_S2.obr_fec_pub1,
                                                coop_S2.obr_fec_pub2,
                                                coop_S2.evid_pub1,
                                                coop_S2.evid_pub2,
                                                coop_S2.col_clv2,
                                                coop_S2.obr_prog2,
                                                coop_S2.nomprog,
                                                coop_S2.obr_status,
                                                coop_S2.cestatus,
                                                coop_S2.coo_clv2,
                                                coop_S2.coo_inc,
                                                coop_S2.coo_tel,
                                                coop_S2.suma_acces_6,
                                                coop_S2.mov_fec_acces_6,
                                                coop_S2.suma_acces_7,
                                                coop_S2.mov_fec_acces_7,
                                                coop_S2.fec_act,
                                                coop_S2.sum_pag_antes_221119,
                                                coop_S2.sum_pag_desp_221119,
                                                coop_S2.sum_pag_antes_fec_ent,
                                                coop_S2.sum_pag_desp_fec_ent,
                                                coop_S2.suerte_princ,
                                                coop_S2.saldo_act1,
                                                coop_S2.clv_inpc_ant,
                                                coop_S2.clv_inpc_actual,
                                                coop_S2.clv_inpc_actual_2,
                                                coop_S2.factor1,
                                                coop_S2.factor2,
                                                coop_S2.factor3,
                                                coop_S2.factor_act,
                                                coop_S2.saldo_act2,
                                                coop_S2.monto_act,
                                                coop_S2.saldo_act3,
                                                coop_S2.sum_recargos,
                                                coop_S2.sum_recargos_tipo_8,
                                                coop_S2.sum_recargos_tipo_10,
                                                coop_S2.sum_desctos,
                                                coop_S2.sum_desctos_xap,
                                                coop_S2.sum_pagos,
                                                coop_S2.sum_bonific,
                                                coop_S2.sum_bonific_xap,
                                                coop_S2.saldo_act4,
                                                coop_S2.saldo_depurar,
                                                coop_S2.saldo_act5,
                                                coop_S2.sum_rec_act_saldo,
                                                coop_S2.fec_ult_rec_act_saldo,
                                                coop_S2.fact_act_ant,
                                                coop_S2.fec_notif_det,
                                                coop_S2.fec_notif_req,
                                                coop_S2.fec_notif_ejec
                                                })
            _items.Add(objeto)
        Next
    End Sub






End Class
