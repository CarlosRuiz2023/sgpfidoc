Public Class JQGridJsonResponseObrasVencidasRec
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

    Public Sub JQGridJsonResponseObrasVencidasRec(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, obras_venc_rec As List(Of clsObrasVencRec))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim obra As clsObrasVencRec = New clsObrasVencRec()

        For Each obra_venc_rec In obras_venc_rec
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = obra_venc_rec.obr_clv_int
            objeto.row = New List(Of String)(New String() {obra_venc_rec.num_coops,
                                                           obra_venc_rec.total_metros_obra,
                                                           obra_venc_rec.obr_costo,
                                                           obra_venc_rec.oid,
                                                           obra_venc_rec.calle,
                                                           obra_venc_rec.colonia,
                                                           obra_venc_rec.tramo,
                                                           obra_venc_rec.obr_clv_int,
                                                           obra_venc_rec.obr_clv,
                                                           obra_venc_rec.obr_opergob,
                                                           obra_venc_rec.obr_prog2,
                                                           obra_venc_rec.nomprog,
                                                           obra_venc_rec.descrip_tipo_obr,
                                                           obra_venc_rec.obr_status,
                                                           obra_venc_rec.cestatus,
                                                           obra_venc_rec.obr_fecinip,
                                                           obra_venc_rec.obr_fecvenp,
                                                           obra_venc_rec.obr_fec_ini_proc,
                                                           obra_venc_rec.obr_fec_ini_cob,
                                                           obra_venc_rec.plazo_rec,
                                                           obra_venc_rec.num_meses_a_fecact,
                                                           obra_venc_rec.incremento_frente,
                                                           obra_venc_rec.capital_inicial_frente_sin_inc,
                                                           obra_venc_rec.capital_inicial_frente_con_inc,
                                                           obra_venc_rec.capital_pagado_frente,
                                                           obra_venc_rec.descto_capital_frente,
                                                           obra_venc_rec.ayudas_sociales_frente,
                                                           obra_venc_rec.total_recargos_frente,
                                                           obra_venc_rec.cargos_pagados_frente,
                                                           obra_venc_rec.descto_recargos_frente,
                                                           obra_venc_rec.saldo_capital_frente,
                                                           obra_venc_rec.saldo_recargos_frente,
                                                           obra_venc_rec.saldo_gral_frente,
                                                           obra_venc_rec.saldo_sin,
                                                           obra_venc_rec.saldo_con,
                                                           obra_venc_rec.avance_pago_con_inc,
                                                           obra_venc_rec.avance_pago_sin_inc,
                                                           obra_venc_rec.id_act_costo_obra,
                                                           obra_venc_rec.idcomite,
                                                           obra_venc_rec.idacuerdo,
                                                           obra_venc_rec.fec_cap_aprob_comite,
                                                           obra_venc_rec.fec_comite,
                                                           obra_venc_rec.num_sesion,
                                                           obra_venc_rec.folio_acuerdo,
                                                           obra_venc_rec.idusu_aprob_comite,
                                                           obra_venc_rec.costo_mto_nuevo,
                                                           obra_venc_rec.fec_cap_costo_mto,
                                                           obra_venc_rec.idusu_cap_costo_mto,
                                                           obra_venc_rec.idasamblea,
                                                           obra_venc_rec.num_coops_act,
                                                           obra_venc_rec.acta_comite,
                                                           obra_venc_rec.presup_nuevo
                                                          })
            _items.Add(objeto)
        Next
    End Sub
End Class


