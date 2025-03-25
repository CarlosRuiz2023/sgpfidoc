Public Class clsRolUsu

#Region "variables privadas"
    Private _musuid As Integer = 0
    Private _musunombre As String = String.Empty
    Private _musucorreo As String = String.Empty
    Private _musucuenta As String = String.Empty
    Private _musupass As String = String.Empty
    Private _musuidrol As Integer = 0
    Private _musurfc As String = String.Empty
    Private _musucurp As String = String.Empty
    Private _mususs As String = String.Empty
    Private _musuempleado As Integer = 0
    Private _usrcre_usu As String = String.Empty
    Private _usrmod_usu As String = String.Empty
    Private _musuestatus As Integer = 0
    Private _cactivo As Integer = 0
    Private _musulastlogin As Date
    Private _feccre_usu As Date
    Private _fecmod_usu As Date
    Private _midarea As Integer = 0
    Private _crolid As Integer = 0
    Private _croldescripcion As String = String.Empty
    Private _crolestatus As Integer = 0
    Private _crolnombre As String = String.Empty
    Private _usucre_rol As String = String.Empty
    Private _feccre_rol As Date
    Private _usumod_rol As String = String.Empty
    Private _fecmod_rol As Date
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property musuid() As Integer
        Get
            Return _musuid
        End Get
        Set(ByVal Value As Integer)
            _musuid = Value
        End Set
    End Property

    Public Property musunombre() As String
        Get
            Return _musunombre
        End Get
        Set(ByVal Value As String)
            _musunombre = Value
        End Set
    End Property

    Public Property musucorreo() As String
        Get
            Return _musucorreo
        End Get
        Set(ByVal Value As String)
            _musucorreo = Value
        End Set
    End Property

    Public Property musucuenta() As String
        Get
            Return _musucuenta
        End Get
        Set(ByVal Value As String)
            _musucuenta = Value
        End Set
    End Property
    Public Property musupass() As String
        Get
            Return _musupass
        End Get
        Set(ByVal Value As String)
            _musupass = Value
        End Set
    End Property

    Public Property musuidrol() As Integer
        Get
            Return _musuidrol
        End Get
        Set(ByVal Value As Integer)
            _musuidrol = Value
        End Set
    End Property

    Public Property musurfc() As String
        Get
            Return _musurfc
        End Get
        Set(ByVal Value As String)
            _musurfc = Value
        End Set
    End Property

    Public Property musucurp() As String
        Get
            Return _musucurp
        End Get
        Set(ByVal Value As String)
            _musucurp = Value
        End Set
    End Property

    Public Property mususs() As String
        Get
            Return _mususs
        End Get
        Set(ByVal Value As String)
            _mususs = Value
        End Set
    End Property

    Public Property musuempleado() As Integer
        Get
            Return _musuempleado
        End Get
        Set(ByVal Value As Integer)
            _musuempleado = Value
        End Set
    End Property

    Public Property usrcre_usu() As String
        Get
            Return _usrcre_usu
        End Get
        Set(ByVal Value As String)
            _usrcre_usu = Value
        End Set
    End Property

    Public Property usrmod_usu() As String
        Get
            Return _usrmod_usu
        End Get
        Set(ByVal Value As String)
            _usrmod_usu = Value
        End Set
    End Property

    Public Property musuestatus() As Integer
        Get
            Return _musuestatus
        End Get
        Set(ByVal Value As Integer)
            _musuestatus = Value
        End Set
    End Property

    Public Property cactivo() As Integer
        Get
            Return _cactivo
        End Get
        Set(ByVal Value As Integer)
            _cactivo = Value
        End Set
    End Property

    Public Property musulastlogin() As Date
        Get
            Return _musulastlogin
        End Get
        Set(ByVal Value As Date)
            _musulastlogin = Value
        End Set
    End Property

    Public Property feccre_usu() As Date
        Get
            Return _feccre_usu
        End Get
        Set(ByVal Value As Date)
            _feccre_usu = Value
        End Set
    End Property

    Public Property fecmod_usu() As Date
        Get
            Return _fecmod_usu
        End Get
        Set(ByVal Value As Date)
            _fecmod_usu = Value
        End Set
    End Property

    Public Property midarea() As Integer
        Get
            Return _midarea
        End Get
        Set(ByVal Value As Integer)
            _midarea = Value
        End Set
    End Property

    Public Property crolid() As Integer
        Get
            Return _crolid
        End Get
        Set(ByVal Value As Integer)
            _crolid = Value
        End Set
    End Property

    Public Property croldescripcion() As String
        Get
            Return _croldescripcion
        End Get
        Set(ByVal Value As String)
            _croldescripcion = Value
        End Set
    End Property

    Public Property crolestatus() As Integer
        Get
            Return _crolestatus
        End Get
        Set(ByVal Value As Integer)
            _crolestatus = Value
        End Set
    End Property

    Public Property crolnombre() As String
        Get
            Return _crolnombre
        End Get
        Set(ByVal Value As String)
            _crolnombre = Value
        End Set
    End Property

    Public Property usucre_rol() As String
        Get
            Return _usucre_rol
        End Get
        Set(ByVal Value As String)
            _usucre_rol = Value
        End Set
    End Property

    Public Property feccre_rol() As Date
        Get
            Return _feccre_rol
        End Get
        Set(ByVal Value As Date)
            _feccre_rol = Value
        End Set
    End Property

    Public Property usumod_rol() As String
        Get
            Return _usumod_rol
        End Get
        Set(ByVal Value As String)
            _usumod_rol = Value
        End Set
    End Property

    Public Property fecmod_rol() As Date
        Get
            Return _fecmod_rol
        End Get
        Set(ByVal Value As Date)
            _fecmod_rol = Value
        End Set
    End Property
#End Region

#Region "Metodos"
#End Region

End Class


