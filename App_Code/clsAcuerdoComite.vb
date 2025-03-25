Public Class clsAcuerdoComite



#Region "variables privadas"
    Private _num_acuerdo As String = String.Empty
    Private _descrip_acuerdo As String = String.Empty
    Private _fecha_captura As Date
    Private _idusu_captura As Integer = 0
    Private _idacta As Integer = 0
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property num_acuerdo() As String
        Get
            Return _num_acuerdo
        End Get
        Set(ByVal Value As String)
            _num_acuerdo = Value
        End Set
    End Property
    Public Property descrip_acuerdo() As String
        Get
            Return _descrip_acuerdo
        End Get
        Set(ByVal Value As String)
            _descrip_acuerdo = Value
        End Set
    End Property
    Public Property fecha_captura() As Date
        Get
            Return _fecha_captura
        End Get
        Set(ByVal Value As Date)
            _fecha_captura = Value
        End Set
    End Property
    Public Property idusu_captura() As Integer
        Get
            Return _idusu_captura
        End Get
        Set(ByVal Value As Integer)
            _idusu_captura = Value
        End Set
    End Property
    Public Property idacta() As Integer
        Get
            Return _idacta
        End Get
        Set(ByVal Value As Integer)
            _idacta = Value
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
