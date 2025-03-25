Public Class JQGridJsonResponseCalleDU
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

    Public Sub JQGridJsonResponseCalleDU(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, calles_du As List(Of clsCalleDU))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim calle_du As clsCalleDU = New clsCalleDU()

        For Each calle_du In calles_du
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = calle_du.id()
            objeto.row = New List(Of String)(New String() {calle_du.id,
                                                           calle_du.objectid,
                                                           calle_du.clavecalle,
                                                           calle_du.nomactual,
                                                           calle_du.nomanterio,
                                                           calle_du.tipo,
                                                           calle_du.clasificac,
                                                           calle_du.sector,
                                                           calle_du.subsector,
                                                           calle_du.sectorsub,
                                                           calle_du.colonia,
                                                           calle_du.colindacon,
                                                           calle_du.sectorsubc,
                                                           calle_du.jerarquia,
                                                           calle_du.inicia_jer,
                                                           calle_du.termina_je,
                                                           calle_du.corredor,
                                                           calle_du.actualizac,
                                                           calle_du.observacio,
                                                           calle_du.shape_leng
                                                          })
            _items.Add(objeto)
        Next
    End Sub
End Class

