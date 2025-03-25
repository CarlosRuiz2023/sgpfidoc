Public Class clsObra
#Region "variables privadas"
    Private _oid As Integer = 0
    Private _geom As String = String.Empty
    Private _idsol As Integer = 0
    Private _tramo As String = String.Empty
    Private _sector As Integer = 0
    Private _subsector As Integer = 0
    Private _cvecalle As Integer = 0
    Private _idpoligono As Integer = 0
    Private _calle As String = String.Empty
    Private _colonia As String = String.Empty
    Private _id_implan As Integer = 0
    Private _usrmod As Integer = 0
    Private _fec_mod As Date
    Private _obr_fec_pub1 As Date
    Private _evid_pub1 As String = String.Empty
    Private _obr_fec_pub2 As Date
    Private _evid_pub2 As String = String.Empty
    Private _col_clv2 As Integer = 0
    Private _limite1 As String = String.Empty
    Private _limite2 As String = String.Empty
    Private _col_nom As String = String.Empty
    Private _cestatus As String = String.Empty
    Private _nomprog As String = String.Empty
    Private _progmun As Integer = 0
    Private _progcoop As Integer = 0
    Private _descrip_tipo_obr As String = String.Empty
    Private _obr_clv As String = String.Empty
    Private _obr_mts As Double = 0
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
    Private _obr_idtipo_recurso As Integer
    Private _obr_descrip_tipo_recurso As String
    Private _obr_fec_ini_cob As Date
    Private _obr_clv_int As Integer = 0
    Private _obr_prog2 As Integer = 0
    Private _obr_clv2 As String = String.Empty
    Private _obr_sis As String = String.Empty
    Private _obr_status As Integer = 0
    Private _obr_fec_can As Date
    Private _no_contrato As String = String.Empty
    Private _gastos_admvos As Double = 0
    Private _evid_obra_proc As String = String.Empty
    Private _evid_termino_obra As String = String.Empty
    Private _obr_nat As String = String.Empty
    Private _obr_num_coops As Integer = 0
    Private _obr_num_coops_s As Integer = 0
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

    Public Property geom() As String
        Get
            Return _geom
        End Get
        Set(ByVal Value As String)
            _geom = Value
        End Set
    End Property

    Public Property idsol() As Integer
        Get
            Return _idsol
        End Get
        Set(ByVal Value As Integer)
            _idsol = Value
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

    Public Property idpoligono() As Integer
        Get
            Return _idpoligono
        End Get
        Set(ByVal Value As Integer)
            _idpoligono = Value
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

    Public Property id_implan() As Integer
        Get
            Return _id_implan
        End Get
        Set(ByVal Value As Integer)
            _id_implan = Value
        End Set
    End Property

    Public Property usrmod() As Integer
        Get
            Return _usrmod
        End Get
        Set(ByVal Value As Integer)
            _usrmod = Value
        End Set
    End Property

    Public Property fec_mod() As Date
        Get
            Return _fec_mod
        End Get
        Set(ByVal Value As Date)
            _fec_mod = Value
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

    Public Property evid_pub1() As String
        Get
            Return _evid_pub1
        End Get
        Set(ByVal Value As String)
            _evid_pub1 = Value
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

    Public Property evid_pub2() As String
        Get
            Return _evid_pub2
        End Get
        Set(ByVal Value As String)
            _evid_pub2 = Value
        End Set
    End Property

    Public Property col_clv2() As Integer
        Get
            Return _col_clv2
        End Get
        Set(ByVal Value As Integer)
            _col_clv2 = Value
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
    Public Property col_nom() As String
        Get
            Return _col_nom
        End Get
        Set(ByVal Value As String)
            _col_nom = Value
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

    Public Property progcoop() As Integer
        Get
            Return _progcoop
        End Get
        Set(ByVal Value As Integer)
            _progcoop = Value
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

    Public Property obr_clv() As String
        Get
            Return _obr_clv
        End Get
        Set(ByVal Value As String)
            _obr_clv = Value
        End Set
    End Property

    Public Property obr_mts() As Double
        Get
            Return _obr_mts
        End Get
        Set(ByVal Value As Double)
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

    Public Property obr_idtipo_recurso() As Integer
        Get
            Return _obr_idtipo_recurso
        End Get
        Set(ByVal Value As Integer)
            _obr_idtipo_recurso = Value
        End Set
    End Property
    Public Property obr_descrip_tipo_recurso() As String
        Get
            Return _obr_descrip_tipo_recurso
        End Get
        Set(ByVal Value As String)
            _obr_descrip_tipo_recurso = Value
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

    Public Property obr_clv_int() As Integer
        Get
            Return _obr_clv_int
        End Get
        Set(ByVal Value As Integer)
            _obr_clv_int = Value
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

    Public Property obr_clv2() As String
        Get
            Return _obr_clv2
        End Get
        Set(ByVal Value As String)
            _obr_clv2 = Value
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

    Public Property obr_status() As Integer
        Get
            Return _obr_status
        End Get
        Set(ByVal Value As Integer)
            _obr_status = Value
        End Set
    End Property
    Public Property obr_fec_can() As Date
        Get
            Return _obr_fec_can
        End Get
        Set(ByVal Value As Date)
            _obr_fec_can = Value
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
    Public Property obr_num_coops() As Integer
        Get
            Return _obr_num_coops
        End Get
        Set(ByVal Value As Integer)
            _obr_num_coops = Value
        End Set
    End Property
    Public Property obr_num_coops_s() As Integer
        Get
            Return _obr_num_coops_s
        End Get
        Set(ByVal Value As Integer)
            _obr_num_coops_s = Value
        End Set
    End Property

#End Region

#Region "Metodos"




#End Region

End Class

