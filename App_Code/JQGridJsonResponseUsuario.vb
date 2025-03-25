Public Class JQGridJsonResponseUsuario

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


    Public Sub JQGridJsonResponseUsuario(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, usuarios As List(Of clsUsuarios))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim usuario As clsUsuarios = New clsUsuarios()

        For Each usuario In usuarios
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = usuario.IdUsuario
            objeto.row = New List(Of String)(New String() {
                                                            usuario.IdUsuario,
                                                            usuario.Nombre,
                                                            usuario.idarea,
                                                            usuario.Area,
                                                            usuario.Correo,
                                                            usuario.Usuario,
                                                            usuario.Pass,
                                                            usuario.IdRol,
                                                            usuario.RolTxt,
                                                            usuario.Rfc,
                                                            usuario.Curp,
                                                            usuario.Ss,
                                                            usuario.Empleado,
                                                            usuario.UsuCre,
                                                            usuario.UsuMod,
                                                            usuario.UsuEstatus,
                                                            usuario.Activo,
                                                            usuario.FecUltCon,
                                                            usuario.FecCre,
                                                            usuario.FecMod
                                                          })
            _items.Add(objeto)
        Next
    End Sub
End Class