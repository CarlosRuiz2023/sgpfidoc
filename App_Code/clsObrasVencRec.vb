Public Class clsObrasVencRec
#Region "variables privadas"
    Private _num_coops As Integer = 0
    Private _total_metros_obra As Double = 0
    Private _obr_costo As Double = 0
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
    Private _cestatus As String = String.Empty
    Private _obr_fecinip As String = String.Empty
    Private _obr_fecvenp As String = String.Empty
    Private _obr_fec_ini_proc As String = String.Empty
    Private _obr_fec_ini_cob As String = String.Empty
    Private _plazo_rec As Integer = 0
    Private _num_meses_a_fecact As Integer = 0
    Private _incremento_frente As Double = 0
    Private _capital_inicial_frente_sin_inc As Double = 0
    Private _capital_inicial_frente_con_inc As Double = 0
    Private _capital_pagado_frente As Double = 0
    Private _descto_capital_frente As Double = 0
    Private _ayudas_sociales_frente As Double = 0
    Private _total_recargos_frente As Double = 0
    Private _cargos_pagados_frente As Double = 0
    Private _descto_recargos_frente As Double = 0
    Private _saldo_capital_frente As Double = 0
    Private _saldo_recargos_frente As Double = 0
    Private _saldo_gral_frente As Double = 0
    Private _saldo_sin As Double = 0
    Private _saldo_con As Double = 0
    Private _avance_pago_con_inc As Double = 0
    Private _avance_pago_sin_inc As Double = 0
    Private _id_act_costo_obra As Integer = 0
    Private _idcomite As Integer = 0
    Private _idacuerdo As Integer = 0
    Private _fec_cap_aprob_comite As Date
    Private _idusu_aprob_comite As Integer = 0
    Private _costo_mto_nuevo As Double = 0
    Private _fec_cap_costo_mto As Date
    Private _idusu_cap_costo_mto As Integer = 0
    Private _idasamblea As Integer = 0
    Private _num_coops_act As Integer = 0
    Private _fec_comite As Date
    Private _acta_comite As String = String.Empty
    Private _num_sesion As Integer = 0
    Private _folio_acuerdo As String = String.Empty
    Private _presup_nuevo As String = String.Empty
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property num_coops() As Integer
        Get
            Return _num_coops
        End Get
        Set(ByVal Value As Integer)
            _num_coops = Value
        End Set
    End Property

    Public Property total_metros_obra() As Double
        Get
            Return _total_metros_obra
        End Get
        Set(ByVal Value As Double)
            _total_metros_obra = Value
        End Set
    End Property

    Public Property obr_costo() As Double
        Get
            Return _obr_costo
        End Get
        Set(ByVal Value As Double)
            _obr_costo = Value
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

    Public Property cestatus() As String
        Get
            Return _cestatus
        End Get
        Set(ByVal Value As String)
            _cestatus = Value
        End Set
    End Property

    Public Property obr_fecinip() As String
        Get
            Return _obr_fecinip
        End Get
        Set(ByVal Value As String)
            _obr_fecinip = Value
        End Set
    End Property

    Public Property obr_fecvenp() As String
        Get
            Return _obr_fecvenp
        End Get
        Set(ByVal Value As String)
            _obr_fecvenp = Value
        End Set
    End Property

    Public Property obr_fec_ini_proc() As String
        Get
            Return _obr_fec_ini_proc
        End Get
        Set(ByVal Value As String)
            _obr_fec_ini_proc = Value
        End Set
    End Property
    Public Property obr_fec_ini_cob() As String
        Get
            Return _obr_fec_ini_cob
        End Get
        Set(ByVal Value As String)
            _obr_fec_ini_cob = Value
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

    Public Property ayudas_sociales_frente() As Double
        Get
            Return _ayudas_sociales_frente
        End Get
        Set(ByVal Value As Double)
            _ayudas_sociales_frente = Value
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

    Public Property avance_pago_con_inc() As Double
        Get
            Return _avance_pago_con_inc
        End Get
        Set(ByVal Value As Double)
            _avance_pago_con_inc = Value
        End Set
    End Property

    Public Property avance_pago_sin_inc() As Double
        Get
            Return _avance_pago_sin_inc
        End Get
        Set(ByVal Value As Double)
            _avance_pago_sin_inc = Value
        End Set
    End Property

    Public Property id_act_costo_obra() As Integer
        Get
            Return _id_act_costo_obra
        End Get
        Set(ByVal Value As Integer)
            _id_act_costo_obra = Value
        End Set
    End Property

    Public Property idcomite() As Integer
        Get
            Return _idcomite
        End Get
        Set(ByVal Value As Integer)
            _idcomite = Value
        End Set
    End Property

    Public Property idacuerdo() As Integer
        Get
            Return _idacuerdo
        End Get
        Set(ByVal Value As Integer)
            _idacuerdo = Value
        End Set
    End Property

    Public Property fec_cap_aprob_comite() As Date
        Get
            Return _fec_cap_aprob_comite
        End Get
        Set(ByVal Value As Date)
            _fec_cap_aprob_comite = Value
        End Set
    End Property

    Public Property idusu_aprob_comite() As Integer
        Get
            Return _idusu_aprob_comite
        End Get
        Set(ByVal Value As Integer)
            _idusu_aprob_comite = Value
        End Set
    End Property
    Public Property costo_mto_nuevo() As Double
        Get
            Return _costo_mto_nuevo
        End Get
        Set(ByVal Value As Double)
            _costo_mto_nuevo = Value
        End Set
    End Property

    Public Property fec_cap_costo_mto() As Date
        Get
            Return _fec_cap_costo_mto
        End Get
        Set(ByVal Value As Date)
            _fec_cap_costo_mto = Value
        End Set
    End Property
    Public Property idusu_cap_costo_mto() As Integer
        Get
            Return _idusu_cap_costo_mto
        End Get
        Set(ByVal Value As Integer)
            _idusu_cap_costo_mto = Value
        End Set
    End Property
    Public Property idasamblea() As Integer
        Get
            Return _idasamblea
        End Get
        Set(ByVal Value As Integer)
            _idasamblea = Value
        End Set
    End Property

    Public Property num_coops_act() As Integer
        Get
            Return _num_coops_act
        End Get
        Set(ByVal Value As Integer)
            _num_coops_act = Value
        End Set
    End Property

    Public Property fec_comite() As Date
        Get
            Return _fec_comite
        End Get
        Set(ByVal Value As Date)
            _fec_comite = Value
        End Set
    End Property
    Public Property acta_comite() As String
        Get
            Return _acta_comite
        End Get
        Set(ByVal Value As String)
            _acta_comite = Value
        End Set
    End Property
    Public Property num_sesion() As Integer
        Get
            Return _num_sesion
        End Get
        Set(ByVal Value As Integer)
            _num_sesion = Value
        End Set
    End Property
    Public Property folio_acuerdo() As String
        Get
            Return _folio_acuerdo
        End Get
        Set(ByVal Value As String)
            _folio_acuerdo = Value
        End Set
    End Property
    Public Property presup_nuevo() As String
        Get
            Return _presup_nuevo
        End Get
        Set(ByVal Value As String)
            _presup_nuevo = Value
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
