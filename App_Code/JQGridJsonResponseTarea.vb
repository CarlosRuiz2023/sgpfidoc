Public Class JQGridJsonResponseTarea
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

    Public Sub JQGridJsonResponseTarea(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, tareas As List(Of clsTarea))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim tarea As clsTarea = New clsTarea()

        For Each tarea In tareas
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = tarea.idtarea
            objeto.row = New List(Of String)(New String() {tarea.idtarea,
                                                           tarea.sp,
                                                           tarea.descrip_tarea,
                                                           tarea.etiqueta_tarea,
                                                           tarea.limite_autorizacion,
                                                           tarea.fec_cre_tarea,
                                                           tarea.cactivo})
            _items.Add(objeto)
        Next
    End Sub
End Class
