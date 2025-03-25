Public Class JQGridJsonResponseEstatusAsamblea
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

    Public Sub JQGridJsonResponseEstatusAsamblea(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, estatus_asamblea_s As List(Of clsEstatusAsamblea))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim estatus_asamblea As clsEstatusAsamblea = New clsEstatusAsamblea()

        For Each estatus_asamblea In estatus_asamblea_s
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = estatus_asamblea.idestatus_asamblea
            objeto.row = New List(Of String)(New String() {
                                                estatus_asamblea.idestatus_asamblea,
                                                estatus_asamblea.etiqueta_estatus_asamblea,
                                                estatus_asamblea.cactivo,
                                                estatus_asamblea.fec_cre,
                                                estatus_asamblea.usu_cre
                                                })
            _items.Add(objeto)
        Next
    End Sub
End Class



