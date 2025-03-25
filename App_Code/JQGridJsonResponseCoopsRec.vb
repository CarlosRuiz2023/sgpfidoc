Public Class JQGridJsonResponseCoopsRec

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

    Public Sub JQGridJsonResponseCoopsRec(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, coopfpocs As List(Of clsFrentePredioObraCoop))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim coopfpoc As clsFrentePredioObraCoop = New clsFrentePredioObraCoop()

        For Each coopfpoc In coopfpocs
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = coopfpoc.fid
            objeto.row = New List(Of String)(New String() {
                                                coopfpoc.fid,
                                                coopfpoc.pid,
                                                coopfpoc.oid,
                                                coopfpoc.cid,
                                                coopfpoc.cooperador,
                                                coopfpoc.nomficha,
                                                coopfpoc.mtsfrente,
                                                coopfpoc.prid,
                                                coopfpoc.costomtolineal,
                                                coopfpoc.costototalobra,
                                                coopfpoc.nomprog,
                                                coopfpoc.progmun,
                                                coopfpoc.progcoop,
                                                coopfpoc.progdescrip,
                                                coopfpoc.nooficial,
                                                coopfpoc.ctapredial,
                                                coopfpoc.r20,
                                                coopfpoc.cup,
                                                coopfpoc.ctaimuvi,
                                                coopfpoc.sapal,
                                                coopfpoc.tipopredio,
                                                coopfpoc.usosuelo,
                                                coopfpoc.adeudo,
                                                coopfpoc.sumpagos,
                                                coopfpoc.saldoparcial,
                                                coopfpoc.fecpav,
                                                coopfpoc.factoract,
                                                coopfpoc.periodoact,
                                                coopfpoc.saldopagar,
                                                coopfpoc.calle,
                                                coopfpoc.colonia,
                                                coopfpoc.tramo,
                                                coopfpoc.callenotif,
                                                coopfpoc.colnotif,
                                                coopfpoc.nooficnotif,
                                                coopfpoc.usucre,
                                                coopfpoc.feccre,
                                                coopfpoc.usrmod,
                                                coopfpoc.fecmod,
                                                coopfpoc.fecrec,
                                                coopfpoc.fecinipag,
                                                coopfpoc.nopagos,
                                                coopfpoc.fecproc,
                                                coopfpoc.feccob,
                                                coopfpoc.fecpub1,
                                                coopfpoc.fecpub2,
                                                coopfpoc.fecavisocong,
                                                coopfpoc.statusobra
                                                })
            _items.Add(objeto)
        Next
    End Sub
End Class



