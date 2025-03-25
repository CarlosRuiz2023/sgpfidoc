Public Class clsRolUsuario

#Region "variables privadas"
    Private _crolid As Integer = 0
    Private _croldescripcion As String = String.Empty
    Private _crolnombre As String = String.Empty
    Private _crolestatus As Integer = 0
    Private _usrcre As String = String.Empty
    Private _feccre As Date
    Private _usumod As String = String.Empty
    Private _fecmod As Date
    Private _accion As Integer = 0
    Private _mensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region


#Region "Propiedades"
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

    Public Property crolnombre() As String
        Get
            Return _crolnombre
        End Get
        Set(ByVal Value As String)
            _crolnombre = Value
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
    Public Property fecmod() As Date
        Get
            Return _fecmod
        End Get
        Set(ByVal Value As Date)
            _fecmod = Value
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
    Public Property usumod() As String
        Get
            Return _usumod
        End Get
        Set(ByVal Value As String)
            _usumod = Value
        End Set
    End Property
    Public Property accion() As Integer
        Get
            Return _accion
        End Get
        Set(ByVal Value As Integer)
            _accion = Value
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

    Public Property mensaje() As String
        Get
            Return _mensaje
        End Get
        Set(ByVal Value As String)
            _mensaje = Value
        End Set
    End Property




#End Region
End Class
