Public Class clsEdoCtaFte
#Region "variables privadas"
    Private _fid As Integer = 0
    Private _pid As Integer = 0
    Private _oid As Integer = 0
    Private _cid As Integer = 0
    Private _cooperador As String
    Private _mnomficha As String
    Private _callenotif As String
    Private _colnotif As String
    Private _nooficnotif As String
    Private _mts_frente As Double = 0
    Private _prid As Integer = 0
    Private _costo_mto_lineal As Double = 0
    Private _costo_total_obra As Double = 0
    Private _nomprog As String
    Private _progmun As String
    Private _progcoop As String
    Private _progdescrip As String
    Private _nooficial As String
    Private _ctapredial As String
    Private _lote As String
    Private _mzna As String
    Private _r20 As String
    Private _cup As String
    Private _ctaimuvi As String
    Private _uso_predio As String
    Private _sapal As String
    Private _tipopredio As String
    Private _uso_suelo As String
    Private _adeudo As Double = 0
    Private _incremento As Double = 0
    Private _usucre As String
    Private _feccre As Date
    Private _usrmod As String
    Private _fecmod As Date
    Private _suma_pagos_antes_antes As Double = 0
    Private _suma_pagos_antes_desp As Double = 0
    Private _suma_pagos_desp_antes As Double = 0
    Private _suma_pagos_desp_desp As Double = 0
    Private _saldo_parcial As Double = 0
    Private _saldo_act As Double = 0
    Private _saldo_act2 As Double = 0
    Private _recargos As Double = 0
    Private _saldo_pagar As Double = 0
    Private _periodo_recargos As String
    Private _clv_inpc_ant As String
    Private _clv_inpc_actual As String
    Private _clv_inpc_actual_2 As String
    Private _fec_ini_per_act As String
    Private _fec_fin_per_act As String
    Private _fec_fin_per_act_2 As String
    Private _fec_notif_det As Date
    Private _fec_notif_req As Date
    Private _fec_notif_ejec As Date
    Private _fec_pav As Date
    Private _fec_rec As Date
    Private _nopagos As Integer = 0
    Private _fec_ini_pag As Date
    Private _fec_venc As Date
    Private _fec_proceso As Date
    Private _fec_cob As Date
    Private _fec_pub_1 As Date
    Private _fec_pub_2 As Date
    Private _fec_aviso_cong As Date
    Private _status_obra As Integer = 0
    Private _sector As Integer = 0
    Private _subsector As Integer = 0
    Private _cvecalle As Integer = 0
    Private _calle As String
    Private _colonia As String
    Private _tramo As String
    Private _cestatus As String
    Private _accesorios6 As Double = 0
    Private _accesorios7 As Double = 0
    Private _periodo_act As String
    Private _factor_act As Double = 0
    Private _descuentos As Double = 0
    Private _estatus_conv As Integer = 0
    Private _idconv As Integer = 0
    Private _fec_conv As Date
    Private _factor_act_conv As Double = 0
    Private _recargos_conv As Double = 0
    Private _descto_recargos_conv As Double = 0
    Private _recargo_por_conv As Double = 0
    Private _fecha_venc_conv As Date
    Private _num_pagos_conv As Integer = 0
    Private _saldo_conv As Integer = 0
    Private _pagos_conv As Integer = 0
    Private _archivo_conv As String = String.Empty
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

    Public Property cooperador() As String
        Get
            Return _cooperador
        End Get
        Set(ByVal Value As String)
            _cooperador = Value
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

    Public Property mts_frente() As Double
        Get
            Return _mts_frente
        End Get
        Set(ByVal Value As Double)
            _mts_frente = Value
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

    Public Property costo_mto_lineal() As Double
        Get
            Return _costo_mto_lineal
        End Get
        Set(ByVal Value As Double)
            _costo_mto_lineal = Value
        End Set
    End Property

    Public Property costo_total_obra() As Double
        Get
            Return _costo_total_obra
        End Get
        Set(ByVal Value As Double)
            _costo_total_obra = Value
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

    Public Property progmun() As String
        Get
            Return _progmun
        End Get
        Set(ByVal Value As String)
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

    Public Property lote() As String
        Get
            Return _lote
        End Get
        Set(ByVal Value As String)
            _lote = Value
        End Set
    End Property

    Public Property mzna() As String
        Get
            Return _mzna
        End Get
        Set(ByVal Value As String)
            _mzna = Value
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

    Public Property uso_predio() As String
        Get
            Return _uso_predio
        End Get
        Set(ByVal Value As String)
            _uso_predio = Value
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

    Public Property tipopredio() As String
        Get
            Return _tipopredio
        End Get
        Set(ByVal Value As String)
            _tipopredio = Value
        End Set
    End Property

    Public Property uso_suelo() As String
        Get
            Return _uso_suelo
        End Get
        Set(ByVal Value As String)
            _uso_suelo = Value
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

    Public Property incremento() As Double
        Get
            Return _incremento
        End Get
        Set(ByVal Value As Double)
            _incremento = Value
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

    Public Property suma_pagos_antes_antes() As Double
        Get
            Return _suma_pagos_antes_antes
        End Get
        Set(ByVal Value As Double)
            _suma_pagos_antes_antes = Value
        End Set
    End Property

    Public Property suma_pagos_antes_desp() As Double
        Get
            Return _suma_pagos_antes_desp
        End Get
        Set(ByVal Value As Double)
            _suma_pagos_antes_desp = Value
        End Set
    End Property

    Public Property suma_pagos_desp_antes() As Double
        Get
            Return _suma_pagos_desp_antes
        End Get
        Set(ByVal Value As Double)
            _suma_pagos_desp_antes = Value
        End Set
    End Property

    Public Property suma_pagos_desp_desp() As Double
        Get
            Return _suma_pagos_desp_desp
        End Get
        Set(ByVal Value As Double)
            _suma_pagos_desp_desp = Value
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

    Public Property saldo_act2() As Double
        Get
            Return _saldo_act2
        End Get
        Set(ByVal Value As Double)
            _saldo_act2 = Value
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

    Public Property saldo_pagar() As Double
        Get
            Return _saldo_pagar
        End Get
        Set(ByVal Value As Double)
            _saldo_pagar = Value
        End Set
    End Property

    Public Property periodo_recargos() As String
        Get
            Return _periodo_recargos
        End Get
        Set(ByVal Value As String)
            _periodo_recargos = Value
        End Set
    End Property

    Public Property clv_inpc_ant() As String
        Get
            Return _clv_inpc_ant
        End Get
        Set(ByVal Value As String)
            _clv_inpc_ant = Value
        End Set
    End Property

    Public Property clv_inpc_actual() As String
        Get
            Return _clv_inpc_actual
        End Get
        Set(ByVal Value As String)
            _clv_inpc_actual = Value
        End Set
    End Property

    Public Property clv_inpc_actual_2() As String
        Get
            Return _clv_inpc_actual_2
        End Get
        Set(ByVal Value As String)
            _clv_inpc_actual_2 = Value
        End Set
    End Property

    Public Property fec_ini_per_act() As String
        Get
            Return _fec_ini_per_act
        End Get
        Set(ByVal Value As String)
            _fec_ini_per_act = Value
        End Set
    End Property

    Public Property fec_fin_per_act() As String
        Get
            Return _fec_fin_per_act
        End Get
        Set(ByVal Value As String)
            _fec_fin_per_act = Value
        End Set
    End Property

    Public Property fec_fin_per_act_2() As String
        Get
            Return _fec_fin_per_act_2
        End Get
        Set(ByVal Value As String)
            _fec_fin_per_act_2 = Value
        End Set
    End Property

    Public Property fec_notif_det() As Date
        Get
            Return _fec_notif_det
        End Get
        Set(ByVal Value As Date)
            _fec_notif_det = Value
        End Set
    End Property

    Public Property fec_notif_req() As Date
        Get
            Return _fec_notif_req
        End Get
        Set(ByVal Value As Date)
            _fec_notif_req = Value
        End Set
    End Property

    Public Property fec_notif_ejec() As Date
        Get
            Return _fec_notif_ejec
        End Get
        Set(ByVal Value As Date)
            _fec_notif_ejec = Value
        End Set
    End Property

    Public Property fec_pav() As Date
        Get
            Return _fec_pav
        End Get
        Set(ByVal Value As Date)
            _fec_pav = Value
        End Set
    End Property

    Public Property fec_rec() As Date
        Get
            Return _fec_rec
        End Get
        Set(ByVal Value As Date)
            _fec_rec = Value
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

    Public Property fec_ini_pag() As Date
        Get
            Return _fec_ini_pag
        End Get
        Set(ByVal Value As Date)
            _fec_ini_pag = Value
        End Set
    End Property

    Public Property fec_venc() As Date
        Get
            Return _fec_venc
        End Get
        Set(ByVal Value As Date)
            _fec_venc = Value
        End Set
    End Property

    Public Property fec_proceso() As Date
        Get
            Return _fec_proceso
        End Get
        Set(ByVal Value As Date)
            _fec_proceso = Value
        End Set
    End Property

    Public Property fec_cob() As Date
        Get
            Return _fec_cob
        End Get
        Set(ByVal Value As Date)
            _fec_cob = Value
        End Set
    End Property

    Public Property fec_pub_1() As Date
        Get
            Return _fec_pub_1
        End Get
        Set(ByVal Value As Date)
            _fec_pub_1 = Value
        End Set
    End Property

    Public Property fec_pub_2() As Date
        Get
            Return _fec_pub_2
        End Get
        Set(ByVal Value As Date)
            _fec_pub_2 = Value
        End Set
    End Property

    Public Property fec_aviso_cong() As Date
        Get
            Return _fec_aviso_cong
        End Get
        Set(ByVal Value As Date)
            _fec_aviso_cong = Value
        End Set
    End Property

    Public Property status_obra() As Integer
        Get
            Return _status_obra
        End Get
        Set(ByVal Value As Integer)
            _status_obra = Value
        End Set
    End Property

    Public Property sector() As Integer
        Get
            Return _sector
        End Get
        Set(ByVal Value As Integer)
            _sector = Value
        End Set
    End Property

    Public Property subsector() As Integer
        Get
            Return _subsector
        End Get
        Set(ByVal Value As Integer)
            _subsector = Value
        End Set
    End Property

    Public Property cvecalle() As Integer
        Get
            Return _cvecalle
        End Get
        Set(ByVal Value As Integer)
            _cvecalle = Value
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

    Public Property cestatus() As String
        Get
            Return _cestatus
        End Get
        Set(ByVal Value As String)
            _cestatus = Value
        End Set
    End Property
    Public Property accesorios6() As Double
        Get
            Return _accesorios6
        End Get
        Set(ByVal Value As Double)
            _accesorios6 = Value
        End Set
    End Property
    Public Property accesorios7() As Double
        Get
            Return _accesorios7
        End Get
        Set(ByVal Value As Double)
            _accesorios7 = Value
        End Set
    End Property

    Public Property periodo_act() As String
        Get
            Return _periodo_act
        End Get
        Set(ByVal Value As String)
            _periodo_act = Value
        End Set
    End Property

    Public Property factor_act() As Double
        Get
            Return _factor_act
        End Get
        Set(ByVal Value As Double)
            _factor_act = Value
        End Set
    End Property

    Public Property descuentos() As Double
        Get
            Return _descuentos
        End Get
        Set(ByVal Value As Double)
            _descuentos = Value
        End Set
    End Property
    Public Property estatus_conv() As Integer
        Get
            Return _estatus_conv
        End Get
        Set(ByVal Value As Integer)
            _estatus_conv = Value
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
    Public Property fec_conv() As Date
        Get
            Return _fec_conv
        End Get
        Set(ByVal Value As Date)
            _fec_conv = Value
        End Set
    End Property
    Public Property factor_act_conv() As Double
        Get
            Return _factor_act_conv
        End Get
        Set(ByVal Value As Double)
            _factor_act_conv = Value
        End Set
    End Property
    Public Property recargos_conv() As Double
        Get
            Return _recargos_conv
        End Get
        Set(ByVal Value As Double)
            _recargos_conv = Value
        End Set
    End Property
    Public Property descto_recargos_conv() As Double
        Get
            Return _descto_recargos_conv
        End Get
        Set(ByVal Value As Double)
            _descto_recargos_conv = Value
        End Set
    End Property
    Public Property recargo_por_conv() As Double
        Get
            Return _recargo_por_conv
        End Get
        Set(ByVal Value As Double)
            _recargo_por_conv = Value
        End Set
    End Property
    Public Property fecha_venc_conv() As Date
        Get
            Return _fecha_venc_conv
        End Get
        Set(ByVal Value As Date)
            _fecha_venc_conv = Value
        End Set
    End Property

    Public Property num_pagos_conv() As Integer
        Get
            Return _num_pagos_conv
        End Get
        Set(ByVal Value As Integer)
            _num_pagos_conv = Value
        End Set
    End Property

    Public Property saldo_conv() As Double
        Get
            Return _saldo_conv
        End Get
        Set(ByVal Value As Double)
            _saldo_conv = Value
        End Set
    End Property
    Public Property pagos_conv() As Double
        Get
            Return _pagos_conv
        End Get
        Set(ByVal Value As Double)
            _pagos_conv = Value
        End Set
    End Property
    Public Property archivo_conv() As String
        Get
            Return _archivo_conv
        End Get
        Set(ByVal Value As String)
            _archivo_conv = Value
        End Set
    End Property

#End Region
End Class
