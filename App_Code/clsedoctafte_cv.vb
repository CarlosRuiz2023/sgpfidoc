Public Class clsedoctafte_cv
#Region "variables privadas"
    Private _fid As Integer = 0
    Private _geomfrente As String = String.Empty
    Private _mtsfrente As Double = 0
    Private _cid As Integer = 0
    Private _coopid As String = String.Empty
    Private _obrasifidoc As String = String.Empty
    Private _feccre As Date
    Private _fecmod As Date
    Private _usucre As String = String.Empty
    Private _usrmod As String = String.Empty
    Private _prid As Integer = 0
    Private _costomtolineal As Double = 0
    Private _adeudo As Double = 0
    Private _saldo As Double = 0
    Private _saldoact As Double = 0
    Private _geomobra As String
    Private _calle As String = String.Empty
    Private _colonia As String = String.Empty
    Private _tramo As String = String.Empty
    Private _noobra As String = String.Empty
    Private _noobra2 As String = String.Empty
    Private _noobra3 As String = String.Empty
    Private _fecvenc As Date
    Private _fecrec As Date
    Private _fecinipag As Date
    Private _fecproceso As Date
    Private _feccob As Date
    Private _fecpav As Date
    Private _statusfidoc As String = String.Empty
    Private _geompredio As String = String.Empty
    Private _ctapredial As String = String.Empty
    Private _nooficial As String = String.Empty
    Private _mapellidop As String = String.Empty
    Private _mapellidom As String = String.Empty
    Private _mnombres As String = String.Empty
    Private _nomcoop As String = String.Empty
    Private _accion As String = String.Empty
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

    Public Property geomfrente() As String
        Get
            Return _geomfrente
        End Get
        Set(ByVal Value As String)
            _geomfrente = Value
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
    Public Property coopid() As String
        Get
            Return _coopid
        End Get
        Set(ByVal Value As String)
            _coopid = Value
        End Set
    End Property

    Public Property obrasifidoc() As String
        Get
            Return _obrasifidoc
        End Get
        Set(ByVal Value As String)
            _obrasifidoc = Value
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
    Public Property fecmod() As Date
        Get
            Return _fecmod
        End Get
        Set(ByVal Value As Date)
            _fecmod = Value
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
    Public Property usrmod() As String
        Get
            Return _usrmod
        End Get
        Set(ByVal Value As String)
            _usrmod = Value
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
    Public Property adeudo() As Double
        Get
            Return _adeudo
        End Get
        Set(ByVal Value As Double)
            _adeudo = Value
        End Set
    End Property
    Public Property saldo() As Double
        Get
            Return _saldo
        End Get
        Set(ByVal Value As Double)
            _saldo = Value
        End Set
    End Property
    Public Property saldo_act() As Double
        Get
            Return _saldoact
        End Get
        Set(ByVal Value As Double)
            _saldoact = Value
        End Set
    End Property
    Public Property geomobra() As String
        Get
            Return _geomobra
        End Get
        Set(ByVal Value As String)
            _geomobra = Value
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
    Public Property noobra() As String
        Get
            Return _noobra
        End Get
        Set(ByVal Value As String)
            _noobra = Value
        End Set
    End Property
    Public Property noobra2() As String
        Get
            Return _noobra
        End Get
        Set(ByVal Value As String)
            _noobra = Value
        End Set
    End Property
    Public Property noobra3() As String
        Get
            Return _noobra
        End Get
        Set(ByVal Value As String)
            _noobra = Value
        End Set
    End Property
    Public Property fecvenc() As Date
        Get
            Return _fecvenc
        End Get
        Set(ByVal Value As Date)
            _fecvenc = Value
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
    Public Property fecproceso() As Date
        Get
            Return _fecproceso
        End Get
        Set(ByVal Value As Date)
            _fecproceso = Value
        End Set
    End Property
    Public Property feccob() As Date
        Get
            Return _feccob
        End Get
        Set(ByVal Value As Date)
            _feccob = Value
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
    Public Property geompredio() As String
        Get
            Return _geompredio
        End Get
        Set(ByVal Value As String)
            _geompredio = Value
        End Set
    End Property

    Public Property statusfidoc() As String
        Get
            Return _statusfidoc
        End Get
        Set(ByVal Value As String)
            _statusfidoc = Value
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

    Public Property nooficial() As String
        Get
            Return _nooficial
        End Get
        Set(ByVal Value As String)
            _nooficial = Value
        End Set
    End Property

    Public Property mapellidop() As String
        Get
            Return _mapellidop
        End Get
        Set(ByVal Value As String)
            _mapellidop = Value
        End Set
    End Property
    Public Property mapellidom() As String
        Get
            Return _mapellidom
        End Get
        Set(ByVal Value As String)
            _mapellidom = Value
        End Set
    End Property
    Public Property mnombres() As String
        Get
            Return _mnombres
        End Get
        Set(ByVal Value As String)
            _mnombres = Value
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



