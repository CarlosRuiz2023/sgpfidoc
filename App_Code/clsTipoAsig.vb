Public Class clsTipoAsig


#Region "variables privadas"
    Private _idasignacion As integer = 0
    Private _etiqueta As String = String.Empty
    Private _descrip_tipo_asig As String = String.Empty
    Private _cactivo As Integer = 0
    Private _fec_cre As Date
    Private _idusu As Integer = 0
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property idasignacion() As Integer
        Get
            Return _idasignacion
        End Get
        Set(ByVal Value As Integer)
            _idasignacion = Value
        End Set
    End Property
    Public Property etiqueta() As String
        Get
            Return _etiqueta
        End Get
        Set(ByVal Value As String)
            _etiqueta = Value
        End Set
    End Property
    Public Property descrip_tipo_asig() As String
        Get
            Return _descrip_tipo_asig
        End Get
        Set(ByVal Value As String)
            _descrip_tipo_asig = Value
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

    Public Property fec_cre() As Date
        Get
            Return _fec_cre
        End Get
        Set(ByVal Value As Date)
            _fec_cre = Value
        End Set
    End Property
    Public Property idusu() As Integer
        Get
            Return _idusu
        End Get
        Set(ByVal Value As Integer)
            _idusu = Value
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
#End Region
End Class