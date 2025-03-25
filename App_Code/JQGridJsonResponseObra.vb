Public Class JQGridJsonResponseObra
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

    Public Sub JQGridJsonResponseObra(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, obras As List(Of clsObra))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim obra As clsObra = New clsObra()

        For Each obra In obras
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = obra.oid
            objeto.row = New List(Of String)(New String() {obra.obr_clv_int,
                                                           obra.obr_clv2,
                                                           obra.calle,
                                                           obra.colonia,
                                                           obra.tramo,
                                                           obra.nomprog,
                                                           obra.descrip_tipo_obr,
                                                           obra.cestatus,
                                                           obra.obr_fec_pub1,
                                                           obra.evid_pub1,
                                                           obra.evid_pub1,
                                                           obra.obr_fec_pub2,
                                                           obra.evid_pub2,
                                                           obra.evid_pub2,
                                                           obra.obr_fecinip,
                                                           obra.obr_fecvenp,
                                                           obra.obr_npago,
                                                           obra.obr_fec_ini_proc,
                                                           obra.obr_idtipo_recurso,
                                                           obra.obr_descrip_tipo_recurso,
                                                           obra.evid_obra_proc,
                                                           obra.evid_obra_proc,
                                                           obra.obr_fec_ini_cob,
                                                           obra.evid_termino_obra,
                                                           obra.evid_termino_obra,
                                                           obra.obr_fec_can,
                                                           obra.no_contrato,
                                                           obra.gastos_admvos,
                                                           obra.oid,
                                                           obra.geom,
                                                           obra.idsol,
                                                           obra.sector,
                                                           obra.subsector,
                                                           obra.cvecalle,
                                                           obra.idpoligono,
                                                           obra.id_implan,
                                                           obra.usrmod,
                                                           obra.fec_mod,
                                                           obra.col_clv2,
                                                           obra.limite1,
                                                           obra.limite2,
                                                           obra.obr_status,
                                                           obra.progmun,
                                                           obra.progcoop,
                                                           obra.obr_clv,
                                                           obra.obr_mts,
                                                           obra.obr_cost,
                                                           obra.obr_int,
                                                           obra.obr_fecha,
                                                           obra.obr_cost_total,
                                                           obra.obr_inc,
                                                           obra.obr_opergob,
                                                           obra.obr_prog2,
                                                           obra.obr_sis,
                                                           obra.col_nom,
                                                           obra.obr_nat,
                                                           obra.obr_num_coops,
                                                           obra.obr_num_coops_s
                                                          })
            _items.Add(objeto)
        Next
    End Sub
End Class
