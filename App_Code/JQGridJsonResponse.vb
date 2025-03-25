Public Class JQGridJsonResponse

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

    Public Sub JQGridJsonResponse(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, solicitudes As List(Of clsSolicitud))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim solicitud As clsSolicitud = New clsSolicitud()

        For Each solicitud In solicitudes
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = solicitud.IdSol
            objeto.row = New List(Of String)(New String() {solicitud.IdSol, solicitud.Fecha.ToShortDateString, solicitud.Nombre, solicitud.Calle, solicitud.Col, solicitud.Tramo, solicitud.EstatusDescrip, solicitud.ubic, solicitud.UsuCre, solicitud.FecCre, solicitud.UsuMod, solicitud.FecMod, solicitud.MetrosLong, solicitud.PorcentajeCapt, solicitud.NumDocs})
            _items.Add(objeto)
        Next
    End Sub

End Class
