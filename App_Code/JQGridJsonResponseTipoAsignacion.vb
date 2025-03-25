Public Class JQGridJsonResponseTipoAsignacion
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

    Public Sub JQGridJsonResponseTipoAsignacion(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, tipos_asignacion As List(Of clsTipoAsig))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim tipo_asignacion As clsTipoAsig = New clsTipoAsig()

        For Each tipo_asignacion In tipos_asignacion
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = tipo_asignacion.idasignacion
            objeto.row = New List(Of String)(New String() {
                                                           tipo_asignacion.idasignacion,
                                                           tipo_asignacion.etiqueta,
                                                           tipo_asignacion.descrip_tipo_asig,
                                                           tipo_asignacion.cactivo,
                                                           tipo_asignacion.fec_cre,
                                                           tipo_asignacion.idusu
                                                         })
            _items.Add(objeto)
        Next
    End Sub

End Class
