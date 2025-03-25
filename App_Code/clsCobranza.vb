Public Class clsCobranza

#Region "variables privadas"
    Private _coop As String = String.Empty
    Private _nomficha As String = String.Empty
    Private _domnotif As String = String.Empty
    Private _fid As Integer = 0
    Private _mtsfrente As Double = 0
    Private _cid As Integer = 0
    Private _cooperador As String = String.Empty
    Private _pid As Integer = 0
    Private _oid As Integer = 0
    Private _prid As Integer = 0
    Private _calle As String = String.Empty
    Private _nooficial As String = String.Empty
    Private _colonia As String = String.Empty
    Private _tramo As String = String.Empty
    Private _ctapredial As String = String.Empty
    Private _costom As String = String.Empty
    Private _adeudotot As Double = 0
    Private _saldosin As Double = 0
    Private _saldocon As Double = 0
    Private _accion As String = String.Empty

#End Region

#Region "Propiedades"
    Public Property coop() As String
        Get
            Return _coop
        End Get
        Set(ByVal Value As String)
            _coop = Value
        End Set
    End Property

    Public Property nomficha() As String
        Get
            Return _nomficha
        End Get
        Set(ByVal Value As String)
            _nomficha = Value
        End Set
    End Property

    Public Property domnotif() As String
        Get
            Return _domnotif
        End Get
        Set(ByVal Value As String)
            _domnotif = Value
        End Set
    End Property
    Public Property fid() As Integer
        Get
            Return _fid
        End Get
        Set(ByVal Value As Integer)
            _fid = Value
        End Set
    End Property

    Public Property mtsfrente() As Double
        Get
            Return _mtsfrente
        End Get
        Set(ByVal Value As Double)
            _mtsfrente = Value
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

    Public Property cooperador() As String
        Get
            Return _cooperador
        End Get
        Set(ByVal Value As String)
            _cooperador = Value
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

    Public Property prid() As Integer
        Get
            Return _prid
        End Get
        Set(ByVal Value As Integer)
            _prid = Value
        End Set
    End Property
    Public Property calle() As String
        Get
            Return _calle
        End Get
        Set(ByVal Value As String)
            _calle = Value
        End Set
    End Property

    Public Property nooficial() As String
        Get
            Return _nooficial
        End Get
        Set(ByVal Value As String)
            _nooficial = Value
        End Set
    End Property
    Public Property colonia() As String
        Get
            Return _colonia
        End Get
        Set(ByVal Value As String)
            _colonia = Value
        End Set
    End Property
    Public Property tramo() As String
        Get
            Return _tramo
        End Get
        Set(ByVal Value As String)
            _tramo = Value
        End Set
    End Property
    Public Property ctapredial() As String
        Get
            Return _ctapredial
        End Get
        Set(ByVal Value As String)
            _ctapredial = Value
        End Set
    End Property

    Public Property costom() As Double
        Get
            Return _costom
        End Get
        Set(ByVal Value As Double)
            _costom = Value
        End Set
    End Property

    Public Property adeudotot() As Double
        Get
            Return _adeudotot
        End Get
        Set(ByVal Value As Double)
            _adeudotot = Value
        End Set
    End Property

    Public Property saldosin() As Double
        Get
            Return _saldosin
        End Get
        Set(ByVal Value As Double)
            _saldosin = Value
        End Set
    End Property
    Public Property saldocon() As Double
        Get
            Return _saldocon
        End Get
        Set(ByVal Value As Double)
            _saldocon = Value
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
#End Region

#Region "Metodos"



#End Region
End Class
