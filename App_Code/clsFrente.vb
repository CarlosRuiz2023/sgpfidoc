Public Class clsFrente
#Region "variables privadas"
    Private _fid As Integer = 0  'Número de frente'
    Private _longitud As Double = 0
    Private _latitud As Double = 0
    Private _mts As Double = 0
    Private _cid As Integer = 0
    Private _coopid As String = String.Empty
    Private _pid As Integer = 0
    Private _oid As Integer = 0
    Private _obs_grales As String = String.Empty
    Private _obrafidoc As String = String.Empty
    Private _gid As Integer = 0
    Private _prid As Integer = 0
    Private _inc As Double = 0
    Private _did As Integer = 0
    Private _usucre As String = String.Empty
    Private _feccre As Date
    Private _usrmod As String = String.Empty
    Private _fecmod As Date
    Private _factor_act_pago As Double = 0
    Private _obr_clv_int As Integer = 0
    Private _coo_clv2 As Integer = 0
    '1---> FACTIBILIDAD       
    '2---> Solicitud de revisión a SAPAL
    '3---> Respuesta de SAPAL a solicitud de revisión
    '4---> Solicitud de Traza a Desarrollo Urbano (DU)
    '5---> Respuesta de Desarrollo Urbano
    '6---> Anuencia 
    Private _accion As String = String.Empty                   'Variable para identificar la gestion del registro 0---->ALTA, 1 ----> EDITAR y 2 ----> BAJAR'
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property fid() As Integer
        Get
            Return _fid
        End Get
        Set(ByVal Value As Integer)
            _fid = Value
        End Set
    End Property
    Public Property longitud() As Double
        Get
            Return _longitud
        End Get
        Set(ByVal Value As Double)
            _longitud = Value
        End Set
    End Property
    Public Property latitud() As Double
        Get
            Return _latitud
        End Get
        Set(ByVal Value As Double)
            _latitud = Value
        End Set
    End Property
    Public Property inc() As Double
        Get
            Return _inc
        End Get
        Set(ByVal Value As Double)
            _inc = Value
        End Set
    End Property
    Public Property mts() As Double
        Get
            Return _mts
        End Get
        Set(ByVal Value As Double)
            _mts = Value
        End Set
    End Property
    Public Property cid() As Integer
        Get
            Return _cid
        End Get
        Set(ByVal Value As Integer)
            _cid = Value
        End Set
    End Property
    Public Property coopid() As String
        Get
            Return _coopid
        End Get
        Set(ByVal Value As String)
            _coopid = Value
        End Set
    End Property
    Public Property pid() As Integer
        Get
            Return _pid
        End Get
        Set(ByVal Value As Integer)
            _pid = Value
        End Set
    End Property
    Public Property oid() As Integer
        Get
            Return _oid
        End Get
        Set(ByVal Value As Integer)
            _oid = Value
        End Set
    End Property
    Public Property obs_grales() As String
        Get
            Return _obs_grales
        End Get
        Set(ByVal Value As String)
            _obs_grales = Value
        End Set
    End Property
    Public Property obrafidoc() As String
        Get
            Return _obrafidoc
        End Get
        Set(ByVal Value As String)
            _obrafidoc = Value
        End Set
    End Property
    Public Property gid() As Integer
        Get
            Return _gid
        End Get
        Set(ByVal Value As Integer)
            _gid = Value
        End Set
    End Property
    Public Property prid() As Integer
        Get
            Return _prid
        End Get
        Set(ByVal Value As Integer)
            _prid = Value
        End Set
    End Property
    Public Property did() As Integer
        Get
            Return _did
        End Get
        Set(ByVal Value As Integer)
            _did = Value
        End Set
    End Property
    Public Property usucre() As String
        Get
            Return _usucre
        End Get
        Set(ByVal Value As String)
            _usucre = Value
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
    Public Property accion() As String
        Get
            Return _accion
        End Get
        Set(ByVal Value As String)
            _accion = Value
        End Set
    End Property
    Public Property factor_act_pago() As Integer
        Get
            Return _factor_act_pago
        End Get
        Set(ByVal Value As Integer)
            _factor_act_pago = Value
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

#End Region
End Class
