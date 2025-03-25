Public Class JQGridJsonResponseFrentexO

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

    Public Sub JQGridJsonResponseFrentexO(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, frentesxO As List(Of clsFrentexO))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim frentexo As clsFrentexO = New clsFrentexO()

        For Each frentexo In frentesxO
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = frentexo.fid
            objeto.row = New List(Of String)(New String() {frentexo.oid,
                                                           frentexo.obr_clv_int,
                                                           frentexo.pid,
                                                           frentexo.obr_clv,
                                                           frentexo.coopid,
                                                           frentexo.calle,
                                                           frentexo.colonia,
                                                           frentexo.tramo,
                                                           frentexo.costo_mto,
                                                           frentexo.obr_fecinip,
                                                           frentexo.obr_fecvenp,
                                                           frentexo.obr_npago,
                                                           frentexo.descrip_tipo_obr,
                                                           frentexo.estatus_obra,
                                                           frentexo.nomprog,
                                                           frentexo.progdescrip,
                                                           frentexo.fid,
                                                           frentexo.nooficial,
                                                           frentexo.ctapredial,
                                                           frentexo.coo_clv2,
                                                           frentexo.mnomficha,
                                                           frentexo.mts_frente,
                                                           frentexo.inc,
                                                           frentexo.capital_sin_inc,
                                                           frentexo.capital,
                                                           frentexo.capital_pagado,
                                                           frentexo.cargos_pagados,
                                                           frentexo.desctos_aplicados,
                                                           frentexo.recargos_netos,
                                                           frentexo.total_pagar,
                                                           frentexo.mapellidom,
                                                           frentexo.mapellidop,
                                                           frentexo.mnombres,
                                                           frentexo.costo_obra,
                                                           frentexo.abono,
                                                           frentexo.avance_obra
                                                          })
            _items.Add(objeto)
        Next
    End Sub
End Class