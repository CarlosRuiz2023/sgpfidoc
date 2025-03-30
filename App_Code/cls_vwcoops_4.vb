Public Class cls_vwcoops_4
    
    #Region "variables privadas"
# Private _ fid As Integer = 0
        Private _ geom_frente As String = String.Empty
        Private _ mts_frente As Double = 0
        Private _ cid As Integer = 0
        Private _ coopid As String = String.Empty
        Private _ pid As Integer = 0
        Private _ oid As Integer = 0
        Private _ obs_grales As String = String.Empty
        Private _ obra_sifidoc As String = String.Empty
        Private _ gid As Integer = 0
        Private _ feccre_frente As Date
        Private _ fecmod_frente As Date
        Private _ usucre_frente As String = String.Empty
        Private _ usumod_frente As String = String.Empty
        Private _ prid As Integer = 0
        Private _ inc As Double = 0
        Private _ did As Integer = 0
        Private _ factor_act_pago As Double = 0
        Private _ obr_clv_int As Integer = 0
        Private _ coo_clv2 As Integer = 0
        Private _ activo As Integer = 0
        Private _ capital As Double = 0
        Private _ midcoop As Integer = 0
        Private _ mapellidop As String = String.Empty
        Private _ mapellidom As String = String.Empty
        Private _ mnombres As String = String.Empty
        Private _ mcallecoop As String = String.Empty
        Private _ mcolcoop As String = String.Empty
        Private _ mnooficial_ext As String = String.Empty
        Private _ mnooficial_int As String = String.Empty
        Private _ mtelcoop As String = String.Empty
        Private _ mnomficha As String = String.Empty
        Private _ mestado As String = String.Empty
        Private _ mpais As String = String.Empty
        Private _ mcorreo As String = String.Empty
        Private _ usrcre_coop As String = String.Empty
        Private _ feccre_coop As Date
        Private _ usrmod_coop As String = String.Empty
        Private _ fecmod_coop As Date
        Private _ mcurp As String = String.Empty
        Private _ mrelacionpredio As Integer = 0
        Private _ ine As String = String.Empty
        Private _ doc_identific As String = String.Empty
        Private _ obr_clv As String = String.Empty
        Private _ obr_mts As Double = 0
        Private _ obr_cost As Double = 0
        Private _ obr_int As Integer = 0
        Private _ obr_fecha As Date
        Private _ obr_cost_total As Double = 0
        Private _ obr_inc As Double = 0
        Private _ obr_fecinip As Date
        Private _ obr_fecvenp As Date
        Private _ obr_npago As Integer = 0
        Private _ obr_num_periodo As Integer = 0
        Private _ obr_opergob As String = String.Empty
        Private _ obr_fec_ini_proc As Date
        Private _ obr_fec_ini_cob As Date
        Private _ obr_clv_int_obra As Integer = 0
        Private _ obr_prog2 As Integer = 0
        Private _ nomprog As String = String.Empty
        Private _ progdescrip As String = String.Empty
        Private _ obr_clv2 As String = String.Empty
        Private _ obr_status As Integer = 0
        Private _ cestatus As String = String.Empty
        Private _ oid_obra As Integer = 0
        Private _ obr_fec_canc As Date
        Private _ obr_sis As String = String.Empty
        Private _ col_clv2 As String = String.Empty
        Private _ no_contrato As String = String.Empty
        Private _ gastos_admvos As Double = 0
        Private _ obr_fec_pub1 As Date
        Private _ obr_fec_pub2 As Date
        Private _ evid_pub1 As String = String.Empty
        Private _ evid_pub2 As String = String.Empty
        Private _ evid_obra_proc As String = String.Empty
        Private _ evid_termino_obra As String = String.Empty
        Private _ obr_nat As String = String.Empty
        Private _ pid_predio As Integer = 0
        Private _ objectid As String = String.Empty
        Private _ gid_server As Double = 0
        Private _ cup As String = String.Empty
        Private _ feccre_pred As Date
        Private _ fecmod_pred As Date
        Private _ tipo As String = String.Empty
        Private _ tipopredio As Double = 0
        Private _ ctapredial As String = String.Empty
        Private _ ctaimuvi As String = String.Empty
        Private _ observacio As String = String.Empty
        Private _ shape_area As Double = 0
        Private _ shape_len As Double = 0
        Private _ geom_predio As String = String.Empty
        Private _ uso_predio As Integer = 0
        Private _ uso_suelo As String = String.Empty
        Private _ r20 As String = String.Empty
        Private _ nooficial As String = String.Empty
        Private _ sapal As String = String.Empty
        Private _ usrcre_pred As Integer = 0
        Private _ usrmod_pred As Integer = 0
        Private _ num_escritura As String = String.Empty
        Private _ reg_escritura As String = String.Empty
        Private _ folio_escritura As String = String.Empty
        Private _ tomo_escritura As String = String.Empty
        Private _ doc_escritura As String = String.Empty
        Private _ lote As String = String.Empty
        Private _ mzna As String = String.Empty
        Private _ saldo_sin As Double = 0
        Private _ saldo_sin_act As Double = 0
        Private _ pagos As Double = 0
        Private _ recargos As Double = 0
        Private _ clv_inpc_ant As String = String.Empty
        Private _ clv_inpc_actual As String = String.Empty
        Private _ clv_inpc_actual_2 As String = String.Empty
        Private _ factor_act As Double = 0
        Private _ monto_act As Double = 0
        Private _ saldo As Double = 0
        Private _ calle As String = String.Empty
        Private _ colonia As String = String.Empty
        Private _ limite1 As String = String.Empty
        Private _ limite2 As String = String.Empty
        Private _ tramo As String = String.Empty
        Private _ pae As Integer = 0
        Private _ iddet As Integer = 0
        Private _ det_estatus As Integer = 0
        Private _ fec_imp_det As Date
        Private _ fec_ent_det As Date
        Private _ fec_notif_det As Date
        Private _ hora_notif_det As DateTime
        Private _ idministro As Integer = 0
        Private _ musunombre As String = String.Empty
        Private _ tipo_doc As Integer = 0
        Private _ nom_doc As String = String.Empty
        Private _ accion As Integer = 0
        #End Region
#
    
    #Region "Propiedades"
#
    
    Public Property fid() As Integer
        Get
        Return _ fid
            End Get
        Set (ByVal Value As Integer)
         _ fid = Value
            End Set
    End Property
    
    Public Property geom_frente() As String
        Get
        Return _ geom_frente
            End Get
        Set (ByVal Value As String)
         _ geom_frente = Value
            End Set
    End Property
    
    Public Property mts_frente() As Double
        Get
        Return _ mts_frente
            End Get
        Set (ByVal Value As Double)
         _ mts_frente = Value
            End Set
    End Property
    
    Public Property cid() As Integer
        Get
        Return _ cid
            End Get
        Set (ByVal Value As Integer)
         _ cid = Value
            End Set
    End Property
    
    Public Property coopid() As String
        Get
        Return _ coopid
            End Get
        Set (ByVal Value As String)
         _ coopid = Value
            End Set
    End Property
    
    Public Property pid() As Integer
        Get
        Return _ pid
            End Get
        Set (ByVal Value As Integer)
         _ pid = Value
            End Set
    End Property
    
    Public Property oid() As Integer
        Get
        Return _ oid
            End Get
        Set (ByVal Value As Integer)
         _ oid = Value
            End Set
    End Property
    
    Public Property obs_grales() As String
        Get
        Return _ obs_grales
            End Get
        Set (ByVal Value As String)
         _ obs_grales = Value
            End Set
    End Property
    
    Public Property obra_sifidoc() As String
        Get
        Return _ obra_sifidoc
            End Get
        Set (ByVal Value As String)
         _ obra_sifidoc = Value
            End Set
    End Property
    
    Public Property gid() As Integer
        Get
        Return _ gid
            End Get
        Set (ByVal Value As Integer)
         _ gid = Value
            End Set
    End Property
    
    Public Property feccre_frente() As Date
        Get
        Return _ feccre_frente
            End Get
        Set (ByVal Value As Date)
         _ feccre_frente = Value
            End Set
    End Property
    
    Public Property fecmod_frente() As Date
        Get
        Return _ fecmod_frente
            End Get
        Set (ByVal Value As Date)
         _ fecmod_frente = Value
            End Set
    End Property
    
    Public Property usucre_frente() As String
        Get
        Return _ usucre_frente
            End Get
        Set (ByVal Value As String)
         _ usucre_frente = Value
            End Set
    End Property
    
    Public Property usumod_frente() As String
        Get
        Return _ usumod_frente
            End Get
        Set (ByVal Value As String)
         _ usumod_frente = Value
            End Set
    End Property
    
    Public Property prid() As Integer
        Get
        Return _ prid
            End Get
        Set (ByVal Value As Integer)
         _ prid = Value
            End Set
    End Property
    
    Public Property inc() As Double
        Get
        Return _ inc
            End Get
        Set (ByVal Value As Double)
         _ inc = Value
            End Set
    End Property
    
    Public Property did() As Integer
        Get
        Return _ did
            End Get
        Set (ByVal Value As Integer)
         _ did = Value
            End Set
    End Property
    
    Public Property factor_act_pago() As Double
        Get
        Return _ factor_act_pago
            End Get
        Set (ByVal Value As Double)
         _ factor_act_pago = Value
            End Set
    End Property
    
    Public Property obr_clv_int() As Integer
        Get
        Return _ obr_clv_int
            End Get
        Set (ByVal Value As Integer)
         _ obr_clv_int = Value
            End Set
    End Property
    
    Public Property coo_clv2() As Integer
        Get
        Return _ coo_clv2
            End Get
        Set (ByVal Value As Integer)
         _ coo_clv2 = Value
            End Set
    End Property
    
    Public Property activo() As Integer
        Get
        Return _ activo
            End Get
        Set (ByVal Value As Integer)
         _ activo = Value
            End Set
    End Property
    
    Public Property capital() As Double
        Get
        Return _ capital
            End Get
        Set (ByVal Value As Double)
         _ capital = Value
            End Set
    End Property
    
    Public Property midcoop() As Integer
        Get
        Return _ midcoop
            End Get
        Set (ByVal Value As Integer)
         _ midcoop = Value
            End Set
    End Property
    
    Public Property mapellidop() As String
        Get
        Return _ mapellidop
            End Get
        Set (ByVal Value As String)
         _ mapellidop = Value
            End Set
    End Property
    
    Public Property mapellidom() As String
        Get
        Return _ mapellidom
            End Get
        Set (ByVal Value As String)
         _ mapellidom = Value
            End Set
    End Property
    
    Public Property mnombres() As String
        Get
        Return _ mnombres
            End Get
        Set (ByVal Value As String)
         _ mnombres = Value
            End Set
    End Property
    
    Public Property mcallecoop() As String
        Get
        Return _ mcallecoop
            End Get
        Set (ByVal Value As String)
         _ mcallecoop = Value
            End Set
    End Property
    
    Public Property mcolcoop() As String
        Get
        Return _ mcolcoop
            End Get
        Set (ByVal Value As String)
         _ mcolcoop = Value
            End Set
    End Property
    
    Public Property mnooficial_ext() As String
        Get
        Return _ mnooficial_ext
            End Get
        Set (ByVal Value As String)
         _ mnooficial_ext = Value
            End Set
    End Property
    
    Public Property mnooficial_int() As String
        Get
        Return _ mnooficial_int
            End Get
        Set (ByVal Value As String)
         _ mnooficial_int = Value
            End Set
    End Property
    
    Public Property mtelcoop() As String
        Get
        Return _ mtelcoop
            End Get
        Set (ByVal Value As String)
         _ mtelcoop = Value
            End Set
    End Property
    
    Public Property mnomficha() As String
        Get
        Return _ mnomficha
            End Get
        Set (ByVal Value As String)
         _ mnomficha = Value
            End Set
    End Property
    
    Public Property mestado() As String
        Get
        Return _ mestado
            End Get
        Set (ByVal Value As String)
         _ mestado = Value
            End Set
    End Property
    
    Public Property mpais() As String
        Get
        Return _ mpais
            End Get
        Set (ByVal Value As String)
         _ mpais = Value
            End Set
    End Property
    
    Public Property mcorreo() As String
        Get
        Return _ mcorreo
            End Get
        Set (ByVal Value As String)
         _ mcorreo = Value
            End Set
    End Property
    
    Public Property usrcre_coop() As String
        Get
        Return _ usrcre_coop
            End Get
        Set (ByVal Value As String)
         _ usrcre_coop = Value
            End Set
    End Property
    
    Public Property feccre_coop() As Date
        Get
        Return _ feccre_coop
            End Get
        Set (ByVal Value As Date)
         _ feccre_coop = Value
            End Set
    End Property
    
    Public Property usrmod_coop() As String
        Get
        Return _ usrmod_coop
            End Get
        Set (ByVal Value As String)
         _ usrmod_coop = Value
            End Set
    End Property
    
    Public Property fecmod_coop() As Date
        Get
        Return _ fecmod_coop
            End Get
        Set (ByVal Value As Date)
         _ fecmod_coop = Value
            End Set
    End Property
    
    Public Property mcurp() As String
        Get
        Return _ mcurp
            End Get
        Set (ByVal Value As String)
         _ mcurp = Value
            End Set
    End Property
    
    Public Property mrelacionpredio() As Integer
        Get
        Return _ mrelacionpredio
            End Get
        Set (ByVal Value As Integer)
         _ mrelacionpredio = Value
            End Set
    End Property
    
    Public Property ine() As String
        Get
        Return _ ine
            End Get
        Set (ByVal Value As String)
         _ ine = Value
            End Set
    End Property
    
    Public Property doc_identific() As String
        Get
        Return _ doc_identific
            End Get
        Set (ByVal Value As String)
         _ doc_identific = Value
            End Set
    End Property
    
    Public Property obr_clv() As String
        Get
        Return _ obr_clv
            End Get
        Set (ByVal Value As String)
         _ obr_clv = Value
            End Set
    End Property
    
    Public Property obr_mts() As Double
        Get
        Return _ obr_mts
            End Get
        Set (ByVal Value As Double)
         _ obr_mts = Value
            End Set
    End Property
    
    Public Property obr_cost() As Double
        Get
        Return _ obr_cost
            End Get
        Set (ByVal Value As Double)
         _ obr_cost = Value
            End Set
    End Property
    
    Public Property obr_int() As Integer
        Get
        Return _ obr_int
            End Get
        Set (ByVal Value As Integer)
         _ obr_int = Value
            End Set
    End Property
    
    Public Property obr_fecha() As Date
        Get
        Return _ obr_fecha
            End Get
        Set (ByVal Value As Date)
         _ obr_fecha = Value
            End Set
    End Property
    
    Public Property obr_cost_total() As Double
        Get
        Return _ obr_cost_total
            End Get
        Set (ByVal Value As Double)
         _ obr_cost_total = Value
            End Set
    End Property
    
    Public Property obr_inc() As Double
        Get
        Return _ obr_inc
            End Get
        Set (ByVal Value As Double)
         _ obr_inc = Value
            End Set
    End Property
    
    Public Property obr_fecinip() As Date
        Get
        Return _ obr_fecinip
            End Get
        Set (ByVal Value As Date)
         _ obr_fecinip = Value
            End Set
    End Property
    
    Public Property obr_fecvenp() As Date
        Get
        Return _ obr_fecvenp
            End Get
        Set (ByVal Value As Date)
         _ obr_fecvenp = Value
            End Set
    End Property
    
    Public Property obr_npago() As Integer
        Get
        Return _ obr_npago
            End Get
        Set (ByVal Value As Integer)
         _ obr_npago = Value
            End Set
    End Property
    
    Public Property obr_num_periodo() As Integer
        Get
        Return _ obr_num_periodo
            End Get
        Set (ByVal Value As Integer)
         _ obr_num_periodo = Value
            End Set
    End Property
    
    Public Property obr_opergob() As String
        Get
        Return _ obr_opergob
            End Get
        Set (ByVal Value As String)
         _ obr_opergob = Value
            End Set
    End Property
    
    Public Property obr_fec_ini_proc() As Date
        Get
        Return _ obr_fec_ini_proc
            End Get
        Set (ByVal Value As Date)
         _ obr_fec_ini_proc = Value
            End Set
    End Property
    
    Public Property obr_fec_ini_cob() As Date
        Get
        Return _ obr_fec_ini_cob
            End Get
        Set (ByVal Value As Date)
         _ obr_fec_ini_cob = Value
            End Set
    End Property
    
    Public Property obr_clv_int_obra() As Integer
        Get
        Return _ obr_clv_int_obra
            End Get
        Set (ByVal Value As Integer)
         _ obr_clv_int_obra = Value
            End Set
    End Property
    
    Public Property obr_prog2() As Integer
        Get
        Return _ obr_prog2
            End Get
        Set (ByVal Value As Integer)
         _ obr_prog2 = Value
            End Set
    End Property
    
    Public Property nomprog() As String
        Get
        Return _ nomprog
            End Get
        Set (ByVal Value As String)
         _ nomprog = Value
            End Set
    End Property
    
    Public Property progdescrip() As String
        Get
        Return _ progdescrip
            End Get
        Set (ByVal Value As String)
         _ progdescrip = Value
            End Set
    End Property
    
    Public Property obr_clv2() As String
        Get
        Return _ obr_clv2
            End Get
        Set (ByVal Value As String)
         _ obr_clv2 = Value
            End Set
    End Property
    
    Public Property obr_status() As Integer
        Get
        Return _ obr_status
            End Get
        Set (ByVal Value As Integer)
         _ obr_status = Value
            End Set
    End Property
    
    Public Property cestatus() As String
        Get
        Return _ cestatus
            End Get
        Set (ByVal Value As String)
         _ cestatus = Value
            End Set
    End Property
    
    Public Property oid_obra() As Integer
        Get
        Return _ oid_obra
            End Get
        Set (ByVal Value As Integer)
         _ oid_obra = Value
            End Set
    End Property
    
    Public Property obr_fec_canc() As Date
        Get
        Return _ obr_fec_canc
            End Get
        Set (ByVal Value As Date)
         _ obr_fec_canc = Value
            End Set
    End Property
    
    Public Property obr_sis() As String
        Get
        Return _ obr_sis
            End Get
        Set (ByVal Value As String)
         _ obr_sis = Value
            End Set
    End Property
    
    Public Property col_clv2() As String
        Get
        Return _ col_clv2
            End Get
        Set (ByVal Value As String)
         _ col_clv2 = Value
            End Set
    End Property
    
    Public Property no_contrato() As String
        Get
        Return _ no_contrato
            End Get
        Set (ByVal Value As String)
         _ no_contrato = Value
            End Set
    End Property
    
    Public Property gastos_admvos() As Double
        Get
        Return _ gastos_admvos
            End Get
        Set (ByVal Value As Double)
         _ gastos_admvos = Value
            End Set
    End Property
    
    Public Property obr_fec_pub1() As Date
        Get
        Return _ obr_fec_pub1
            End Get
        Set (ByVal Value As Date)
         _ obr_fec_pub1 = Value
            End Set
    End Property
    
    Public Property obr_fec_pub2() As Date
        Get
        Return _ obr_fec_pub2
            End Get
        Set (ByVal Value As Date)
         _ obr_fec_pub2 = Value
            End Set
    End Property
    
    Public Property evid_pub1() As String
        Get
        Return _ evid_pub1
            End Get
        Set (ByVal Value As String)
         _ evid_pub1 = Value
            End Set
    End Property
    
    Public Property evid_pub2() As String
        Get
        Return _ evid_pub2
            End Get
        Set (ByVal Value As String)
         _ evid_pub2 = Value
            End Set
    End Property
    
    Public Property evid_obra_proc() As String
        Get
        Return _ evid_obra_proc
            End Get
        Set (ByVal Value As String)
         _ evid_obra_proc = Value
            End Set
    End Property
    
    Public Property evid_termino_obra() As String
        Get
        Return _ evid_termino_obra
            End Get
        Set (ByVal Value As String)
         _ evid_termino_obra = Value
            End Set
    End Property
    
    Public Property obr_nat() As String
        Get
        Return _ obr_nat
            End Get
        Set (ByVal Value As String)
         _ obr_nat = Value
            End Set
    End Property
    
    Public Property pid_predio() As Integer
        Get
        Return _ pid_predio
            End Get
        Set (ByVal Value As Integer)
         _ pid_predio = Value
            End Set
    End Property
    
    Public Property objectid() As String
        Get
        Return _ objectid
            End Get
        Set (ByVal Value As String)
         _ objectid = Value
            End Set
    End Property
    
    Public Property gid_server() As Double
        Get
        Return _ gid_server
            End Get
        Set (ByVal Value As Double)
         _ gid_server = Value
            End Set
    End Property
    
    Public Property cup() As String
        Get
        Return _ cup
            End Get
        Set (ByVal Value As String)
         _ cup = Value
            End Set
    End Property
    
    Public Property feccre_pred() As Date
        Get
        Return _ feccre_pred
            End Get
        Set (ByVal Value As Date)
         _ feccre_pred = Value
            End Set
    End Property
    
    Public Property fecmod_pred() As Date
        Get
        Return _ fecmod_pred
            End Get
        Set (ByVal Value As Date)
         _ fecmod_pred = Value
            End Set
    End Property
    
    Public Property tipo() As String
        Get
        Return _ tipo
            End Get
        Set (ByVal Value As String)
         _ tipo = Value
            End Set
    End Property
    
    Public Property tipopredio() As Double
        Get
        Return _ tipopredio
            End Get
        Set (ByVal Value As Double)
         _ tipopredio = Value
            End Set
    End Property
    
    Public Property ctapredial() As String
        Get
        Return _ ctapredial
            End Get
        Set (ByVal Value As String)
         _ ctapredial = Value
            End Set
    End Property
    
    Public Property ctaimuvi() As String
        Get
        Return _ ctaimuvi
            End Get
        Set (ByVal Value As String)
         _ ctaimuvi = Value
            End Set
    End Property
    
    Public Property observacio() As String
        Get
        Return _ observacio
            End Get
        Set (ByVal Value As String)
         _ observacio = Value
            End Set
    End Property
    
    Public Property shape_area() As Double
        Get
        Return _ shape_area
            End Get
        Set (ByVal Value As Double)
         _ shape_area = Value
            End Set
    End Property
    
    Public Property shape_len() As Double
        Get
        Return _ shape_len
            End Get
        Set (ByVal Value As Double)
         _ shape_len = Value
            End Set
    End Property
    
    Public Property geom_predio() As String
        Get
        Return _ geom_predio
            End Get
        Set (ByVal Value As String)
         _ geom_predio = Value
            End Set
    End Property
    
    Public Property uso_predio() As Integer
        Get
        Return _ uso_predio
            End Get
        Set (ByVal Value As Integer)
         _ uso_predio = Value
            End Set
    End Property
    
    Public Property uso_suelo() As String
        Get
        Return _ uso_suelo
            End Get
        Set (ByVal Value As String)
         _ uso_suelo = Value
            End Set
    End Property
    
    Public Property r20() As String
        Get
        Return _ r20
            End Get
        Set (ByVal Value As String)
         _ r20 = Value
            End Set
    End Property
    
    Public Property nooficial() As String
        Get
        Return _ nooficial
            End Get
        Set (ByVal Value As String)
         _ nooficial = Value
            End Set
    End Property
    
    Public Property sapal() As String
        Get
        Return _ sapal
            End Get
        Set (ByVal Value As String)
         _ sapal = Value
            End Set
    End Property
    
    Public Property usrcre_pred() As Integer
        Get
        Return _ usrcre_pred
            End Get
        Set (ByVal Value As Integer)
         _ usrcre_pred = Value
            End Set
    End Property
    
    Public Property usrmod_pred() As Integer
        Get
        Return _ usrmod_pred
            End Get
        Set (ByVal Value As Integer)
         _ usrmod_pred = Value
            End Set
    End Property
    
    Public Property num_escritura() As String
        Get
        Return _ num_escritura
            End Get
        Set (ByVal Value As String)
         _ num_escritura = Value
            End Set
    End Property
    
    Public Property reg_escritura() As String
        Get
        Return _ reg_escritura
            End Get
        Set (ByVal Value As String)
         _ reg_escritura = Value
            End Set
    End Property
    
    Public Property folio_escritura() As String
        Get
        Return _ folio_escritura
            End Get
        Set (ByVal Value As String)
         _ folio_escritura = Value
            End Set
    End Property
    
    Public Property tomo_escritura() As String
        Get
        Return _ tomo_escritura
            End Get
        Set (ByVal Value As String)
         _ tomo_escritura = Value
            End Set
    End Property
    
    Public Property doc_escritura() As String
        Get
        Return _ doc_escritura
            End Get
        Set (ByVal Value As String)
         _ doc_escritura = Value
            End Set
    End Property
    
    Public Property lote() As String
        Get
        Return _ lote
            End Get
        Set (ByVal Value As String)
         _ lote = Value
            End Set
    End Property
    
    Public Property mzna() As String
        Get
        Return _ mzna
            End Get
        Set (ByVal Value As String)
         _ mzna = Value
            End Set
    End Property
    
    Public Property saldo_sin() As Double
        Get
        Return _ saldo_sin
            End Get
        Set (ByVal Value As Double)
         _ saldo_sin = Value
            End Set
    End Property
    
    Public Property saldo_sin_act() As Double
        Get
        Return _ saldo_sin_act
            End Get
        Set (ByVal Value As Double)
         _ saldo_sin_act = Value
            End Set
    End Property
    
    Public Property pagos() As Double
        Get
        Return _ pagos
            End Get
        Set (ByVal Value As Double)
         _ pagos = Value
            End Set
    End Property
    
    Public Property recargos() As Double
        Get
        Return _ recargos
            End Get
        Set (ByVal Value As Double)
         _ recargos = Value
            End Set
    End Property
    
    Public Property clv_inpc_ant() As String
        Get
        Return _ clv_inpc_ant
            End Get
        Set (ByVal Value As String)
         _ clv_inpc_ant = Value
            End Set
    End Property
    
    Public Property clv_inpc_actual() As String
        Get
        Return _ clv_inpc_actual
            End Get
        Set (ByVal Value As String)
         _ clv_inpc_actual = Value
            End Set
    End Property
    
    Public Property clv_inpc_actual_2() As String
        Get
        Return _ clv_inpc_actual_2
            End Get
        Set (ByVal Value As String)
         _ clv_inpc_actual_2 = Value
            End Set
    End Property
    
    Public Property factor_act() As Double
        Get
        Return _ factor_act
            End Get
        Set (ByVal Value As Double)
         _ factor_act = Value
            End Set
    End Property
    
    Public Property monto_act() As Double
        Get
        Return _ monto_act
            End Get
        Set (ByVal Value As Double)
         _ monto_act = Value
            End Set
    End Property
    
    Public Property saldo() As Double
        
        Get
        Return _ saldo
            End Get
        Set (ByVal Value As Double)
         _ saldo = Value
            End Set
    End Property
    
    Public Property calle() As String
        Get
        Return _ calle
            End Get
        Set (ByVal Value As String)
         _ calle = Value
            End Set
    End Property
    
    Public Property colonia() As String
        Get
        Return _ colonia
            End Get
        Set (ByVal Value As String)
         _ colonia = Value
            End Set
    End Property
    
    Public Property limite1() As String
        Get
        Return _ limite1
            End Get
        Set (ByVal Value As String)
         _ limite1 = Value
            End Set
    End Property
    
    Public Property limite2() As String
        Get
        Return _ limite2
            End Get
        Set (ByVal Value As String)
         _ limite2 = Value
            End Set
    End Property
    
    Public Property tramo() As String
        Get
        Return _ tramo
            End Get
        Set (ByVal Value As String)
         _ tramo = Value
            End Set
    End Property
    
    Public Property pae() As Integer
        Get
        Return _ pae
            End Get
        Set (ByVal Value As Integer)
         _ pae = Value
            End Set
    End Property
    
    Public Property iddet() As Integer
        Get
        Return _ iddet
            End Get
        Set (ByVal Value As Integer)
         _ iddet = Value
            End Set
    End Property
    
    Public Property det_estatus() As Integer
        Get
        Return _ det_estatus
            End Get
        Set (ByVal Value As Integer)
         _ det_estatus = Value
            End Set
    End Property
    
    Public Property fec_imp_det() As Date
        Get
        Return _ fec_imp_det
            End Get
        Set (ByVal Value As Date)
         _ fec_imp_det = Value
            End Set
    End Property
    
    Public Property fec_ent_det() As Date
        Get
        Return _ fec_ent_det
            End Get
        Set (ByVal Value As Date)
         _ fec_ent_det = Value
            End Set
    End Property
    
    Public Property fec_notif_det() As Date
        Get
        Return _ fec_notif_det
            End Get
        Set (ByVal Value As Date)
         _ fec_notif_det = Value
            End Set
    End Property
    
    Public Property hora_notif_det() As DateTime
        Get
        Return _ hora_notif_det
            End Get
        Set (ByVal Value As DateTime)
         _ hora_notif_det = Value
            End Set
    End Property
    
    Public Property idministro() As Integer
        Get
        Return _ idministro
            End Get
        Set (ByVal Value As Integer)
         _ idministro = Value
            End Set
    End Property
    
    Public Property musunombre() As String
        Get
        Return _ musunombre
            End Get
        Set (ByVal Value As String)
         _ musunombre = Value
            End Set
    End Property
    
    Public Property tipo_doc() As Integer
        Get
        Return _ tipo_doc
            End Get
        Set (ByVal Value As Integer)
         _ tipo_doc = Value
            End Set
    End Property
    
    Public Property nom_doc() As String
        Get
        Return _ nom_doc
            End Get
        Set (ByVal Value As String)
         _ nom_doc = Value
            End Set
    End Property
    
    Public Property accion() As Integer
        Get
        Return _ accion
            End Get
        Set (ByVal Value As Integer)
         _ accion = Value
            End Set
    End Property
    
    
    #End Region
# End Class