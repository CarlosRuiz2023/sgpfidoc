Public Class JQGridJsonResponseDcto

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

    Public Sub JQGridJsonResponseDcto(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, doctos As List(Of clsDcto))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim docto As clsDcto = New clsDcto()

        For Each docto In doctos
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = docto.idsol
            objeto.row = New List(Of String)(New String() {docto.idsol,
                                                           docto.iddcto,
                                                           docto.folio,
                                                           docto.FecSolic,
                                                           docto.FecRecib,
                                                           docto.NomRecibe,
                                                           docto.DesDcto,
                                                           docto.UsuCre,
                                                           docto.FecCre,
                                                           docto.UsuMod,
                                                           docto.FecMod,
                                                           docto.NomArchivo
                                                           })
            _items.Add(objeto)
        Next
    End Sub

End Class
