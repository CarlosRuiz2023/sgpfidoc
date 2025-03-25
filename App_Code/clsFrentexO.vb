Public Class clsFrentexO
    Private _oid As Integer = 0
    Private _obr_clv_int As Integer = 0
    Private _obr_clv As String = String.Empty
    Private _calle As String = String.Empty
    Private _colonia As String = String.Empty
    Private _tramo As String = String.Empty
    Private _costo_mto As Double = 0
    Private _obr_fecinip As Date
    Private _obr_fecvenp As Date
    Private _obr_npago As Double = 0
    Private _descrip_tipo_obr As String = String.Empty
    Private _estatus_obra As String = String.Empty
    Private _nomprog As String = String.Empty
    Private _progdescrip As String = String.Empty
    Private _pid As Integer = 0
    Private _nooficial As String = String.Empty
    Private _ctapredial As String = String.Empty
    Private _fid As Integer = 0
    Private _coopid As String = String.Empty
    Private _coo_clv2 As Integer = 0
    Private _mnomficha As String = String.Empty
    Private _mts_frente As Double = 0
    Private _inc As Double = 0
    Private _capital_sin_inc As Double = 0
    Private _capital As Double = 0
    Private _capital_pagado As Double = 0
    Private _cargos_pagados As Double = 0
    Private _desctos_aplicados As Double = 0
    Private _recargos_netos As Double = 0
    Private _total_pagar As Integer = 0
    Private _mapellidom As String = String.Empty
    Private _mapellidop As String = String.Empty
    Private _mnombres As String = String.Empty
    Private _costo_obra As Double = 0
    Private _abono As Double = 0
    Private _avance_obra As Double = 0
    Shared conn As New clsConexion


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

    Public Property obr_clv() As String
        Get
            Return _obr_clv
        End Get
        Set(ByVal Value As String)
            _obr_clv = Value
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

    Public Property costo_mto() As Double
        Get
            Return _costo_mto
        End Get
        Set(ByVal Value As Double)
            _costo_mto = Value
        End Set
    End Property

    Public Property obr_fecinip() As Date
        Get
            Return _obr_fecinip
        End Get
        Set(ByVal Value As Date)
            _obr_fecinip = Value
        End Set
    End Property

    Public Property obr_fecvenp() As Date
        Get
            Return _obr_fecvenp
        End Get
        Set(ByVal Value As Date)
            _obr_fecvenp = Value
        End Set
    End Property

    Public Property obr_npago() As Integer
        Get
            Return _obr_npago
        End Get
        Set(ByVal Value As Integer)
            _obr_npago = Value
        End Set
    End Property

    Public Property descrip_tipo_obr() As String
        Get
            Return _descrip_tipo_obr
        End Get
        Set(ByVal Value As String)
            _descrip_tipo_obr = Value
        End Set
    End Property

    Public Property estatus_obra() As String
        Get
            Return _estatus_obra
        End Get
        Set(ByVal Value As String)
            _estatus_obra = Value
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

    Public Property progdescrip() As String
        Get
            Return _progdescrip
        End Get
        Set(ByVal Value As String)
            _progdescrip = Value
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

    Public Property fid() As Integer
        Get
            Return _fid
        End Get
        Set(ByVal Value As Integer)
            _fid = Value
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
    Public Property coo_clv2() As String
        Get
            Return _coo_clv2
        End Get
        Set(ByVal Value As String)
            _coo_clv2 = Value
        End Set
    End Property
    Public Property mnomficha() As String
        Get
            Return _mnomficha
        End Get
        Set(ByVal Value As String)
            _mnomficha = Value
        End Set
    End Property

    Public Property mts_frente() As Double
        Get
            Return _mts_frente
        End Get
        Set(ByVal Value As Double)
            _mts_frente = Value
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

    Public Property capital_sin_inc() As Double
        Get
            Return _capital_sin_inc
        End Get
        Set(ByVal Value As Double)
            _capital_sin_inc = Value
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

    Public Property capital_pagado() As Double
        Get
            Return _capital_pagado
        End Get
        Set(ByVal Value As Double)
            _capital_pagado = Value
        End Set
    End Property

    Public Property cargos_pagados() As Double
        Get
            Return _cargos_pagados
        End Get
        Set(ByVal Value As Double)
            _cargos_pagados = Value
        End Set
    End Property

    Public Property desctos_aplicados() As Double
        Get
            Return _desctos_aplicados
        End Get
        Set(ByVal Value As Double)
            _desctos_aplicados = Value
        End Set
    End Property

    Public Property recargos_netos() As Double
        Get
            Return _recargos_netos
        End Get
        Set(ByVal Value As Double)
            _recargos_netos = Value
        End Set
    End Property

    Public Property total_pagar() As Double
        Get
            Return _total_pagar
        End Get
        Set(ByVal Value As Double)
            _total_pagar = Value
        End Set
    End Property

    Public Property mapellidom() As String
        Get
            Return _mapellidop

        End Get
        Set(ByVal Value As String)
            _mapellidop = Value
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

    Public Property mnombres() As String
        Get
            Return _mnombres
        End Get
        Set(ByVal Value As String)
            _mnombres = Value
        End Set
    End Property

    Public Property costo_obra() As Double
        Get
            Return _costo_obra
        End Get
        Set(ByVal Value As Double)
            _costo_obra = Value
        End Set
    End Property

    Public Property abono() As Double
        Get
            Return _abono
        End Get
        Set(ByVal Value As Double)
            _abono = Value
        End Set
    End Property

    Public Property avance_obra() As Double
        Get
            Return _avance_obra
        End Get
        Set(ByVal Value As Double)
            _avance_obra = Value
        End Set
    End Property

End Class
