Public Class JQGridJsonResponseComite


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

    Public Sub JQGridJsonResponseComite(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, comites As List(Of clsComite))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim comite As clsComite = New clsComite()

        For Each comite In comites
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = comite.idcomite
            objeto.row = New List(Of String)(New String() {comite.idcomite,
                                                           comite.num_sesion,
                                                           comite.num_sesion_romano,
                                                           comite.leyenda,
                                                           comite.acta_comite,
                                                           comite.tipo_sesion,
                                                           comite.etiqueta_tipo_comite,
                                                           comite.formato_comite,
                                                           comite.etiqueta_formato_comite,
                                                           comite.fec_comite,
                                                           comite.usu_cre,
                                                           comite.usu_mod,
                                                           comite.fec_cre,
                                                           comite.fec_mod,
                                                           comite.cestatus
                                                           })
            _items.Add(objeto)
        Next
    End Sub



End Class





