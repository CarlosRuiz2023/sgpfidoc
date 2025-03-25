Public Class JQGridJsonResponsefpocPAE
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

    Public Sub JQGridJsonResponsefpocPAE(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, fpocPAEs As List(Of clsFrentePAE))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim fpocPAE As clsFrentePAE = New clsFrentePAE()

        For Each fpocPAE In fpocPAEs
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = fpocPAE.fid
            objeto.row = New List(Of String)(New String() {
                                                fpocPAE.idpasopae,
                                                fpocPAE.fid,
                                                fpocPAE.fecimpdcto,
                                                fpocPAE.fecentdcto,
                                                fpocPAE.fecnotif,
                                                fpocPAE.horanotif,
                                                fpocPAE.ministro,
                                                fpocPAE.nomministro,
                                                fpocPAE.obv,
                                                fpocPAE.evidencia,
                                                fpocPAE.estatus,
                                                fpocPAE.suerteprinc,
                                                fpocPAE.saldoparcial,
                                                fpocPAE.factoract,
                                                fpocPAE.sumapagos,
                                                fpocPAE.nombrecoop,
                                                fpocPAE.dirfirma,
                                                fpocPAE.nomdirector,
                                                fpocPAE.archivofirma,
                                                fpocPAE.callenotif,
                                                fpocPAE.colonianotif,
                                                fpocPAE.numnotif
                                                })
            _items.Add(objeto)
        Next
    End Sub

End Class
