Public Class JQGridJsonResponseAsamblea

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

    Public Sub JQGridJsonResponseAsamblea(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, asambleas As List(Of clsAsamblea))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim asamblea As clsAsamblea = New clsAsamblea()

        For Each asamblea In asambleas
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = asamblea.idasamblea
            objeto.row = New List(Of String)(New String() {asamblea.idasamblea,
                                                           asamblea.lugar,
                                                           asamblea.idpromotor,
                                                           asamblea.nom_promotor,
                                                           asamblea.idtasamblea,
                                                           asamblea.nom_tasamblea,
                                                           asamblea.fecha_asamblea,
                                                           asamblea.num_asistentes,
                                                           asamblea.num_asistentes_m,
                                                           asamblea.fecha_programa,
                                                           asamblea.docto_evidencia,
                                                           asamblea.oid,
                                                           asamblea.estatus_asamblea,
                                                           asamblea.cestatus,
                                                           asamblea.usu_cre,
                                                           asamblea.usu_mod,
                                                           asamblea.fec_cre,
                                                           asamblea.fec_mod,
                                                           asamblea.calle,
                                                           asamblea.colonia,
                                                           asamblea.tramo
                                                           })
            _items.Add(objeto)
        Next
    End Sub



End Class


