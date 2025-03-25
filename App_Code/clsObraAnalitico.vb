Public Class clsObraAnalitico


#Region "variables privadas"

    Private _fid As Integer = 0
    Private _coopid As String = String.Empty
    Private _mts_frente As Double = 0
    Private _obr_cost As Double = 0
    Private _oid As Integer = 0
    Private _calle As String = String.Empty
    Private _colonia As String = String.Empty
    Private _tramo As String = String.Empty
    Private _obr_clv_int As Integer = 0
    Private _obr_clv As String = String.Empty
    Private _obr_opergob As String = String.Empty
    Private _obr_prog2 As Integer = 0
    Private _nomprog As String = String.Empty
    Private _descrip_tipo_obr As String = String.Empty
    Private _obr_status As Integer = 0
    Private _estatus_obra As String = String.Empty
    Private _fec_ini_pag As Date
    Private _fec_fin_pag As Date
    Private _fec_ini_proc As Date
    Private _fec_ini_cob As Date
    Private _plazo_rec As Integer = 0
    Private _num_meses_a_fecact As Integer = 0
    Private _incremento_frente As Integer = 0
    Private _capital_inicial_frente_sin_inc As Double = 0
    Private _capital_inicial_frente_con_inc As Double = 0
    Private _capital_pagado_frente As Double = 0
    Private _descto_capital_frente As Double = 0
    Private _total_recargos_frente As Double = 0
    Private _cargos_pagados_frente As Double = 0
    Private _descto_recargos_frente As Double = 0
    Private _ayudas_sociales_frente As Double = 0
    Private _saldo_capital_frente As Double = 0
    Private _saldo_recargos_frente As Double = 0
    Private _saldo_gral_frente As Double = 0
    Private _saldo_sin As Double = 0
    Private _saldo_con As Double = 0
    Private _avance_pago_con_inc_x_frente As Double = 0
    Private _avance_pago_sin_inc_x_frente As Double = 0
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
    Public Property coopid() As String
        Get
            Return _coopid
        End Get
        Set(ByVal Value As String)
            _coopid = Value
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

    Public Property obr_cost() As Double
        Get
            Return _obr_cost
        End Get
        Set(ByVal Value As Double)
            _obr_cost = Value
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

    Public Property obr_opergob() As String
        Get
            Return _obr_opergob
        End Get
        Set(ByVal Value As String)
            _obr_opergob = Value
        End Set
    End Property

    Public Property obr_prog2() As Integer
        Get
            Return _obr_prog2
        End Get
        Set(ByVal Value As Integer)
            _obr_prog2 = Value
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

    Public Property descrip_tipo_obr() As String
        Get
            Return _descrip_tipo_obr
        End Get
        Set(ByVal Value As String)
            _descrip_tipo_obr = Value
        End Set
    End Property

    Public Property obr_status() As Integer
        Get
            Return _obr_status
        End Get
        Set(ByVal Value As Integer)
            _obr_status = Value
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

    Public Property fec_ini_pag() As Date
        Get
            Return _fec_ini_pag
        End Get
        Set(ByVal Value As Date)
            _fec_ini_pag = Value
        End Set
    End Property

    Public Property fec_fin_pag() As Date
        Get
            Return _fec_fin_pag
        End Get
        Set(ByVal Value As Date)
            _fec_fin_pag = Value
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
    Public Property fec_ini_cob() As Date
        Get
            Return _fec_ini_cob
        End Get
        Set(ByVal Value As Date)
            _fec_ini_cob = Value
        End Set
    End Property
    Public Property plazo_rec() As Integer
        Get
            Return _plazo_rec
        End Get
        Set(ByVal Value As Integer)
            _plazo_rec = Value
        End Set
    End Property
    Public Property num_meses_a_fecact() As Integer
        Get
            Return _num_meses_a_fecact
        End Get
        Set(ByVal Value As Integer)
            _num_meses_a_fecact = Value
        End Set
    End Property

    Public Property incremento_frente() As Double
        Get
            Return _incremento_frente
        End Get
        Set(ByVal Value As Double)
            _incremento_frente = Value
        End Set
    End Property

    Public Property capital_inicial_frente_sin_inc() As Double
        Get
            Return _capital_inicial_frente_sin_inc
        End Get
        Set(ByVal Value As Double)
            _capital_inicial_frente_sin_inc = Value
        End Set
    End Property

    Public Property capital_inicial_frente_con_inc() As Double
        Get
            Return _capital_inicial_frente_con_inc
        End Get
        Set(ByVal Value As Double)
            _capital_inicial_frente_con_inc = Value
        End Set
    End Property

    Public Property capital_pagado_frente() As Double
        Get
            Return _capital_pagado_frente
        End Get
        Set(ByVal Value As Double)
            _capital_pagado_frente = Value
        End Set
    End Property

    Public Property descto_capital_frente() As Double
        Get
            Return _descto_capital_frente
        End Get
        Set(ByVal Value As Double)
            _descto_capital_frente = Value
        End Set
    End Property

    Public Property total_recargos_frente() As Double
        Get
            Return _total_recargos_frente
        End Get
        Set(ByVal Value As Double)
            _total_recargos_frente = Value
        End Set
    End Property

    Public Property cargos_pagados_frente() As Double
        Get
            Return _cargos_pagados_frente
        End Get
        Set(ByVal Value As Double)
            _cargos_pagados_frente = Value
        End Set
    End Property

    Public Property descto_recargos_frente() As Double
        Get
            Return _descto_recargos_frente
        End Get
        Set(ByVal Value As Double)
            _descto_recargos_frente = Value
        End Set
    End Property

    Public Property ayudas_sociales_frente() As Double
        Get
            Return _ayudas_sociales_frente
        End Get
        Set(ByVal Value As Double)
            _ayudas_sociales_frente = Value
        End Set
    End Property

    Public Property saldo_capital_frente() As Double
        Get
            Return _saldo_capital_frente
        End Get
        Set(ByVal Value As Double)
            _saldo_capital_frente = Value
        End Set
    End Property

    Public Property saldo_recargos_frente() As Double
        Get
            Return _saldo_recargos_frente
        End Get
        Set(ByVal Value As Double)
            _saldo_recargos_frente = Value
        End Set
    End Property

    Public Property saldo_gral_frente() As Double
        Get
            Return _saldo_gral_frente
        End Get
        Set(ByVal Value As Double)
            _saldo_gral_frente = Value
        End Set
    End Property

    Public Property saldo_sin() As Double
        Get
            Return _saldo_sin
        End Get
        Set(ByVal Value As Double)
            _saldo_sin = Value
        End Set
    End Property

    Public Property saldo_con() As Double
        Get
            Return _saldo_con
        End Get
        Set(ByVal Value As Double)
            _saldo_con = Value
        End Set
    End Property


    Public Property avance_pago_con_inc_x_frente() As Double
        Get
            Return _avance_pago_con_inc_x_frente
        End Get
        Set(ByVal Value As Double)
            _avance_pago_con_inc_x_frente = Value
        End Set
    End Property

    Public Property avance_pago_sin_inc_x_frente() As Double
        Get
            Return _avance_pago_sin_inc_x_frente
        End Get
        Set(ByVal Value As Double)
            _avance_pago_sin_inc_x_frente = Value
        End Set
    End Property


#End Region

End Class



