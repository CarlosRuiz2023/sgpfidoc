Public Class JQGridJsonResponseCargosPagados

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

    Public Sub JQGridJsonResponseCargosPagados(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, cargos_pagados As List(Of clsCargosPagados))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim cargo_pagado As clsCargosPagados = New clsCargosPagados()

        For Each cargo_pagado In cargos_pagados
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = cargo_pagado.clv_coo
            objeto.row = New List(Of String)(New String() {
                                                            cargo_pagado.clv_coo,
                                                            cargo_pagado.monto_pagado,
                                                            cargo_pagado.idpago,
                                                            cargo_pagado.idcargo,
                                                            cargo_pagado.fecha_pago,
                                                            cargo_pagado.fecha_cargo,
                                                            cargo_pagado.coo_clv2,
                                                            cargo_pagado.tipo_mov
                                                })
            _items.Add(objeto)
        Next
    End Sub

End Class
