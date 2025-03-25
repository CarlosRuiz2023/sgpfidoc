Public Class JQGridJsonResponseFrentePredioCoop
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

    Public Sub JQGridJsonResponseFrentePredioCoop(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, coopsfpc As List(Of clsFrentePredioCoop))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim coopfpc As clsFrentePredioCoop = New clsFrentePredioCoop()

        For Each coopfpc In coopsfpc
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = coopfpc.fid
            objeto.row = New List(Of String)(New String() {
                                                coopfpc.oid,
                                                coopfpc.fid,
                                                coopfpc.pid,
                                                coopfpc.cid,
                                                coopfpc.cooperador,
                                                coopfpc.nomcoop,
                                                coopfpc.mts,
                                                coopfpc.prid,
                                                coopfpc.costomtolineal,
                                                coopfpc.costototalobra,
                                                coopfpc.nomprog,
                                                coopfpc.progmun,
                                                coopfpc.progcoop,
                                                coopfpc.progdescrip,
                                                coopfpc.nooficial,
                                                coopfpc.ctapredial,
                                                coopfpc.cup,
                                                coopfpc.ctaimuvi,
                                                coopfpc.sapal,
                                                coopfpc.tipopredionum,
                                                coopfpc.tipopredio,
                                                coopfpc.adeudo,
                                                coopfpc.sumpagos,
                                                coopfpc.saldoact2,
                                                coopfpc.saldoparcial,
                                                coopfpc.fecpav,
                                                coopfpc.factoract,
                                                coopfpc.periodoact,
                                                coopfpc.saldopagar,
                                                coopfpc.recargos,
                                                coopfpc.estatusconv,
                                                coopfpc.estatusconv,
                                                coopfpc.idconv,
                                                coopfpc.pagosconv,
                                                coopfpc.UsuCre,
                                                coopfpc.FecCre,
                                                coopfpc.UsuMod,
                                                coopfpc.FecMod
                                                })
            _items.Add(objeto)
        Next
    End Sub
End Class

