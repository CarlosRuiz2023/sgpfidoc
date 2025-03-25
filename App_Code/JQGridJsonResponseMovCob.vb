Public Class JQGridJsonResponseMovCob

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

    Public Sub JQGridJsonResponseMovCob(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, movs As List(Of clsMovtoFinancCob))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim mov As clsMovtoFinancCob = New clsMovtoFinancCob()

        For Each mov In movs
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = mov.fid
            objeto.row = New List(Of String)(New String() {mov.mov_obr,
                                                           mov.mov_coop,
                                                           mov.mov_fecha,
                                                           mov.mov_usu,
                                                           mov.mov_cap,
                                                           mov.mov_nor,
                                                           mov.mov_mora,
                                                           mov.mov_tipo,
                                                           mov.mov_fecha_cap,
                                                           mov.mov_ndep,
                                                           mov.mov_clv1,
                                                           mov.mov_greq,
                                                           mov.mov_gejec,
                                                           mov.mov_recargos,
                                                           mov.mov_capital,
                                                           mov.mov_devolver,
                                                           mov.id,
                                                           mov.id2,
                                                           mov.fid,
                                                           mov.cactivo,
                                                           mov.mov_cargo_pagado,
                                                           mov.titulomov
                                                })
            _items.Add(objeto)
        Next
    End Sub


End Class
