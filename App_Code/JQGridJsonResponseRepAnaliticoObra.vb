Public Class JQGridJsonResponseRepAnaliticoObra



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

    Public Sub JQGridJsonResponseRepAnaliticoObra(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, obras_analitico As List(Of clsObraAnalitico))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim obra_analitico As clsObraAnalitico = New clsObraAnalitico()

        For Each obra_analitico In obras_analitico
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = obra_analitico.oid
            objeto.row = New List(Of String)(New String() {obra_analitico.fid,
                                                           obra_analitico.coopid,
                                                           obra_analitico.mts_frente,
                                                           obra_analitico.obr_cost,
                                                           obra_analitico.oid,
                                                           obra_analitico.calle,
                                                           obra_analitico.colonia,
                                                           obra_analitico.tramo,
                                                           obra_analitico.obr_clv_int,
                                                           obra_analitico.obr_clv,
                                                           obra_analitico.obr_opergob,
                                                           obra_analitico.obr_prog2,
                                                           obra_analitico.nomprog,
                                                           obra_analitico.descrip_tipo_obr,
                                                           obra_analitico.obr_status,
                                                           obra_analitico.estatus_obra,
                                                           obra_analitico.fec_ini_pag,
                                                           obra_analitico.fec_fin_pag,
                                                           obra_analitico.fec_ini_proc,
                                                           obra_analitico.fec_ini_cob,
                                                           obra_analitico.plazo_rec,
                                                           obra_analitico.num_meses_a_fecact,
                                                           obra_analitico.capital_inicial_frente_sin_inc,
                                                           obra_analitico.incremento_frente,
                                                           obra_analitico.capital_inicial_frente_con_inc,
                                                           obra_analitico.descto_capital_frente,
                                                           obra_analitico.ayudas_sociales_frente,
                                                           obra_analitico.capital_pagado_frente,
                                                           obra_analitico.total_recargos_frente,
                                                           obra_analitico.descto_recargos_frente,
                                                           obra_analitico.cargos_pagados_frente,
                                                           obra_analitico.saldo_capital_frente,
                                                           obra_analitico.saldo_recargos_frente,
                                                           obra_analitico.saldo_gral_frente,
                                                           obra_analitico.saldo_sin,
                                                           obra_analitico.saldo_con,
                                                           obra_analitico.avance_pago_con_inc_x_frente,
                                                           obra_analitico.avance_pago_sin_inc_x_frente
                                                          })
            _items.Add(objeto)
        Next
    End Sub
End Class


