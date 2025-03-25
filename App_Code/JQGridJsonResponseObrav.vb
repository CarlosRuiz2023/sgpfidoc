Public Class JQGridJsonResponseObrav



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

    Public Sub JQGridJsonResponseObrav(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, obras As List(Of clsObra))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim obra As clsObra = New clsObra()

        For Each obra In obras
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = obra.oid
            objeto.row = New List(Of String)(New String() {obra.geom,
                                                           obra.idsol,
                                                           obra.tramo,
                                                           obra.sector,
                                                           obra.subsector,
                                                           obra.cvecalle,
                                                           obra.idpoligono,
                                                           obra.calle,
                                                           obra.colonia,
                                                           obra.id_implan,
                                                           obra.usrmod,
                                                           obra.fec_mod,
                                                           obra.obr_fec_pub1,
                                                           obra.evid_pub1,
                                                           obra.obr_fec_pub2,
                                                           obra.evid_pub2,
                                                           obra.col_clv2,
                                                           obra.cestatus,
                                                           obra.nomprog,
                                                           obra.progmun,
                                                           obra.progcoop,
                                                           obra.descrip_tipo_obr,
                                                           obra.obr_clv,
                                                           obra.obr_mts,
                                                           obra.obr_cost,
                                                           obra.obr_int,
                                                           obra.obr_fecha,
                                                           obra.obr_cost_total,
                                                           obra.obr_inc,
                                                           obra.obr_fecinip,
                                                           obra.obr_fecvenp,
                                                           obra.obr_npago,
                                                           obra.obr_opergob,
                                                           obra.obr_fec_ini_proc,
                                                           obra.obr_fec_ini_cob,
                                                           obra.obr_clv_int,
                                                           obra.obr_prog2,
                                                           obra.obr_clv2,
                                                           obra.obr_status,
                                                           obra.oid,
                                                           obra.obr_fec_can})
            _items.Add(objeto)
        Next
    End Sub

End Class
