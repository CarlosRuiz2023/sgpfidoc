Public Class JQGridJsonResponseContratoAnexos
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

    Public Sub JQGridJsonResponseContratoAnexos(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, contratos_anexos As List(Of clsContratoAnexos))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim contrato_anexos As clsContratoAnexos = New clsContratoAnexos()

        For Each contrato_anexos In contratos_anexos
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = contrato_anexos.idcontrato
            objeto.row = New List(Of String)(New String() {
                                                contrato_anexos.oid,
                                                contrato_anexos.obr_clv_int,
                                                contrato_anexos.obr_clv,
                                                contrato_anexos.idcontrato,
                                                contrato_anexos.num_contrato_limpio,
                                                contrato_anexos.calle,
                                                contrato_anexos.colonia,
                                                contrato_anexos.tramo,
                                                contrato_anexos.obr_prog2,
                                                contrato_anexos.nomprog,
                                                contrato_anexos.docto_contrato,
                                                contrato_anexos.cestatus_contrato,
                                                contrato_anexos.idanexo_contrato,
                                                contrato_anexos.idtipo_anexo_contrato,
                                                contrato_anexos.etiqueta_anexo,
                                                contrato_anexos.docto_param1,
                                                contrato_anexos.fecha_param2,
                                                contrato_anexos.valor_param3,
                                                contrato_anexos.valor_param4,
                                                contrato_anexos.cactivo_anexo_contrato
                                                })
            _items.Add(objeto)
        Next
    End Sub

End Class
