Public Class JQGridJsonResponseContratista
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

    Public Sub JQGridJsonResponseContratista(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, contratistas As List(Of clsContratista))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim contratista As clsContratista = New clsContratista()

        For Each contratista In contratistas
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = contratista.idContratista
            objeto.row = New List(Of String)(New String() {contratista.idContratista,
                                                           contratista.nom_cont,
                                                           contratista.razonsoc_cont,
                                                           contratista.rfc_cont,
                                                           contratista.num_prov_cont,
                                                           contratista.reg_pub_cont,
                                                           contratista.repres_legal_cont,
                                                           contratista.calle_cont,
                                                           contratista.colonia_cont,
                                                           contratista.ciudad_cont,
                                                           contratista.estado_cont,
                                                           contratista.tel1_cont,
                                                           contratista.tel2_cont,
                                                           contratista.email,
                                                           contratista.cp_cont,
                                                           contratista.no_oficial_cont,
                                                           contratista.usu_cre,
                                                           contratista.usu_mod,
                                                           contratista.fec_cre,
                                                           contratista.fec_mod,
                                                           contratista.cestatus})
            _items.Add(objeto)
        Next
    End Sub

End Class
