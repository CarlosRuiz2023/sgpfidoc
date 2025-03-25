Public Class clsCoopS


#Region "variables privadas"
    Private _fid As Integer = 0
    Private _geom_frente As String = String.Empty
    Private _mts_frente As Double = 0
    Private _cid As Integer = 0
    Private _coopid As String = String.Empty
    Private _pid As Integer = 0
    Private _oid As Integer = 0
    Private _obs_grales As String = String.Empty
    Private _obra_sifidoc As String = String.Empty
    Private _gid As Integer = 0
    Private _feccre_frente As Date
    Private _fecmod_frente As Date
    Private _usucre_frente As String = String.Empty
    Private _usumod_frente As String = String.Empty
    Private _prid As Integer = 0
    Private _inc As Double = 0
    Private _did As Integer = 0
    Private _factor_act_pago As Double = 0
    Private _obr_clv_int As Integer = 0
    Private _coo_clv2 As Integer = 0
    Private _activo As Integer = 0
    Private _capital As Double = 0
    Private _midcoop As Integer = 0
    Private _mapellidop As String = String.Empty
    Private _mapellidom As String = String.Empty
    Private _mnombres As String = String.Empty
    Private _mcallecoop As String = String.Empty
    Private _mcolcoop As String = String.Empty
    Private _mnooficial_ext As String = String.Empty
    Private _mnooficial_int As String = String.Empty
    Private _mtelcoop As String = String.Empty
    Private _mnomficha As String = String.Empty
    Private _mestado As String = String.Empty
    Private _mpais As String = String.Empty
    Private _mcorreo As String = String.Empty
    Private _usrcre_coop As String = String.Empty
    Private _feccre_coop As Date
    Private _usrmod_coop As String = String.Empty
    Private _fecmod_coop As Date
    Private _mcurp As String = String.Empty
    Private _mrelacionpredio As Integer = 0
    Private _ine As String = String.Empty
    Private _doc_identific As String = String.Empty
    Private _obr_clv As String = String.Empty
    Private _obr_mts As String = String.Empty
    Private _obr_cost As Double = 0
    Private _obr_int As Integer = 0
    Private _obr_fecha As Date
    Private _obr_cost_total As Double = 0
    Private _obr_inc As Double = 0
    Private _obr_fecinip As Date
    Private _obr_fecvenp As Date
    Private _obr_npago As Integer = 0
    Private _obr_opergob As String = String.Empty
    Private _obr_fec_ini_proc As Date
    Private _obr_fec_ini_cob As Date
    Private _obr_clv_int_obra As Integer = 0
    Private _obr_prog2 As Integer = 0
    Private _nomprog As String = String.Empty
    Private _progdescrip As String = String.Empty
    Private _obr_clv2 As String = String.Empty
    Private _obr_status As Integer = 0
    Private _cestatus As String = String.Empty
    Private _oid_obra As Integer = 0
    Private _obr_fec_canc As Date
    Private _obr_sis As String = String.Empty
    Private _col_clv2 As String = String.Empty
    Private _no_contrato As String = String.Empty
    Private _gastos_admvos As Double = 0
    Private _obr_fec_pub1 As Date
    Private _obr_fec_pub2 As Date
    Private _evid_pub1 As String = String.Empty
    Private _evid_pub2 As String = String.Empty
    Private _evid_obra_proc As String = String.Empty
    Private _evid_termino_obra As String = String.Empty
    Private _obr_nat As String = String.Empty
    Private _pid_predio As Integer = 0
    Private _objectid As String = String.Empty
    Private _gid_server As Double = 0
    Private _cup As String = String.Empty
    Private _feccre_pred As Date
    Private _fecmod_pred As Date
    Private _tipo As String = String.Empty
    Private _tipopredio As Double = 0
    Private _ctapredial As String = String.Empty
    Private _ctaimuvi As String = String.Empty
    Private _observacio As String = String.Empty
    Private _shape_area As Double = 0
    Private _shape_len As Double = 0
    Private _geom_predio As String = String.Empty
    Private _uso_predio As Integer = 0
    Private _uso_suelo As String = String.Empty
    Private _r20 As String = String.Empty
    Private _nooficial As String = String.Empty
    Private _sapal As String = String.Empty
    Private _usrcre_pred As Integer = 0
    Private _usrmod_pred As Integer = 0
    Private _num_escritura As String = String.Empty
    Private _reg_escritura As String = String.Empty
    Private _folio_escritura As String = String.Empty
    Private _tomo_escritura As String = String.Empty
    Private _doc_escritura As String = String.Empty
    Private _lote As String = String.Empty
    Private _mzna As String = String.Empty
    Private _saldo_sin As Double = 0
    Private _saldo_sin_act As Double = 0
    Private _pagos As Double = 0
    Private _recargos As Double = 0
    Private _clv_inpc_ant As String = String.Empty
    Private _clv_inpc_actual As String = String.Empty
    Private _clv_inpc_actual_2 As String = String.Empty
    Private _factor_act As Double = 0
    Private _monto_act As Double = 0
    Private _saldo As Double = 0
    Private _calle As String = String.Empty
    Private _colonia As String = String.Empty
    Private _limite1 As String = String.Empty
    Private _limite2 As String = String.Empty
    Private _tramo As String = String.Empty
    Private _pae As Integer = 0
    Private _iddet As Integer = 0
    Private _det_estatus As Integer = 0
    Private _fec_imp_det As Date
    Private _fec_ent_det As Date
    Private _fec_notif_det As Date
    Private _hora_notif_det As Date
    Private _idministro As Integer = 0
    Private _musunombre As String = String.Empty
    Private _tipo_doc As Integer = 0
    Private _nom_doc As String = String.Empty
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
    Public Property geom_frente() As String
        Get
            Return _geom_frente
        End Get
        Set(ByVal Value As String)
            _geom_frente = Value
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
    Public Property coopid() As String
        Get
            Return _coopid
        End Get
        Set(ByVal Value As String)
            _coopid = Value
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
    Public Property obs_grales() As String
        Get
            Return _obs_grales
        End Get
        Set(ByVal Value As String)
            _obs_grales = Value
        End Set
    End Property
    Public Property obra_sifidoc() As String
        Get
            Return _obra_sifidoc
        End Get
        Set(ByVal Value As String)
            _obra_sifidoc = Value
        End Set
    End Property
    Public Property gid() As Integer
        Get
            Return _gid
        End Get
        Set(ByVal Value As Integer)
            _gid = Value
        End Set
    End Property
    Public Property feccre_frente() As Date
        Get
            Return _feccre_frente
        End Get
        Set(ByVal Value As Date)
            _feccre_frente = Value
        End Set
    End Property
    Public Property fecmod_frente() As Date
        Get
            Return _fecmod_frente
        End Get
        Set(ByVal Value As Date)
            _fecmod_frente = Value
        End Set
    End Property
    Public Property usucre_frente() As String
        Get
            Return _usucre_frente
        End Get
        Set(ByVal Value As String)
            _usucre_frente = Value
        End Set
    End Property
    Public Property usumod_frente() As String
        Get
            Return _usumod_frente
        End Get
        Set(ByVal Value As String)
            _usumod_frente = Value
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
    Public Property inc() As Double
        Get
            Return _inc
        End Get
        Set(ByVal Value As Double)
            _inc = Value
        End Set
    End Property
    Public Property did() As Integer
        Get
            Return _did
        End Get
        Set(ByVal Value As Integer)
            _did = Value
        End Set
    End Property
    Public Property factor_act_pago() As Double
        Get
            Return _factor_act_pago
        End Get
        Set(ByVal Value As Double)
            _factor_act_pago = Value
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
    Public Property coo_clv2() As Integer
        Get
            Return _coo_clv2
        End Get
        Set(ByVal Value As Integer)
            _coo_clv2 = Value
        End Set
    End Property
    Public Property activo() As Integer
        Get
            Return _activo
        End Get
        Set(ByVal Value As Integer)
            _activo = Value
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
    Public Property midcoop() As Integer
        Get
            Return _midcoop
        End Get
        Set(ByVal Value As Integer)
            _midcoop = Value
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
    Public Property mnooficial_int() As String
        Get
            Return _mnooficial_int
        End Get
        Set(ByVal Value As String)
            _mnooficial_int = Value
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
    Public Property mestado() As String
        Get
            Return _mestado
        End Get
        Set(ByVal Value As String)
            _mestado = Value
        End Set
    End Property
    Public Property mpais() As String
        Get
            Return _mpais
        End Get
        Set(ByVal Value As String)
            _mpais = Value
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
    Public Property usrcre_coop() As String
        Get
            Return _usrcre_coop
        End Get
        Set(ByVal Value As String)
            _usrcre_coop = Value
        End Set
    End Property
    Public Property feccre_coop() As Date
        Get
            Return _feccre_coop
        End Get
        Set(ByVal Value As Date)
            _feccre_coop = Value
        End Set
    End Property
    Public Property usrmod_coop() As String
        Get
            Return _usrmod_coop
        End Get
        Set(ByVal Value As String)
            _usrmod_coop = Value
        End Set
    End Property
    Public Property fecmod_coop() As Date
        Get
            Return _fecmod_coop
        End Get
        Set(ByVal Value As Date)
            _fecmod_coop = Value
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
    Public Property mrelacionpredio() As Integer
        Get
            Return _mrelacionpredio
        End Get
        Set(ByVal Value As Integer)
            _mrelacionpredio = Value
        End Set
    End Property
    Public Property ine() As String
        Get
            Return _ine
        End Get
        Set(ByVal Value As String)
            _ine = Value
        End Set
    End Property
    Public Property doc_identific() As String
        Get
            Return _doc_identific
        End Get
        Set(ByVal Value As String)
            _doc_identific = Value
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
    Public Property obr_mts() As String
        Get
            Return _obr_mts
        End Get
        Set(ByVal Value As String)
            _obr_mts = Value
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
    Public Property obr_int() As Integer
        Get
            Return _obr_int
        End Get
        Set(ByVal Value As Integer)
            _obr_int = Value
        End Set
    End Property
    Public Property obr_fecha() As Date
        Get
            Return _obr_fecha
        End Get
        Set(ByVal Value As Date)
            _obr_fecha = Value
        End Set
    End Property
    Public Property obr_cost_total() As Double
        Get
            Return _obr_cost_total
        End Get
        Set(ByVal Value As Double)
            _obr_cost_total = Value
        End Set
    End Property
    Public Property obr_inc() As Double
        Get
            Return _obr_inc
        End Get
        Set(ByVal Value As Double)
            _obr_inc = Value
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
    Public Property obr_opergob() As String
        Get
            Return _obr_opergob
        End Get
        Set(ByVal Value As String)
            _obr_opergob = Value
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
    Public Property obr_clv_int_obra() As Integer
        Get
            Return _obr_clv_int_obra
        End Get
        Set(ByVal Value As Integer)
            _obr_clv_int_obra = Value
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
    Public Property progdescrip() As String
        Get
            Return _progdescrip
        End Get
        Set(ByVal Value As String)
            _progdescrip = Value
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
    Public Property oid_obra() As Integer
        Get
            Return _oid_obra
        End Get
        Set(ByVal Value As Integer)
            _oid_obra = Value
        End Set
    End Property
    Public Property obr_fec_canc() As Date
        Get
            Return _obr_fec_canc
        End Get
        Set(ByVal Value As Date)
            _obr_fec_canc = Value
        End Set
    End Property
    Public Property obr_sis() As String
        Get
            Return _obr_sis
        End Get
        Set(ByVal Value As String)
            _obr_sis = Value
        End Set
    End Property
    Public Property col_clv2() As String
        Get
            Return _col_clv2
        End Get
        Set(ByVal Value As String)
            _col_clv2 = Value
        End Set
    End Property
    Public Property no_contrato() As String
        Get
            Return _no_contrato
        End Get
        Set(ByVal Value As String)
            _no_contrato = Value
        End Set
    End Property
    Public Property gastos_admvos() As Double
        Get
            Return _gastos_admvos
        End Get
        Set(ByVal Value As Double)
            _gastos_admvos = Value
        End Set
    End Property
    Public Property obr_fec_pub1() As Date
        Get
            Return _obr_fec_pub1
        End Get
        Set(ByVal Value As Date)
            _obr_fec_pub1 = Value
        End Set
    End Property
    Public Property obr_fec_pub2() As Date
        Get
            Return _obr_fec_pub2
        End Get
        Set(ByVal Value As Date)
            _obr_fec_pub2 = Value
        End Set
    End Property
    Public Property evid_pub1() As String
        Get
            Return _evid_pub1
        End Get
        Set(ByVal Value As String)
            _evid_pub1 = Value
        End Set
    End Property
    Public Property evid_pub2() As String
        Get
            Return _evid_pub2
        End Get
        Set(ByVal Value As String)
            _evid_pub2 = Value
        End Set
    End Property
    Public Property evid_obra_proc() As String
        Get
            Return _evid_obra_proc
        End Get
        Set(ByVal Value As String)
            _evid_obra_proc = Value
        End Set
    End Property
    Public Property evid_termino_obra() As String
        Get
            Return _evid_termino_obra
        End Get
        Set(ByVal Value As String)
            _evid_termino_obra = Value
        End Set
    End Property
    Public Property obr_nat() As String
        Get
            Return _obr_nat
        End Get
        Set(ByVal Value As String)
            _obr_nat = Value
        End Set
    End Property
    Public Property pid_predio() As Integer
        Get
            Return _pid_predio
        End Get
        Set(ByVal Value As Integer)
            _pid_predio = Value
        End Set
    End Property
    Public Property objectid() As String
        Get
            Return _objectid
        End Get
        Set(ByVal Value As String)
            _objectid = Value
        End Set
    End Property
    Public Property gid_server() As Double
        Get
            Return _gid_server
        End Get
        Set(ByVal Value As Double)
            _gid_server = Value
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
    Public Property feccre_pred() As Date
        Get
            Return _feccre_pred
        End Get
        Set(ByVal Value As Date)
            _feccre_pred = Value
        End Set
    End Property
    Public Property fecmod_pred() As Date
        Get
            Return _fecmod_pred
        End Get
        Set(ByVal Value As Date)
            _fecmod_pred = Value
        End Set
    End Property
    Public Property tipo() As String
        Get
            Return _tipo
        End Get
        Set(ByVal Value As String)
            _tipo = Value
        End Set
    End Property
    Public Property tipopredio() As Double
        Get
            Return _tipopredio
        End Get
        Set(ByVal Value As Double)
            _tipopredio = Value
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
    Public Property ctaimuvi() As String
        Get
            Return _ctaimuvi
        End Get
        Set(ByVal Value As String)
            _ctaimuvi = Value
        End Set
    End Property
    Public Property observacio() As String
        Get
            Return _observacio
        End Get
        Set(ByVal Value As String)
            _observacio = Value
        End Set
    End Property
    Public Property shape_area() As Double
        Get
            Return _shape_area
        End Get
        Set(ByVal Value As Double)
            _shape_area = Value
        End Set
    End Property
    Public Property shape_len() As Double
        Get
            Return _shape_len
        End Get
        Set(ByVal Value As Double)
            _shape_len = Value
        End Set
    End Property
    Public Property geom_predio() As String
        Get
            Return _geom_predio
        End Get
        Set(ByVal Value As String)
            _geom_predio = Value
        End Set
    End Property
    Public Property uso_predio() As Integer
        Get
            Return _uso_predio
        End Get
        Set(ByVal Value As Integer)
            _uso_predio = Value
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
    Public Property r20() As String
        Get
            Return _r20
        End Get
        Set(ByVal Value As String)
            _r20 = Value
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
    Public Property sapal() As String
        Get
            Return _sapal
        End Get
        Set(ByVal Value As String)
            _sapal = Value
        End Set
    End Property
    Public Property usrcre_pred() As Integer
        Get
            Return _usrcre_pred
        End Get
        Set(ByVal Value As Integer)
            _usrcre_pred = Value
        End Set
    End Property
    Public Property usrmod_pred() As Integer
        Get
            Return _usrmod_pred
        End Get
        Set(ByVal Value As Integer)
            _usrmod_pred = Value
        End Set
    End Property
    Public Property num_escritura() As String
        Get
            Return _num_escritura
        End Get
        Set(ByVal Value As String)
            _num_escritura = Value
        End Set
    End Property
    Public Property reg_escritura() As String
        Get
            Return _reg_escritura
        End Get
        Set(ByVal Value As String)
            _reg_escritura = Value
        End Set
    End Property
    Public Property folio_escritura() As String
        Get
            Return _folio_escritura
        End Get
        Set(ByVal Value As String)
            _folio_escritura = Value
        End Set
    End Property
    Public Property tomo_escritura() As String
        Get
            Return _tomo_escritura
        End Get
        Set(ByVal Value As String)
            _tomo_escritura = Value
        End Set
    End Property
    Public Property doc_escritura() As String
        Get
            Return _doc_escritura
        End Get
        Set(ByVal Value As String)
            _doc_escritura = Value
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
    Public Property saldo_sin() As Double
        Get
            Return _saldo_sin
        End Get
        Set(ByVal Value As Double)
            _saldo_sin = Value
        End Set
    End Property
    Public Property saldo_sin_act() As Double
        Get
            Return _saldo_sin_act
        End Get
        Set(ByVal Value As Double)
            _saldo_sin_act = Value
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
    Public Property recargos() As Double
        Get
            Return _recargos
        End Get
        Set(ByVal Value As Double)
            _recargos = Value
        End Set
    End Property
    Public Property pagos() As Double
        Get
            Return _pagos
        End Get
        Set(ByVal Value As Double)
            _pagos = Value
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
    Public Property monto_act() As Double
        Get
            Return _monto_act
        End Get
        Set(ByVal Value As Double)
            _monto_act = Value
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
    Public Property limite1() As String
        Get
            Return _limite1
        End Get
        Set(ByVal Value As String)
            _limite1 = Value
        End Set
    End Property
    Public Property limite2() As String
        Get
            Return _limite2
        End Get
        Set(ByVal Value As String)
            _limite2 = Value
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
    Public Property pae() As Integer
        Get
            Return _pae
        End Get
        Set(ByVal Value As Integer)
            _pae = Value
        End Set
    End Property
    Public Property iddet() As Integer
        Get
            Return _iddet
        End Get
        Set(ByVal Value As Integer)
            _iddet = Value
        End Set
    End Property

    Public Property det_estatus() As Integer
        Get
            Return _det_estatus
        End Get
        Set(ByVal Value As Integer)
            _det_estatus = Value
        End Set
    End Property

    Public Property fec_imp_det() As Date
        Get
            Return _fec_imp_det
        End Get
        Set(ByVal Value As Date)
            _fec_imp_det = Value
        End Set
    End Property

    Public Property fec_ent_det() As Date
        Get
            Return _fec_ent_det
        End Get
        Set(ByVal Value As Date)
            _fec_ent_det = Value
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

    Public Property hora_notif_det() As Date
        Get
            Return _hora_notif_det
        End Get
        Set(ByVal Value As Date)
            _hora_notif_det = Value
        End Set
    End Property

    Public Property idministro() As Integer
        Get
            Return _idministro
        End Get
        Set(ByVal Value As Integer)
            _idministro = Value
        End Set
    End Property

    Public Property musunombre() As String
        Get
            Return _musunombre
        End Get
        Set(ByVal Value As String)
            _musunombre = Value
        End Set
    End Property

    Public Property tipo_doc() As Integer
        Get
            Return _tipo_doc
        End Get
        Set(ByVal Value As Integer)
            _tipo_doc = Value
        End Set
    End Property
    Public Property nom_doc() As String
        Get
            Return _nom_doc
        End Get
        Set(ByVal Value As String)
            _nom_doc = Value
        End Set
    End Property
#End Region

End Class
