Public Class JQGridJsonResponseContrato
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

    Public Sub JQGridJsonResponseContrato(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, contratos As List(Of clsContrato))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim contrato As clsContrato = New clsContrato()

        For Each contrato In contratos
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = contrato.idcontrato
            objeto.row = New List(Of String)(New String() {
                                                contrato.idcontrato,
                                                contrato.num_contrato,
                                                contrato.num_contrato_limpio,
                                                contrato.obs_contrato,
                                                contrato.monto_contrato_sin_iva,
                                                contrato.monto_contrato,
                                                contrato.iva_contrato,
                                                contrato.idcontratista,
                                                contrato.nom_contratista,
                                                contrato.rfc_contratista,
                                                contrato.fec_contrato,
                                                contrato.fec_ini_contrato,
                                                contrato.fec_fin_contrato,
                                                contrato.fec_prorroga,
                                                contrato.docto_contrato,
                                                contrato.anticipo,
                                                contrato.idtipoasignacion,
                                                contrato.tipo_asignacion,
                                                contrato.fec_cre,
                                                contrato.fec_mod,
                                                contrato.usu_cre,
                                                contrato.usu_mod,
                                                contrato.cestatus})
            _items.Add(objeto)
        Next
    End Sub
End Class
