Public Class JQGridJsonResponseLev

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

    Public Sub JQGridJsonResponseLev(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, levs As List(Of clsLevanta))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim lev As clsLevanta = New clsLevanta()

        For Each lev In levs
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = lev.IdSol
            objeto.row = New List(Of String)(New String() {lev.IdSol,
                                                           lev.idLev,
                                                           lev.FechaSol,
                                                           lev.FechaEntrega,
                                                           lev.Ejecutor,
                                                           lev.Observa,
                                                           lev.Imagen,
                                                           lev.Mapa,
                                                           lev.UsrCre,
                                                           lev.FecCre,
                                                           lev.UsrMod,
                                                           lev.FecMod})
            _items.Add(objeto)
        Next
    End Sub


End Class
