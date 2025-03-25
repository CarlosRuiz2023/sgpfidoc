Public Class JQGridJsonResponseTipoComite

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

    Public Sub JQGridJsonResponseTipoComite(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, tipos_comite As List(Of clsTipoComite))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim tipo_comite As clsTipoComite = New clsTipoComite()

        For Each tipo_comite In tipos_comite
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = tipo_comite.idtipo_comite
            objeto.row = New List(Of String)(New String() {
                                                           tipo_comite.idtipo_comite,
                                                           tipo_comite.etiqueta_tipo_comite,
                                                           tipo_comite.descrip,
                                                           tipo_comite.fec_cre,
                                                           tipo_comite.fec_mod,
                                                           tipo_comite.usu_cre,
                                                           tipo_comite.usu_mod,
                                                           tipo_comite.cestatus
                                                         })
            _items.Add(objeto)
        Next
    End Sub



End Class
