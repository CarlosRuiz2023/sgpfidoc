Public Class JQGridJsonResponseRol
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


    Public Sub JQGridJsonResponseRol(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, roles As List(Of clsRolUsuario))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim rol As clsRolUsuario = New clsRolUsuario()

        For Each rol In roles
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = rol.crolid
            objeto.row = New List(Of String)(New String() {
                                                            rol.crolid,
                                                            rol.croldescripcion,
                                                            rol.crolnombre,
                                                            rol.crolestatus,
                                                            rol.usrcre,
                                                            rol.feccre,
                                                            rol.usumod,
                                                            rol.fecmod
                                                          })
            _items.Add(objeto)
        Next
    End Sub
End Class
