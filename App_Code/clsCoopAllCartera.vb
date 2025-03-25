Public Class clsCoopAllCartera

#Region "variables privadas"
    Private _coo_clv As String = String.Empty
    Private _coo_pat As String = String.Empty
    Private _coo_mat As String = String.Empty
    Private _coo_nom As String = String.Empty
    Private _coo_nombre As String = String.Empty
    Private _coo_nof As String = String.Empty
    Private _coo_call As String = String.Empty
    Private _coo_num As String = String.Empty
    Private _coo_col As String = String.Empty
    Private _coo_npag As Integer = 0
    Private _coo_obr As String = String.Empty
    Private _coo_mts As Double = 0
    Private _coo_inc As Double = 0
    Private _capital As Double = 0
    Private _coo_clv1 As String = String.Empty
    Private _coo_pred As String = String.Empty
    Private _obr_call As String = String.Empty
    Private _obr_col As String = String.Empty
    Private _col_nom As String = String.Empty
    Private _obr_tramo As String = String.Empty
    Private _obr_opergob As String = String.Empty
    Private _obr_npago As Integer = 0
    Private _obr_fec_proc As Date
    Private _obr_fec_cob As Date
    Private _obr_fec_rec As Date
    Private _midcoop As Integer = 0
    Private _mcallecoop As String = String.Empty
    Private _mcolcoop As String = String.Empty
    Private _mnooficial_ext As String = String.Empty
    Private _mtelcoop As String = String.Empty
    Private _mnomficha As String = String.Empty
    Private _mcurp As String = String.Empty
    Private _mcorreo As String = String.Empty
    Private _mrelacionpredio As Integer = 0
    Private _crelacionpredio As String = String.Empty
    Private _fid As Integer = 0
    Private _obra_coop_s As String = String.Empty
    Private _mts_frente As Double = 0
    Private _cid As Integer = 0
    Private _pid As Integer = 0
    Private _ctapredial As String = String.Empty
    Private _nooficial As String = String.Empty
    Private _lote As String = String.Empty
    Private _mzna As String = String.Empty
    Private _obr_clv_int As Integer = 0
    Private _obr_clv2 As String = String.Empty
    Private _calle As String = String.Empty
    Private _colonia As String = String.Empty
    Private _tramo As String = String.Empty
    Private _obr_fecinip As Date
    Private _obr_fecvenp As Date
    Private _obr_fec_ini_proc As Date
    Private _obr_fec_ini_cob As Date
    Private _obr_cost As Double = 0
    Private _obr_prog2 As Integer = 0
    Private _nomprog As String = String.Empty
    Private _obr_opergob_sgp As String = String.Empty
    Private _inc_sgp As Double = 0
    Private _capital_sgp As Double = 0
    Private _total_capital_pagado As Double = 0
    Private _total_cargos_t5 As Double = 0
    Private _total_cargos_t6 As Double = 0
    Private _total_cargos_t7 As Double = 0
    Private _total_cargos_t16 As Double = 0
    Private _total_cargos_pagados_t5 As Double = 0
    Private _total_cargos_pagados_t6 As Double = 0
    Private _total_cargos_pagados_t7 As Double = 0
    Private _total_cargos_pagados_t16 As Double = 0
    Private _total_cargos_x_pagar_t5 As Double = 0
    Private _total_cargos_x_pagar_t6 As Double = 0
    Private _total_cargos_x_pagar_t7 As Double = 0
    Private _total_cargos_x_pagar_t16 As Double = 0
    Private _total_cargos As Double = 0
    Private _total_cargos_pagados As Double = 0
    Private _total_cargos_no_pagados As Double = 0
    Private _total_pagos_x_coop As Double = 0
    Private _total_bonific_x_coop As Double = 0
    Private _total_descto_cargo_t3 As Double = 0
    Private _saldo_rapido As Double = 0
    Private _saldo_sin As Double = 0
    Private _saldo_con As Double = 0
    Private _fec_notif_det As Date
    Private _notif_det As Integer = 0
    Private _nom_notif_det As String = String.Empty
    Private _fec_notif_req As Date
    Private _notif_req As Integer = 0
    Private _nom_notif_req As String = String.Empty
    Private _fec_notif_ejec As Date
    Private _notif_ejec As Integer = 0
    Private _nom_notif_ejec As String = String.Empty
    Private _num_pagos As Integer = 0
    Private _costo_mto_old As Double = 0
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property coo_clv() As string
        Get
            Return _coo_clv
        End Get
        Set(ByVal Value As String)
            _coo_clv = Value
        End Set
    End Property

    Public Property coo_pat() As String
        Get
            Return _coo_pat
        End Get
        Set(ByVal Value As String)
            _coo_pat = Value
        End Set
    End Property

    Public Property coo_mat() As String
        Get
            Return _coo_mat
        End Get
        Set(ByVal Value As String)
            _coo_mat = Value
        End Set
    End Property

    Public Property coo_nom() As String
        Get
            Return _coo_nom
        End Get
        Set(ByVal Value As String)
            _coo_nom = Value
        End Set
    End Property

    Public Property coo_nombre() As String
        Get
            Return _coo_nombre
        End Get
        Set(ByVal Value As String)
            _coo_nombre = Value
        End Set
    End Property

    Public Property coo_nof() As String
        Get
            Return _coo_nof
        End Get
        Set(ByVal Value As String)
            _coo_nof = Value
        End Set
    End Property

    Public Property coo_call() As String
        Get
            Return _coo_call
        End Get
        Set(ByVal Value As String)
            _coo_call = Value
        End Set
    End Property

    Public Property coo_num() As String
        Get
            Return _coo_num
        End Get
        Set(ByVal Value As String)
            _coo_num = Value
        End Set
    End Property

    Public Property coo_col() As String
        Get
            Return _coo_col
        End Get
        Set(ByVal Value As String)
            _coo_col = Value
        End Set
    End Property

    Public Property coo_npag() As Integer
        Get
            Return _coo_npag
        End Get
        Set(ByVal Value As Integer)
            _coo_npag = Value
        End Set
    End Property

    Public Property coo_obr() As String
        Get
            Return _coo_obr
        End Get
        Set(ByVal Value As String)
            _coo_obr = Value
        End Set
    End Property

    Public Property coo_mts() As Double
        Get
            Return _coo_mts
        End Get
        Set(ByVal Value As Double)
            _coo_mts = Value
        End Set
    End Property

    Public Property coo_inc() As Double
        Get
            Return _coo_inc
        End Get
        Set(ByVal Value As Double)
            _coo_inc = Value
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

    Public Property coo_clv1() As String
        Get
            Return _coo_clv1
        End Get
        Set(ByVal Value As String)
            _coo_clv1 = Value
        End Set
    End Property

    Public Property coo_pred() As String
        Get
            Return _coo_pred
        End Get
        Set(ByVal Value As String)
            _coo_pred = Value
        End Set
    End Property

    Public Property obr_call() As String
        Get
            Return _obr_call
        End Get
        Set(ByVal Value As String)
            _obr_call = Value
        End Set
    End Property

    Public Property obr_col() As String
        Get
            Return _obr_col
        End Get
        Set(ByVal Value As String)
            _obr_col = Value
        End Set
    End Property

    Public Property col_nom() As String
        Get
            Return _col_nom
        End Get
        Set(ByVal Value As String)
            _col_nom = Value
        End Set
    End Property

    Public Property obr_tramo() As String
        Get
            Return _obr_tramo
        End Get
        Set(ByVal Value As String)
            _obr_tramo = Value
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

    Public Property obr_npago() As Integer
        Get
            Return _obr_npago
        End Get
        Set(ByVal Value As Integer)
            _obr_npago = Value
        End Set
    End Property

    Public Property obr_fec_proc() As Date
        Get
            Return _obr_fec_proc
        End Get
        Set(ByVal Value As Date)
            _obr_fec_proc = Value
        End Set
    End Property

    Public Property obr_fec_cob() As Date
        Get
            Return _obr_fec_cob
        End Get
        Set(ByVal Value As Date)
            _obr_fec_cob = Value
        End Set
    End Property

    Public Property obr_fec_rec() As Date
        Get
            Return _obr_fec_rec
        End Get
        Set(ByVal Value As Date)
            _obr_fec_rec = Value
        End Set
    End Property

    Public Property midcoop() As Integer
        Get
            Return _midcoop
        End Get
        Set(ByVal Value As Integer)
            _midcoop = Value
        End Set
    End Property

    Public Property mcallecoop() As String
        Get
            Return _mcallecoop
        End Get
        Set(ByVal Value As String)
            _mcallecoop = Value
        End Set
    End Property

    Public Property mcolcoop() As String
        Get
            Return _mcolcoop
        End Get
        Set(ByVal Value As String)
            _mcolcoop = Value
        End Set
    End Property

    Public Property mnooficial_ext() As String
        Get
            Return _mnooficial_ext
        End Get
        Set(ByVal Value As String)
            _mnooficial_ext = Value
        End Set
    End Property

    Public Property mtelcoop() As String
        Get
            Return _mtelcoop
        End Get
        Set(ByVal Value As String)
            _mtelcoop = Value
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

    Public Property mcurp() As String
        Get
            Return _mcurp
        End Get
        Set(ByVal Value As String)
            _mcurp = Value
        End Set
    End Property

    Public Property mcorreo() As String
        Get
            Return _mcorreo
        End Get
        Set(ByVal Value As String)
            _mcorreo = Value
        End Set
    End Property

    Public Property mrelacionpredio() As Integer
        Get
            Return _mrelacionpredio
        End Get
        Set(ByVal Value As Integer)
            _mrelacionpredio = Value
        End Set
    End Property

    Public Property crelacionpredio() As String
        Get
            Return _crelacionpredio
        End Get
        Set(ByVal Value As String)
            _crelacionpredio = Value
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

    Public Property obra_coop_s() As String
        Get
            Return _obra_coop_s
        End Get
        Set(ByVal Value As String)
            _obra_coop_s = Value
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

    Public Property cid() As Integer
        Get
            Return _cid
        End Get
        Set(ByVal Value As Integer)
            _cid = Value
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

    Public Property obr_clv_int() As Integer
        Get
            Return _obr_clv_int
        End Get
        Set(ByVal Value As Integer)
            _obr_clv_int = Value
        End Set
    End Property

    Public Property obr_clv2() As String
        Get
            Return _obr_clv2
        End Get
        Set(ByVal Value As String)
            _obr_clv2 = Value
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

    Public Property obr_fec_ini_proc() As Date
        Get
            Return _obr_fec_ini_proc
        End Get
        Set(ByVal Value As Date)
            _obr_fec_ini_proc = Value
        End Set
    End Property

    Public Property obr_fec_ini_cob() As Date
        Get
            Return _obr_fec_ini_cob
        End Get
        Set(ByVal Value As Date)
            _obr_fec_ini_cob = Value
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

    Public Property obr_opergob_sgp() As String
        Get
            Return _obr_opergob_sgp
        End Get
        Set(ByVal Value As String)
            _obr_opergob_sgp = Value
        End Set
    End Property

    Public Property inc_sgp() As Double
        Get
            Return _inc_sgp
        End Get
        Set(ByVal Value As Double)
            _inc_sgp = Value
        End Set
    End Property

    Public Property capital_sgp() As Double
        Get
            Return _capital_sgp
        End Get
        Set(ByVal Value As Double)
            _capital_sgp = Value
        End Set
    End Property

    Public Property total_capital_pagado() As Double
        Get
            Return _total_capital_pagado
        End Get
        Set(ByVal Value As Double)
            _total_capital_pagado = Value
        End Set
    End Property

    Public Property total_cargos_t5() As Double
        Get
            Return _total_cargos_t5
        End Get
        Set(ByVal Value As Double)
            _total_cargos_t5 = Value
        End Set
    End Property

    Public Property total_cargos_t6() As Double
        Get
            Return _total_cargos_t6
        End Get
        Set(ByVal Value As Double)
            _total_cargos_t6 = Value
        End Set
    End Property

    Public Property total_cargos_t7() As Double
        Get
            Return _total_cargos_t7
        End Get
        Set(ByVal Value As Double)
            _total_cargos_t7 = Value
        End Set
    End Property

    Public Property total_cargos_t16() As Double
        Get
            Return _total_cargos_t16
        End Get
        Set(ByVal Value As Double)
            _total_cargos_t16 = Value
        End Set
    End Property

    Public Property total_cargos_pagados_t5() As Double
        Get
            Return _total_cargos_pagados_t5
        End Get
        Set(ByVal Value As Double)
            _total_cargos_pagados_t5 = Value
        End Set
    End Property

    Public Property total_cargos_pagados_t6() As Double
        Get
            Return _total_cargos_pagados_t6
        End Get
        Set(ByVal Value As Double)
            _total_cargos_pagados_t6 = Value
        End Set
    End Property

    Public Property total_cargos_pagados_t7() As Double
        Get
            Return _total_cargos_pagados_t7
        End Get
        Set(ByVal Value As Double)
            _total_cargos_pagados_t7 = Value
        End Set
    End Property

    Public Property total_cargos_pagados_t16() As Double
        Get
            Return _total_cargos_pagados_t16
        End Get
        Set(ByVal Value As Double)
            _total_cargos_pagados_t16 = Value
        End Set
    End Property

    Public Property total_cargos_x_pagar_t5() As Double
        Get
            Return _total_cargos_x_pagar_t5
        End Get
        Set(ByVal Value As Double)
            _total_cargos_x_pagar_t5 = Value
        End Set
    End Property

    Public Property total_cargos_x_pagar_t6() As Double
        Get
            Return _total_cargos_x_pagar_t6
        End Get
        Set(ByVal Value As Double)
            _total_cargos_x_pagar_t6 = Value
        End Set
    End Property

    Public Property total_cargos_x_pagar_t7() As Double
        Get
            Return _total_cargos_x_pagar_t7
        End Get
        Set(ByVal Value As Double)
            _total_cargos_x_pagar_t7 = Value
        End Set
    End Property

    Public Property total_cargos_x_pagar_t16() As Double
        Get
            Return _total_cargos_x_pagar_t16
        End Get
        Set(ByVal Value As Double)
            _total_cargos_x_pagar_t16 = Value
        End Set
    End Property
    Public Property total_cargos() As Double
        Get
            Return _total_cargos
        End Get
        Set(ByVal Value As Double)
            _total_cargos = Value
        End Set
    End Property

    Public Property total_cargos_pagados() As Double
        Get
            Return _total_cargos_pagados
        End Get
        Set(ByVal Value As Double)
            _total_cargos_pagados = Value
        End Set
    End Property

    Public Property total_cargos_no_pagados() As Double
        Get
            Return _total_cargos_no_pagados
        End Get
        Set(ByVal Value As Double)
            _total_cargos_no_pagados = Value
        End Set
    End Property

    Public Property total_pagos_x_coop() As Double
        Get
            Return _total_pagos_x_coop
        End Get
        Set(ByVal Value As Double)
            _total_pagos_x_coop = Value
        End Set
    End Property

    Public Property total_bonific_x_coop() As Double
        Get
            Return _total_bonific_x_coop
        End Get
        Set(ByVal Value As Double)
            _total_bonific_x_coop = Value
        End Set
    End Property

    Public Property total_descto_cargo_t3() As Double
        Get
            Return _total_descto_cargo_t3
        End Get
        Set(ByVal Value As Double)
            _total_descto_cargo_t3 = Value
        End Set
    End Property
    Public Property saldo_rapido() As Double
        Get
            Return _saldo_rapido
        End Get
        Set(ByVal Value As Double)
            _saldo_rapido = Value
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

    Public Property fec_notif_det() As DateTime
        Get
            Return _fec_notif_det
        End Get
        Set(ByVal Value As DateTime)
            _fec_notif_det = Value
        End Set
    End Property

    Public Property notif_det() As Integer
        Get
            Return _notif_det
        End Get
        Set(ByVal Value As Integer)
            _notif_det = Value
        End Set
    End Property

    Public Property nom_notif_det() As String
        Get
            Return _nom_notif_det
        End Get
        Set(ByVal Value As String)
            _nom_notif_det = Value
        End Set
    End Property

    Public Property fec_notif_req() As DateTime
        Get
            Return _fec_notif_req
        End Get
        Set(ByVal Value As DateTime)
            _fec_notif_req = Value
        End Set
    End Property

    Public Property notif_req() As Integer
        Get
            Return _notif_req
        End Get
        Set(ByVal Value As Integer)
            _notif_req = Value
        End Set
    End Property

    Public Property nom_notif_req() As String
        Get
            Return _nom_notif_req
        End Get
        Set(ByVal Value As String)
            _nom_notif_req = Value
        End Set
    End Property

    Public Property fec_notif_ejec() As DateTime
        Get
            Return _fec_notif_ejec
        End Get
        Set(ByVal Value As DateTime)
            _fec_notif_ejec = Value
        End Set
    End Property

    Public Property notif_ejec() As Integer
        Get
            Return _notif_ejec
        End Get
        Set(ByVal Value As Integer)
            _notif_ejec = Value
        End Set
    End Property

    Public Property nom_notif_ejec() As String
        Get
            Return _nom_notif_ejec
        End Get
        Set(ByVal Value As String)
            _nom_notif_ejec = Value
        End Set
    End Property
    Public Property num_pagos() As Integer
        Get
            Return _num_pagos
        End Get
        Set(ByVal Value As Integer)
            _num_pagos = Value
        End Set
    End Property

    Public Property costo_mto_old() As Double
        Get
            Return _costo_mto_old
        End Get
        Set(ByVal Value As Double)
            _costo_mto_old = Value
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

End Class
