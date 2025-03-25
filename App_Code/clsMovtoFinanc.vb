Public Class clsMovtoFinanc


#Region "variables privadas"
    Private _mov_obr As String = String.Empty
    Private _mov_coop As String = String.Empty
    Private _mov_fecha As Date
    Private _mov_usu As Integer = 0
    Private _mov_monto As Double = 0
    Private _mov_fecha_cap As Date
    Private _mov_ndep As String = String.Empty
    Private _mov_devolver As Double = 0
    Private _mov_capital As Double = 0
    Private _id As Integer = 0
    Private _obr_clv_int As Integer = 0
    Private _coo_clv2 As Integer = 0
    Private _mov_tipo_int As Integer = 0
    Private _mov_descrip As String = String.Empty
    Private _accion As Integer = 0

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property mov_obr() As String
        Get
            Return _mov_obr
        End Get
        Set(ByVal Value As String)
            _mov_obr = Value
        End Set
    End Property
    Public Property mov_coop() As String
        Get
            Return _mov_coop
        End Get
        Set(ByVal Value As String)
            _mov_coop = Value
        End Set
    End Property
    Public Property mov_fecha() As Date
        Get
            Return _mov_fecha
        End Get
        Set(ByVal Value As Date)
            _mov_fecha = Value
        End Set
    End Property
    Public Property mov_usu() As Integer
        Get
            Return _mov_usu
        End Get
        Set(ByVal Value As Integer)
            _mov_usu = Value
        End Set
    End Property
    Public Property mov_monto() As Double
        Get
            Return _mov_monto
        End Get
        Set(ByVal Value As Double)
            _mov_monto = Value
        End Set
    End Property
    Public Property mov_fecha_cap() As Date
        Get
            Return _mov_fecha_cap
        End Get
        Set(ByVal Value As Date)
            _mov_fecha_cap = Value
        End Set
    End Property
    Public Property mov_ndep() As String
        Get
            Return _mov_ndep
        End Get
        Set(ByVal Value As String)
            _mov_ndep = Value
        End Set
    End Property
    Public Property mov_devolver() As Double
        Get
            Return _mov_devolver
        End Get
        Set(ByVal Value As Double)
            _mov_devolver = Value
        End Set
    End Property
    Public Property mov_capital() As Double
        Get
            Return _mov_capital
        End Get
        Set(ByVal Value As Double)
            _mov_capital = Value
        End Set
    End Property
    Public Property id() As Integer
        Get
            Return _id
        End Get
        Set(ByVal Value As Integer)
            _id = Value
        End Set
    End Property
    Public Property obr_clv_int() As Integer
        Get
            Return _obr_clv_int
        End Get
        Set(ByVal Value As Integer)
            _obr_clv_int = Value
        End Set
    End Property
    Public Property coo_clv2() As Integer
        Get
            Return _coo_clv2
        End Get
        Set(ByVal Value As Integer)
            _coo_clv2 = Value
        End Set
    End Property
    Public Property mov_descrip() As String
        Get
            Return _mov_descrip
        End Get
        Set(ByVal Value As String)
            _mov_descrip = Value
        End Set
    End Property

    Public Property mov_tipo_int() As Integer
        Get
            Return _mov_tipo_int
        End Get
        Set(ByVal Value As Integer)
            _mov_tipo_int = Value
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

#Region "Metodos"

#End Region


End Class
