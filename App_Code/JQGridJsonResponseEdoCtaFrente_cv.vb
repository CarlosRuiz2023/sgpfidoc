Public Class JQGridJsonResponseEdoCtaFrente_cv

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

    Public Sub JQGridJsonResponseEdoCtaFrente_cv(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, edoctaftes_cv As List(Of clsedoctafte_cv))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim edoctafte_cv As clsedoctafte_cv = New clsedoctafte_cv()

        For Each edoctafte_cv In edoctaftes_cv
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = edoctafte_cv.fid
            objeto.row = New List(Of String)(New String() {edoctafte_cv.fid,
            edoctafte_cv.geomfrente,
            edoctafte_cv.obrasifidoc,
            edoctafte_cv.coopid,
            edoctafte_cv.prid,
            edoctafte_cv.cid,
            edoctafte_cv.mapellidop,
            edoctafte_cv.mapellidom,
            edoctafte_cv.mnombres,
            edoctafte_cv.nomcoop,
            edoctafte_cv.mtsfrente,
            edoctafte_cv.costomtolineal,
            edoctafte_cv.adeudo,
            edoctafte_cv.saldo,
            edoctafte_cv.saldo_act,
            edoctafte_cv.geomobra,
            edoctafte_cv.calle,
            edoctafte_cv.colonia,
            edoctafte_cv.tramo,
            edoctafte_cv.ctapredial,
            edoctafte_cv.nooficial,
            edoctafte_cv.noobra,
            edoctafte_cv.noobra2,
            edoctafte_cv.noobra3,
            edoctafte_cv.fecrec,
            edoctafte_cv.fecinipag,
            edoctafte_cv.fecvenc,
            edoctafte_cv.fecproceso,
            edoctafte_cv.feccob,
            edoctafte_cv.fecpav,
            edoctafte_cv.statusfidoc,
            edoctafte_cv.geompredio,
            edoctafte_cv.feccre,
            edoctafte_cv.fecmod,
            edoctafte_cv.usucre,
            edoctafte_cv.usrmod,
            edoctafte_cv.accion})
            _items.Add(objeto)
        Next
    End Sub




End Class
