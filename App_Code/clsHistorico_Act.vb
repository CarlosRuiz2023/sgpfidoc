Public Class clsHistorico_Act

#Region "variables privadas"
    Private _idactividad As Integer = 0
    Private _estatus_actividad As Integer = 0
    Private _fecha_actividad As Date
    Private _hora_actividad As DateTime
    Private _idusu As Integer = 0
    Private _idaccion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"


    Public Property idactividad() As Integer
        Get
            Return _idactividad
        End Get
        Set(ByVal Value As Integer)
            _idactividad = Value
        End Set
    End Property
    Public Property estatus_actividad() As Integer
        Get
            Return _estatus_actividad
        End Get
        Set(ByVal Value As Integer)
            _estatus_actividad = Value
        End Set
    End Property
    Public Property fecha_actividad() As Date
        Get
            Return _fecha_actividad
        End Get
        Set(ByVal Value As Date)
            _fecha_actividad = Value
        End Set
    End Property
    Public Property hora_actividad() As DateTime
        Get
            Return _hora_actividad
        End Get
        Set(ByVal Value As DateTime)
            _hora_actividad = Value
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
    Public Property idaccion() As Integer
        Get
            Return _idaccion
        End Get
        Set(ByVal Value As Integer)
            _idaccion = Value
        End Set
    End Property

#End Region




End Class
