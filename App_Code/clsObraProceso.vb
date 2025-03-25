Public Class clsObraProceso

#Region "variables privadas"
    Private _oid As Integer = 0
    Private _obr_clv_int As Integer = 0
    Private _obra_s As String = String.Empty
    Private _fec_ini_proc As Date
    Private _idtipo_recurso As Integer = 0
    Private _descrip As String = String.Empty
    Private _gastos_admvos As Double = 0
    Private _num_contratos As String = String.Empty
    Private _idusu As Integer = 0
    Private _fec_mod As Date
    Private _cactivo As Integer = 0
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property oid() As Integer
        Get
            Return _oid
        End Get
        Set(ByVal Value As Integer)
            _oid = Value
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

    Public Property obra_s() As String
        Get
            Return _obra_s
        End Get
        Set(ByVal Value As String)
            _obra_s = Value
        End Set
    End Property

    Public Property fec_ini_proc() As Date
        Get
            Return _fec_ini_proc
        End Get
        Set(ByVal Value As Date)
            _fec_ini_proc = Value
        End Set
    End Property

    Public Property idtipo_recurso() As Integer
        Get
            Return _idtipo_recurso
        End Get
        Set(ByVal Value As Integer)
            _idtipo_recurso = Value
        End Set
    End Property
    Public Property descrip() As String
        Get
            Return _descrip
        End Get
        Set(ByVal Value As String)
            _descrip = Value
        End Set
    End Property
    Public Property gastos_admvos() As Double
        Get
            Return _gastos_admvos
        End Get
        Set(ByVal Value As Double)
            _gastos_admvos = Value
        End Set
    End Property

    Public Property num_contratos() As String
        Get
            Return _num_contratos
        End Get
        Set(ByVal Value As String)
            _num_contratos = Value
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

    Public Property fec_mod() As Date
        Get
            Return _fec_mod
        End Get
        Set(ByVal Value As Date)
            _fec_mod = Value
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
