Public Class JQGridJsonResponseTipoRecursoObra


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

    Public Sub JQGridJsonResponseTipoRecursoObra(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, tipos_recurso_obra As List(Of clsTipoRecursoObra))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim tipo_recurso_obra As clsTipoRecursoObra = New clsTipoRecursoObra()

        For Each tipo_recurso_obra In tipos_recurso_obra
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = tipo_recurso_obra.idtipo_recurso
            objeto.row = New List(Of String)(New String() {
                                                           tipo_recurso_obra.idtipo_recurso,
                                                           tipo_recurso_obra.descrip,
                                                           tipo_recurso_obra.observ,
                                                           tipo_recurso_obra.usu_cre,
                                                           tipo_recurso_obra.usu_mod,
                                                           tipo_recurso_obra.fec_cre,
                                                           tipo_recurso_obra.fec_mod,
                                                           tipo_recurso_obra.cestatus
                                                         })
            _items.Add(objeto)
        Next
    End Sub



End Class
