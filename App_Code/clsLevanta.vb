Public Class clsLevanta
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _idLev As Integer = 0
    Private _FechaSol As Date
    Private _FechaEntrega As Date
    Private _Ejecutor As String = String.Empty
    Private _Observa As String = String.Empty
    Private _Imagen As String = String.Empty
    Private _Mapa As String = String.Empty
    Private _UsrCre As String = String.Empty
    Private _FecCre As Date
    Private _UsrMod As String = String.Empty
    Private _FecMod As Date
    Private _Activo As Integer = 0
    Private _Accion As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdSol() As Integer
        Get
            Return _IdSol
        End Get
        Set(ByVal Value As Integer)
            _IdSol = Value
        End Set
    End Property

    Public Property idLev() As Integer
        Get
            Return _idLev
        End Get
        Set(ByVal Value As Integer)
            _idLev = Value
        End Set
    End Property
    Public Property FechaSol() As Date
        Get
            Return _FechaSol
        End Get
        Set(ByVal Value As Date)
            _FechaSol = Value
        End Set
    End Property
    Public Property FechaEntrega() As Date
        Get
            Return _FechaEntrega
        End Get
        Set(ByVal Value As Date)
            _FechaEntrega = Value
        End Set
    End Property
    Public Property Ejecutor() As String
        Get
            Return _Ejecutor
        End Get
        Set(ByVal Value As String)
            _Ejecutor = Value
        End Set
    End Property

    Public Property Observa() As String
        Get
            Return _Observa
        End Get
        Set(ByVal Value As String)
            _Observa = Value
        End Set
    End Property

    Public Property Imagen() As String
        Get
            Return _Imagen
        End Get
        Set(ByVal Value As String)
            _Imagen = Value
        End Set
    End Property
    Public Property UsrCre() As String
        Get
            Return _UsrCre
        End Get
        Set(ByVal Value As String)
            _UsrCre = Value
        End Set
    End Property

    Public Property FecCre() As Date
        Get
            Return _FecCre
        End Get
        Set(ByVal Value As Date)
            _FecCre = Value
        End Set
    End Property

    Public Property UsrMod() As String
        Get
            Return _UsrMod
        End Get
        Set(ByVal Value As String)
            _UsrMod = Value
        End Set
    End Property

    Public Property FecMod() As Date
        Get
            Return _FecMod
        End Get
        Set(ByVal Value As Date)
            _FecMod = Value
        End Set
    End Property
    Public Property Mapa() As String
        Get
            Return _Mapa
        End Get
        Set(ByVal Value As String)
            _Mapa = Value
        End Set
    End Property
    Public Property Activo() As Integer
        Get
            Return _Activo
        End Get
        Set(ByVal Value As Integer)
            _Activo = Value
        End Set
    End Property
    Public Property Accion() As String
        Get
            Return _Accion
        End Get
        Set(ByVal Value As String)
            _Accion = Value
        End Set
    End Property
#End Region
End Class
