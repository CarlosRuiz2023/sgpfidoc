Public Class JQGridJsonAnexoContrato
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

    Public Sub JQGridJsonAnexoContrato(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, anexos_contrato As List(Of clsAnexoContrato))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim anexo_contrato As clsAnexoContrato = New clsAnexoContrato()

        For Each anexo_contrato In anexos_contrato
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = anexo_contrato.idanexo_contrato
            objeto.row = New List(Of String)(New String() {
                                                            anexo_contrato.idcontrato,
                                                            anexo_contrato.idanexo_contrato,
                                                            anexo_contrato.idtipo_anexo_contrato,
                                                            anexo_contrato.etiqueta_anexo_contrato,
                                                            anexo_contrato.docto_param1,
                                                            anexo_contrato.fecha_param2,
                                                            anexo_contrato.valor_param3,
                                                            anexo_contrato.valor_param4,
                                                            anexo_contrato.usu_cre,
                                                            anexo_contrato.usu_mod,
                                                            anexo_contrato.fec_cre,
                                                            anexo_contrato.fec_mod,
                                                            anexo_contrato.cactivo
                                                })
            _items.Add(objeto)
        Next
    End Sub

End Class
