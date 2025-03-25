Public Class JQGridJsonResponseCobranza

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

    Public Sub JQGridJsonResponseCobranza(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, cobranzas As List(Of clsCobranza))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim cobranza As clsCobranza = New clsCobranza()

        For Each cobranza In cobranzas
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = cobranza.fid
            objeto.row = New List(Of String)(New String() {cobranza.coop,
                                                           cobranza.nomficha,
                                                           cobranza.domnotif,
                                                           cobranza.fid,
                                                           cobranza.mtsfrente,
                                                           cobranza.cid,
                                                           cobranza.cooperador,
                                                           cobranza.pid,
                                                           cobranza.oid,
                                                           cobranza.prid,
                                                           cobranza.calle,
                                                           cobranza.nooficial,
                                                           cobranza.colonia,
                                                           cobranza.tramo,
                                                           cobranza.ctapredial,
                                                           cobranza.costom,
                                                           cobranza.adeudotot,
                                                           cobranza.saldosin,
                                                           cobranza.saldocon})
            _items.Add(objeto)
        Next
    End Sub



End Class


