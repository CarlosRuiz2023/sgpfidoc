Public Class JQGridJsonResponseCoopAllCV

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

    Public Sub JQGridJsonResponseCoopAllCV(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, coop_all_coops As List(Of clsCoopAllCartera))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim coop_all_coop As clsCoopAllCartera = New clsCoopAllCartera()

        For Each coop_all_coop In coop_all_coops
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = coop_all_coop.fid
            objeto.row = New List(Of String)(New String() {coop_all_coop.coo_clv,
                                                           coop_all_coop.coo_pat,
                                                           coop_all_coop.coo_mat,
                                                           coop_all_coop.coo_nom,
                                                           coop_all_coop.coo_nombre,
                                                           coop_all_coop.coo_nof,
                                                           coop_all_coop.coo_call,
                                                           coop_all_coop.coo_num,
                                                           coop_all_coop.coo_col,
                                                           coop_all_coop.coo_npag,
                                                           coop_all_coop.coo_obr,
                                                           coop_all_coop.coo_mts,
                                                           coop_all_coop.coo_inc,
                                                           coop_all_coop.capital,
                                                           coop_all_coop.coo_clv1,
                                                           coop_all_coop.coo_pred,
                                                           coop_all_coop.obr_call,
                                                           coop_all_coop.obr_col,
                                                           coop_all_coop.col_nom,
                                                           coop_all_coop.obr_tramo,
                                                           coop_all_coop.obr_opergob,
                                                           coop_all_coop.obr_npago,
                                                           coop_all_coop.obr_fec_proc,
                                                           coop_all_coop.obr_fec_cob,
                                                           coop_all_coop.obr_fec_rec,
                                                           coop_all_coop.midcoop,
                                                           coop_all_coop.mcallecoop,
                                                           coop_all_coop.mcolcoop,
                                                           coop_all_coop.mnooficial_ext,
                                                           coop_all_coop.mtelcoop,
                                                           coop_all_coop.mnomficha,
                                                           coop_all_coop.mcurp,
                                                           coop_all_coop.mcorreo,
                                                           coop_all_coop.mrelacionpredio,
                                                           coop_all_coop.crelacionpredio,
                                                           coop_all_coop.fid,
                                                           coop_all_coop.obra_coop_s,
                                                           coop_all_coop.mts_frente,
                                                           coop_all_coop.cid,
                                                           coop_all_coop.pid,
                                                           coop_all_coop.ctapredial,
                                                           coop_all_coop.nooficial,
                                                           coop_all_coop.lote,
                                                           coop_all_coop.mzna,
                                                           coop_all_coop.obr_clv_int,
                                                           coop_all_coop.obr_clv2,
                                                           coop_all_coop.calle,
                                                           coop_all_coop.colonia,
                                                           coop_all_coop.tramo,
                                                           coop_all_coop.obr_fecinip,
                                                           coop_all_coop.obr_fecvenp,
                                                           coop_all_coop.obr_fec_ini_proc,
                                                           coop_all_coop.obr_fec_ini_cob,
                                                           coop_all_coop.obr_cost,
                                                           coop_all_coop.obr_prog2,
                                                           coop_all_coop.nomprog,
                                                           coop_all_coop.obr_opergob_sgp,
                                                           coop_all_coop.inc_sgp,
                                                           coop_all_coop.capital_sgp,
                                                           coop_all_coop.total_capital_pagado,
                                                           coop_all_coop.total_cargos_t5,
                                                           coop_all_coop.total_cargos_t6,
                                                           coop_all_coop.total_cargos_t7,
                                                           coop_all_coop.total_cargos_t16,
                                                           coop_all_coop.total_cargos_x_pagar_t5,
                                                           coop_all_coop.total_cargos_x_pagar_t6,
                                                           coop_all_coop.total_cargos_x_pagar_t7,
                                                           coop_all_coop.total_cargos_x_pagar_t16,
                                                           coop_all_coop.total_cargos,
                                                           coop_all_coop.total_cargos_pagados,
                                                           coop_all_coop.total_cargos_no_pagados,
                                                           coop_all_coop.total_pagos_x_coop,
                                                           coop_all_coop.total_bonific_x_coop,
                                                           coop_all_coop.total_descto_cargo_t3,
                                                           coop_all_coop.saldo_rapido,
                                                           coop_all_coop.saldo_sin,
                                                           coop_all_coop.saldo_con,
                                                           coop_all_coop.fec_notif_det,
                                                           coop_all_coop.notif_det,
                                                           coop_all_coop.nom_notif_det,
                                                           coop_all_coop.fec_notif_req,
                                                           coop_all_coop.notif_req,
                                                           coop_all_coop.nom_notif_req,
                                                           coop_all_coop.fec_notif_ejec,
                                                           coop_all_coop.notif_ejec,
                                                           coop_all_coop.nom_notif_ejec,
                                                           coop_all_coop.num_pagos,
                                                           coop_all_coop.costo_mto_old,
                                                           coop_all_coop.accion})
            _items.Add(objeto)
        Next
    End Sub



End Class


