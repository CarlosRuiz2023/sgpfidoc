Public Class JQGridJsonResponseFormatoComite

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

    Public Sub JQGridJsonResponseFormatoComite(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, Formatos_comite As List(Of clsFormatoComite))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim Formato_comite As clsFormatoComite = New clsFormatoComite()

        For Each Formato_comite In Formatos_comite
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = Formato_comite.idformato_comite
            objeto.row = New List(Of String)(New String() {
                                                           Formato_comite.idformato_comite,
                                                           Formato_comite.etiqueta_formato_comite,
                                                           Formato_comite.descrip,
                                                           Formato_comite.fec_cre,
                                                           Formato_comite.fec_mod,
                                                           Formato_comite.usu_cre,
                                                           Formato_comite.usu_mod,
                                                           Formato_comite.cestatus
                                                         })
            _items.Add(objeto)
        Next
    End Sub



End Class

