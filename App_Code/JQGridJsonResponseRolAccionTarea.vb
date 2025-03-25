Public Class JQGridJsonResponseRolAccionTarea

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

    Public Sub JQGridJsonResponseRolAccionTarea(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, rolacciontarea_s As List(Of clsRolAccionTarea))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim rolacciontarea As clsRolAccionTarea = New clsRolAccionTarea()

        For Each rolacciontarea In rolacciontarea_s
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = rolacciontarea.idrol
            objeto.row = New List(Of String)(New String() {rolacciontarea.idrol,
                                                           rolacciontarea.idaccion,
                                                           rolacciontarea.idtarea,
                                                           rolacciontarea.fec_cre,
                                                           rolacciontarea.fec_alta_accion,
                                                           rolacciontarea.etiqueta_accion,
                                                           rolacciontarea.sp,
                                                           rolacciontarea.descrip_tarea,
                                                           rolacciontarea.etiqueta_tarea,
                                                           rolacciontarea.limite_autorizacion,
                                                           rolacciontarea.fec_cre_tarea})
            _items.Add(objeto)
        Next
    End Sub

End Class
