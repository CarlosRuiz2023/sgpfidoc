Public Class JQGridJsonResponseFact

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

    Public Sub JQGridJsonResponseFact(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, factis As List(Of clsFactibilidad))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim facti As clsFactibilidad = New clsFactibilidad()

        For Each facti In factis
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = facti.IdSol
            objeto.row = New List(Of String)(New String() {facti.IdSol,
                                                           facti.NumFact,
                                                           facti.opc1,
                                                           facti.opc2,
                                                           facti.opc3,
                                                           facti.opc4,
                                                           facti.opc5,
                                                           facti.opc6,
                                                           facti.opc7,
                                                           facti.opc8,
                                                           facti.opc9,
                                                           facti.opc10,
                                                           facti.NomUsuFact,
                                                           facti.UsuCre,
                                                           facti.FecCre,
                                                           facti.UsuMod,
                                                           facti.FecMod,
                                                           facti.EstatusFact,
                                                           facti.observtec,
                                                           facti.observgral,
                                                           facti.FolioDcto,
                                                           facti.docdig,
                                                           facti.Accion})
            _items.Add(objeto)
        Next
    End Sub

End Class