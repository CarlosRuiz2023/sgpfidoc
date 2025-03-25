Public Class clsFrentePredioCoop



#Region "variables privadas"
    Private _oid As Integer = 0
    Private _fid As Integer = 0
    Private _pid As Integer = 0
    Private _cid As Integer = 0
    Private _cooperador As String = String.Empty
    Private _nomcoop As String = String.Empty
    Private _mts As Double = 0
    Private _costomtolineal As Double = 0
    Private _costototalobra As Double = 0
    Private _prid As Integer = 0
    Private _nomprog As String = String.Empty
    Private _progmun As Integer = 0
    Private _progcoop As Integer = 0
    Private _progdescrip As String = String.Empty
    Private _nooficial As String = String.Empty
    Private _ctapredial As String = String.Empty
    Private _r20 As String = String.Empty
    Private _cup As String = String.Empty
    Private _ctaimuvi As String = String.Empty
    Private _sapal As String = String.Empty
    Private _tipopredionum As Integer = 0
    Private _tipopredio As String = String.Empty
    Private _adeudo As Double = 0
    Private _sumpagos As Double = 0
    Private _saldoparcial As Double = 0
    Private _saldoact2 As Double = 0
    Private _fecpav As Date
    Private _factoract As Double = 0
    Private _periodoact As String = String.Empty
    Private _saldopagar As Double = 0
    Private _recargos As Double = 0
    Private _estatusconv As Integer = 0
    Private _idconv As Integer = 0
    Private _pagosconv As Double = 0
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date


    Private _accion As String = String.Empty                   'Variable para identificar la gestion del registro 0---->ALTA, 1 ----> EDITAR y 2 ----> BAJAR'
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
    Public Property fid() As Integer
        Get
            Return _fid
        End Get
        Set(ByVal Value As Integer)
            _fid = Value
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
    Public Property nomcoop() As String
        Get
            Return _nomcoop
        End Get
        Set(ByVal Value As String)
            _nomcoop = Value
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
    Public Property costomtolineal() As Double
        Get
            Return _costomtolineal
        End Get
        Set(ByVal Value As Double)
            _costomtolineal = Value
        End Set
    End Property
    Public Property costototalobra() As Double
        Get
            Return _costototalobra
        End Get
        Set(ByVal Value As Double)
            _costototalobra = Value
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
    Public Property nomprog() As String
        Get
            Return _nomprog
        End Get
        Set(ByVal Value As String)
            _nomprog = Value
        End Set
    End Property
    Public Property progmun() As Integer
        Get
            Return _progmun
        End Get
        Set(ByVal Value As Integer)
            _progmun = Value
        End Set
    End Property
    Public Property progcoop() As String
        Get
            Return _progcoop
        End Get
        Set(ByVal Value As String)
            _progcoop = Value
        End Set
    End Property
    Public Property progdescrip() As String
        Get
            Return _progdescrip
        End Get
        Set(ByVal Value As String)
            _progdescrip = Value
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
    Public Property ctapredial() As String
        Get
            Return _ctapredial
        End Get
        Set(ByVal Value As String)
            _ctapredial = Value
        End Set
    End Property
    Public Property r20() As String
        Get
            Return _r20
        End Get
        Set(ByVal Value As String)
            _r20 = Value
        End Set
    End Property
    Public Property cup() As String
        Get
            Return _cup
        End Get
        Set(ByVal Value As String)
            _cup = Value
        End Set
    End Property
    Public Property ctaimuvi() As String
        Get
            Return _ctaimuvi
        End Get
        Set(ByVal Value As String)
            _ctaimuvi = Value
        End Set
    End Property
    Public Property sapal() As String
        Get
            Return _sapal
        End Get
        Set(ByVal Value As String)
            _sapal = Value
        End Set
    End Property
    Public Property tipopredionum() As Integer
        Get
            Return _tipopredionum
        End Get
        Set(ByVal Value As Integer)
            _tipopredionum = Value
        End Set
    End Property

    Public Property tipopredio() As String
        Get
            Return _tipopredio
        End Get
        Set(ByVal Value As String)
            _tipopredio = Value
        End Set
    End Property
    Public Property adeudo() As Double
        Get
            Return _adeudo
        End Get
        Set(ByVal Value As Double)
            _adeudo = Value
        End Set
    End Property
    Public Property sumpagos() As Double
        Get
            Return _sumpagos
        End Get
        Set(ByVal Value As Double)
            _sumpagos = Value
        End Set
    End Property
    Public Property saldoparcial() As Double
        Get
            Return _saldoparcial
        End Get
        Set(ByVal Value As Double)
            _saldoparcial = Value
        End Set
    End Property
    Public Property saldoact2() As Double
        Get
            Return _saldoact2
        End Get
        Set(ByVal Value As Double)
            _saldoact2 = Value
        End Set
    End Property
    Public Property fecpav() As Date
        Get
            Return _fecpav
        End Get
        Set(ByVal Value As Date)
            _fecpav = Value
        End Set
    End Property
    Public Property factoract() As Double
        Get
            Return _factoract
        End Get
        Set(ByVal Value As Double)
            _factoract = Value
        End Set
    End Property
    Public Property periodoact() As String
        Get
            Return _periodoact
        End Get
        Set(ByVal Value As String)
            _periodoact = Value
        End Set
    End Property
    Public Property idconv() As Integer
        Get
            Return _idconv
        End Get
        Set(ByVal Value As Integer)
            _idconv = Value
        End Set
    End Property
    Public Property pagosconv() As Double
        Get
            Return _pagosconv
        End Get
        Set(ByVal Value As Double)
            _pagosconv = Value
        End Set
    End Property

    Public Property recargos() As Double
        Get
            Return _recargos
        End Get
        Set(ByVal Value As Double)
            _recargos = Value
        End Set
    End Property

    Public Property estatusconv() As Integer
        Get
            Return _estatusconv
        End Get
        Set(ByVal Value As Integer)
            _estatusconv = Value
        End Set
    End Property

    Public Property saldopagar() As Double
        Get
            Return _saldopagar
        End Get
        Set(ByVal Value As Double)
            _saldopagar = Value
        End Set
    End Property

    Public Property UsuCre() As String
        Get
            Return _UsuCre
        End Get
        Set(ByVal Value As String)
            _UsuCre = Value
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
    Public Property UsuMod() As String
        Get
            Return _UsuMod
        End Get
        Set(ByVal Value As String)
            _UsuMod = Value
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
    Public Property Accion() As String
        Get
            Return _accion
        End Get
        Set(ByVal Value As String)
            _accion = Value
        End Set
    End Property

#End Region
End Class


