Public Class JQGridJsonResponseComiteAcuerdo


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

    Public Sub JQGridJsonResponseComiteAcuerdo(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, comite_acuerdos As List(Of clsComiteAcuerdo))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim comite_acuerdo As clsComiteAcuerdo = New clsComiteAcuerdo()

        For Each comite_acuerdo In comite_acuerdos
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = comite_acuerdo.idcomite
            objeto.row = New List(Of String)(New String() {comite_acuerdo.idcomite,
                                                           comite_acuerdo.acta_comite,
                                                           comite_acuerdo.num_sesion,
                                                           comite_acuerdo.fec_comite,
                                                           comite_acuerdo.leyenda_comite,
                                                           comite_acuerdo.idacuerdo,
                                                           comite_acuerdo.num_acuerdo,
                                                           comite_acuerdo.folio_acuerdo,
                                                           comite_acuerdo.leyenda_acuerdo,
                                                           comite_acuerdo.estatus_acuerdo
                                                           })
            _items.Add(objeto)
        Next
    End Sub



End Class
