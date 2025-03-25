Public Class JQGridJsonResponseAnuencia

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

    Public Sub JQGridJsonResponseAnuencia(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, anuencias As List(Of clsAnuencia))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim anuencia As clsAnuencia = New clsAnuencia()

        For Each anuencia In anuencias
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = anuencia.IdSol
            objeto.row = New List(Of String)(New String() {anuencia.IdSol,
                                                           anuencia.IdAnu,
                                                           anuencia.Folio,
                                                           anuencia.PromFidoc,
                                                           anuencia.FecEntrega,
                                                           anuencia.FecRecibo,
                                                           anuencia.NomPromCalle,
                                                           anuencia.DomicProm,
                                                           anuencia.TelProm,
                                                           anuencia.UsuCre,
                                                           anuencia.FecCre,
                                                           anuencia.UsuMod,
                                                           anuencia.FecMod,
                                                           anuencia.EstatusAnuencia,
                                                           anuencia.docdig})
            _items.Add(objeto)
        Next
    End Sub

End Class

