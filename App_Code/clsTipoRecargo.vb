Public Class clsTipoRecargo
#Region "variables privadas"
    Private _idtipomov As Integer = 0
    Private _titulomov As String = String.Empty
    Private _descripmov As String = String.Empty
    Private _natural_mov As String = String.Empty
    Private _usrcre As String = String.Empty
    Private _feccre As Date
    Private _usrmod As String = String.Empty
    Private _fecmod As Date
    Private _activo As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property idtipomov() As Integer
        Get
            Return _idtipomov
        End Get
        Set(ByVal Value As Integer)
            _idtipomov = Value
        End Set
    End Property
    Public Property titulomov() As String
        Get
            Return _titulomov
        End Get
        Set(ByVal Value As String)
            _titulomov = Value
        End Set
    End Property
    Public Property descripmov() As String
        Get
            Return _descripmov
        End Get
        Set(ByVal Value As String)
            _descripmov = Value
        End Set
    End Property
    Public Property natural_mov() As String
        Get
            Return _natural_mov
        End Get
        Set(ByVal Value As String)
            _natural_mov = Value
        End Set
    End Property
    Public Property usrcre() As String
        Get
            Return _usrcre
        End Get
        Set(ByVal Value As String)
            _usrcre = Value
        End Set
    End Property
    Public Property feccre() As Date
        Get
            Return _feccre
        End Get
        Set(ByVal Value As Date)
            _feccre = Value
        End Set
    End Property
    Public Property usrmod() As String
        Get
            Return _usrmod
        End Get
        Set(ByVal Value As String)
            _usrmod = Value
        End Set
    End Property
    Public Property fecmod() As Date
        Get
            Return _fecmod
        End Get
        Set(ByVal Value As Date)
            _fecmod = Value
        End Set
    End Property
    Public Property activo() As Integer
        Get
            Return _activo
        End Get
        Set(ByVal Value As Integer)
            _activo = Value
        End Set
    End Property

#End Region

End Class
