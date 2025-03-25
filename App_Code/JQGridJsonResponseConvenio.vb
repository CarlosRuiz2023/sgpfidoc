Public Class JQGridJsonResponseConvenio

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

    Public Sub JQGridJsonResponseConvenio(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, convenios As List(Of clsConvenio))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim convenio As clsConvenio = New clsConvenio()

        For Each convenio In convenios
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = convenio.fid
            objeto.row = New List(Of String)(New String() {convenio.idConv,
                                                           convenio.fid,
                                                           convenio.fecconv,
                                                           convenio.factoractconv,
                                                           convenio.recargosconv,
                                                           convenio.desctorecargosconv,
                                                           convenio.saldoact2,
                                                           convenio.recargosconv,
                                                           convenio.fechavencconv,
                                                           convenio.numpagos,
                                                           convenio.saldoconv,
                                                           convenio.pagosconv,
                                                           convenio.estatusconv,
                                                           convenio.archivoconv,
                                                           convenio.usucre,
                                                           convenio.accion})
            _items.Add(objeto)
        Next
    End Sub

End Class
