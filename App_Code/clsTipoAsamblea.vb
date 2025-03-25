Public Class clsTipoAsamblea
#Region "variables privadas"
    Private _IdTipoAsamblea As Integer = 0
    Private _Etiqueta As String = String.Empty
    Private _Descripcion As String = String.Empty
    Private _Mensaje As String = String.Empty
    Private _Accion As Integer = 0
    Private _usu_cre As Integer = 0
    Private _fec_cre As Date
    Private _cactivo As Integer = 0
#End Region

#Region "Propiedades"
    Public Property IdTipoAsamblea() As Integer
        Get
            Return _IdTipoAsamblea
        End Get
        Set(ByVal Value As Integer)
            _IdTipoAsamblea = Value
        End Set
    End Property

    Public Property Etiqueta() As String
        Get
            Return _Etiqueta
        End Get
        Set(ByVal Value As String)
            _Etiqueta = Value
        End Set
    End Property
    Public Property Descripcion() As String
        Get
            Return _Descripcion
        End Get
        Set(ByVal Value As String)
            _Descripcion = Value
        End Set
    End Property

    Public Property usu_cre() As Integer
        Get
            Return _usu_cre
        End Get
        Set(ByVal Value As Integer)
            _usu_cre = Value
        End Set
    End Property
    Public Property fec_cre() As Date
        Get
            Return _fec_cre
        End Get
        Set(ByVal Value As Date)
            _fec_cre = Value
        End Set
    End Property
    Public Property Accion() As Integer
        Get
            Return _Accion
        End Get
        Set(ByVal Value As Integer)
            _Accion = Value
        End Set
    End Property

    Public Property Mensaje() As String
        Get
            Return _Mensaje
        End Get
        Set(ByVal Value As String)
            _Mensaje = Value
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
#End Region
End Class
