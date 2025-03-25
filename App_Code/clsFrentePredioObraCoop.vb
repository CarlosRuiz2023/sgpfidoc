Public Class clsFrentePredioObraCoop


#Region "variables privadas"
    Private _fid As Integer = 0
    Private _pid As Integer = 0
    Private _oid As Integer = 0
    Private _cid As Integer = 0
    Private _cooperador As String = String.Empty
    Private _nomficha As String = String.Empty
    Private _mtsfrente As Double = 0
    Private _prid As Integer = 0
    Private _costomtolineal As Double = 0
    Private _costototalobra As Double = 0
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
    Private _tipopredio As Integer = 0
    Private _usosuelo As String = String.Empty
    Private _adeudo As Double = 0
    Private _sumpagos As Double = 0
    Private _saldoparcial As Double = 0
    Private _fecpav As Date
    Private _factoract As Double = 0
    Private _periodoact As String = String.Empty
    Private _saldopagar As Double = 0
    Private _calle As String = String.Empty
    Private _colonia As String = String.Empty
    Private _tramo As String = String.Empty
    Private _callenotif As String = String.Empty
    Private _colnotif As String = String.Empty
    Private _nooficnotif As String = String.Empty
    Private _usucre As String = String.Empty
    Private _feccre As Date
    Private _usrmod As String = String.Empty
    Private _fecmod As Date
    Private _fecrec As Date
    Private _fecinipag As Date
    Private _nopagos As Integer
    Private _fecproc As Date
    Private _feccob As Date
    Private _fecpub1 As Date
    Private _fecpub2 As Date
    Private _fecavisocong As Date
    Private _statusobra As Integer = 0

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
    Public Property nomficha() As String
        Get
            Return _nomficha
        End Get
        Set(ByVal Value As String)
            _nomficha = Value
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
    Public Property prid() As Integer
        Get
            Return _prid
        End Get
        Set(ByVal Value As Integer)
            _prid = Value
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
    Public Property tipopredio() As Integer
        Get
            Return _tipopredio
        End Get
        Set(ByVal Value As Integer)
            _tipopredio = Value
        End Set
    End Property

    Public Property usosuelo() As String
        Get
            Return _usosuelo
        End Get
        Set(ByVal Value As String)
            _usosuelo = Value
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
    Public Property saldopagar() As Double
        Get
            Return _saldopagar
        End Get
        Set(ByVal Value As Double)
            _saldopagar = Value
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

    Public Property callenotif() As String
        Get
            Return _callenotif
        End Get
        Set(ByVal Value As String)
            _callenotif = Value
        End Set
    End Property
    Public Property colnotif() As String
        Get
            Return _colnotif
        End Get
        Set(ByVal Value As String)
            _colnotif = Value
        End Set
    End Property
    Public Property nooficnotif() As String
        Get
            Return _nooficnotif
        End Get
        Set(ByVal Value As String)
            _nooficnotif = Value
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
    Public Property fecrec() As Date
        Get
            Return _fecrec
        End Get
        Set(ByVal Value As Date)
            _fecrec = Value
        End Set
    End Property
    Public Property fecinipag() As Date
        Get
            Return _fecinipag
        End Get
        Set(ByVal Value As Date)
            _fecinipag = Value
        End Set
    End Property
    Public Property nopagos() As Integer
        Get
            Return _nopagos
        End Get
        Set(ByVal Value As Integer)
            _nopagos = Value
        End Set
    End Property
    Public Property fecproc() As Date
        Get
            Return _fecproc
        End Get
        Set(ByVal Value As Date)
            _fecproc = Value
        End Set
    End Property
    Public Property feccob() As Date
        Get
            Return _feccob
        End Get
        Set(ByVal Value As Date)
            _fecrec = Value
        End Set
    End Property
    Public Property fecpub1() As Date
        Get
            Return _fecpub1
        End Get
        Set(ByVal Value As Date)
            _fecpub1 = Value
        End Set
    End Property
    Public Property fecpub2() As Date
        Get
            Return _fecpub2
        End Get
        Set(ByVal Value As Date)
            _fecpub2 = Value
        End Set
    End Property
    Public Property fecavisocong() As Date
        Get
            Return _fecavisocong
        End Get
        Set(ByVal Value As Date)
            _fecavisocong = Value
        End Set
    End Property
    Public Property statusobra() As Integer
        Get
            Return _statusobra
        End Get
        Set(ByVal Value As Integer)
            _statusobra = Value
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

End Class
