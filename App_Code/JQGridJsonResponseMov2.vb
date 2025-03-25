Public Class JQGridJsonResponseMov2



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

    Public Sub JQGridJsonResponseMov2(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, movs As List(Of clsMovtoFinanc2))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim mov As clsMovtoFinanc2 = New clsMovtoFinanc2()

        For Each mov In movs
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = mov.fid
            objeto.row = New List(Of String)(New String() {
                                                            mov.mov_obra_sifidoc,
                                                            mov.mov_coop_sifidoc,
                                                            mov.fec_mov_as400,
                                                            mov.usu_sifidoc,
                                                            mov.monto_abono_sifidoc,
                                                            mov.monto_recargo_sifidoc,
                                                            mov.tipo_mov_sifidoc,
                                                            mov.fec_aplic_mov,
                                                            mov.clave_sifidoc,
                                                            mov.consecutivo_sifidoc,
                                                            mov.fid,
                                                            mov.usucre,
                                                            mov.monto_mov,
                                                            mov.tipo_mov,
                                                            mov.id_mov,
                                                            mov.folio_cajas,
                                                            mov.titulomov,
                                                            mov.estatus_mov
                                                })
            _items.Add(objeto)
        Next
    End Sub


End Class
