Public Class JQGridJsonResponseTipoAsamblea

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

    Public Sub JQGridJsonResponseTipoAsamblea(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, tipos_asamblea As List(Of clsTipoAsamblea))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim tipo_asamblea As clsTipoAsamblea = New clsTipoAsamblea()

        For Each tipo_asamblea In tipos_asamblea
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = tipo_asamblea.IdTipoAsamblea
            objeto.row = New List(Of String)(New String() {
                                                           tipo_asamblea.IdTipoAsamblea,
                                                           tipo_asamblea.Etiqueta,
                                                           tipo_asamblea.Descripcion,
                                                           tipo_asamblea.usu_cre,
                                                           tipo_asamblea.fec_cre,
                                                           tipo_asamblea.cactivo
                                                         })
            _items.Add(objeto)
        Next
    End Sub



End Class
