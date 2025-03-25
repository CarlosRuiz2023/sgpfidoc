Public Class clsFrentePredioCoopV

#Region "variables privadas"
    Private _fid As Integer = 0  'Número de frente'
    Private _pid As Integer = 0  'Número de predio'
    Private _oid As Integer = 0  'Número de obra'
    Private _cid As Integer = 0  'Número de id de persona'
    Private _prid As Integer = 0
    Private _programa As String = String.Empty
    Private _obrasifidoc As String = String.Empty
    Private _coopid As String = String.Empty
    Private _mtsfrente As Double = 0
    Private _costomtolineal As Double = 0
    Private _capital As Double = 0
    Private _incremento As Double = 0
    Private _sum_pagos_antes_fec_notif_det As Double = 0
    Private _sum_pagos_antes_fec_act As Double = 0
    Private _acces_falta_antes_fec_act As Double = 0
    Private _sum_acces_desp_fec_act_6 As Double = 0
    Private _sum_acces_desp_fec_act_7 As Double = 0
    Private _sum_pagos_desp_fec_act As Double = 0
    Private _saldo_parcial As Double = 0
    Private _saldo_act As Double = 0
    Private _saldo_total As Double = 0
    Private _saldo_pagar As Double = 0
    Private _recargos As Double = 0
    Private _periodorecargos As String = String.Empty
    Private _calle As String = String.Empty
    Private _colonia As String = String.Empty
    Private _tramo As String = String.Empty
    Private _noobra As String = String.Empty
    Private _noobra2 As String = String.Empty
    Private _noobra3 As String = String.Empty
    Private _fecrec As Date
    Private _fecinipag As Date
    Private _fecvenc As Date
    Private _fecproceso As Date
    Private _feccob As Date
    Private _fecpav As Date
    Private _fecnotifdet As Date
    Private _fecact As Date
    Private _statussifidoc As String = String.Empty
    Private _ctapredial As String = String.Empty
    Private _nooficial As String = String.Empty
    Private _mapellidop As String = String.Empty
    Private _mapellidom As String = String.Empty
    Private _mnombres As String = String.Empty
    Private _nomcoop As String = String.Empty
    Private _usosuelo As String = String.Empty
    Private _factoract As Double = 0
    Private _periodoact As String = String.Empty
    Private _FecCre As Date
    Private _FecMod As Date
    Private _UsuCre As String = String.Empty
    Private _UsuMod As String = String.Empty
    Private _geomfrente As String = String.Empty
    Private _geompredio As String = String.Empty
    Private _geomobra As String = String.Empty
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
    Public Property cid() As Integer
        Get
            Return _cid
        End Get
        Set(ByVal Value As Integer)
            _cid = Value
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
    Public Property programa() As String
        Get
            Return _programa
        End Get
        Set(ByVal Value As String)
            _programa = Value
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
    Public Property coopid() As String
        Get
            Return _coopid
        End Get
        Set(ByVal Value As String)
            _coopid = Value
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
    Public Property costomtolineal() As Double
        Get
            Return _costomtolineal
        End Get
        Set(ByVal Value As Double)
            _costomtolineal = Value
        End Set
    End Property
    Public Property capital() As Double
        Get
            Return _capital
        End Get
        Set(ByVal Value As Double)
            _capital = Value
        End Set
    End Property

    Public Property incremento() As Double
        Get
            Return _incremento
        End Get
        Set(ByVal Value As Double)
            _incremento = Value
        End Set
    End Property
    Public Property sum_pagos_antes_fec_notif_det() As Double
        Get
            Return _sum_pagos_antes_fec_notif_det
        End Get
        Set(ByVal Value As Double)
            _sum_pagos_antes_fec_notif_det = Value
        End Set
    End Property
    Public Property sum_pagos_antes_fec_act() As Double
        Get
            Return _sum_pagos_antes_fec_act
        End Get
        Set(ByVal Value As Double)
            _sum_pagos_antes_fec_act = Value
        End Set
    End Property
    Public Property acces_falta_antes_fec_act() As Double
        Get
            Return _acces_falta_antes_fec_act
        End Get
        Set(ByVal Value As Double)
            _acces_falta_antes_fec_act = Value
        End Set
    End Property


    Public Property sum_acces_desp_fec_act_6() As Double
        Get
            Return _sum_acces_desp_fec_act_6
        End Get
        Set(ByVal Value As Double)
            _sum_acces_desp_fec_act_6 = Value
        End Set
    End Property
    Public Property sum_acces_desp_fec_act_7() As Double
        Get
            Return _sum_acces_desp_fec_act_7
        End Get
        Set(ByVal Value As Double)
            _sum_acces_desp_fec_act_7 = Value
        End Set
    End Property
    Public Property sum_pagos_desp_fec_act() As Double
        Get
            Return _sum_pagos_desp_fec_act
        End Get
        Set(ByVal Value As Double)
            _sum_pagos_desp_fec_act = Value
        End Set
    End Property
    Public Property saldo_parcial() As Double
        Get
            Return _saldo_parcial
        End Get
        Set(ByVal Value As Double)
            _saldo_parcial = Value
        End Set
    End Property
    Public Property saldo_act() As Double
        Get
            Return _saldo_act
        End Get
        Set(ByVal Value As Double)
            _saldo_act = Value
        End Set
    End Property
    Public Property saldo_total() As Double
        Get
            Return _saldo_total
        End Get
        Set(ByVal Value As Double)
            _saldo_total = Value
        End Set
    End Property
    Public Property saldo_pagar() As Double
        Get
            Return _saldo_pagar
        End Get
        Set(ByVal Value As Double)
            _saldo_pagar = Value
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
    Public Property periodorecargos() As String
        Get
            Return _periodorecargos
        End Get
        Set(ByVal Value As String)
            _periodorecargos = Value
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
            Return _noobra2
        End Get
        Set(ByVal Value As String)
            _noobra2 = Value
        End Set
    End Property
    Public Property noobra3() As String
        Get
            Return _noobra3
        End Get
        Set(ByVal Value As String)
            _noobra3 = Value
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
    Public Property fecvenc() As Date
        Get
            Return _fecvenc
        End Get
        Set(ByVal Value As Date)
            _fecvenc = Value
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
    Public Property fecnotifdet() As Date
        Get
            Return _fecnotifdet
        End Get
        Set(ByVal Value As Date)
            _fecnotifdet = Value
        End Set
    End Property
    Public Property fecact() As Date
        Get
            Return _fecact
        End Get
        Set(ByVal Value As Date)
            _fecact = Value
        End Set
    End Property
    Public Property statussifidoc() As String
        Get
            Return _statussifidoc
        End Get
        Set(ByVal Value As String)
            _statussifidoc = Value
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
    Public Property usosuelo() As String
        Get
            Return _usosuelo
        End Get
        Set(ByVal Value As String)
            _usosuelo = Value
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
    Public Property feccre() As Date
        Get
            Return _FecCre
        End Get
        Set(ByVal Value As Date)
            _FecCre = Value
        End Set
    End Property
    Public Property fecmod() As Date
        Get
            Return _FecMod
        End Get
        Set(ByVal Value As Date)
            _FecMod = Value
        End Set
    End Property
    Public Property usucre() As String
        Get
            Return _UsuCre
        End Get
        Set(ByVal Value As String)
            _UsuCre = Value
        End Set
    End Property

    Public Property usumod() As String
        Get
            Return _UsuMod
        End Get
        Set(ByVal Value As String)
            _UsuMod = Value
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
    Public Property geompredio() As String
        Get
            Return _geompredio
        End Get
        Set(ByVal Value As String)
            _geompredio = Value
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
