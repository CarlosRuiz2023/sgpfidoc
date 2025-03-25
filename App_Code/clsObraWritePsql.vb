Public Class clsObraWritePsql
#Region "variables privadas"
    Private _obr_clv_int As Integer = 0
    Private _obr_clv As String = String.Empty
    Private _obr_clv2 As String = String.Empty
    Private _obr_mts As Double = 0
    Private _obr_cost As Double = 0
    Private _obr_tipo As Integer = 0
    Private _obr_fecha As Date
    Private _obr_cost_total As Double = 0
    Private _obr_inc As Double = 0
    Private _obr_fecinip As Date
    Private _obr_fecvencp As Date
    Private _obr_npago As Double = 0
    Private _obr_numera As String = String.Empty
    Private _obr_opergob As String = String.Empty
    Private _obr_fec_ini_proc As Date
    Private _id_tipo_recurso As Integer
    Private _obr_fec_ini_cob As Date
    Private _col_clv2 As String = String.Empty
    Private _obr_prog2 As Integer = 0
    Private _obr_status As Integer = 0
    Private _obr_oid As Integer = 0
    Private _obr_fec_canc As Date
    Private _obr_sis As String = String.Empty
    Private _no_contrato As String = String.Empty
    Private _gastos_admvos As Double = 0
    Private _obr_fec_pub1 As Date
    Private _obr_fec_pub2 As Date
    Private _evid_pub1 As String = String.Empty
    Private _evid_pub2 As String = String.Empty
    Private _evid_obra_proc As String = String.Empty
    Private _evid_termino_obra As String = String.Empty
    Private _obr_nat As String = String.Empty
    Private _idusu As Integer = 0
    Private _accion As Integer = 0
    Private strMensaje As String = String.Empty





    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
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
    Public Property obr_clv2() As String
        Get
            Return _obr_clv2
        End Get
        Set(ByVal Value As String)
            _obr_clv2 = Value
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
    Public Property obr_tipo() As Integer
        Get
            Return _obr_tipo
        End Get
        Set(ByVal Value As Integer)
            _obr_tipo = Value
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


    Public Property obr_sis() As String
        Get
            Return _obr_sis
        End Get
        Set(ByVal Value As String)
            _obr_sis = Value
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

    Public Property obr_fecvencp() As Date
        Get
            Return _obr_fecvencp
        End Get

        Set(ByVal Value As Date)
            _obr_fecvencp = Value
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
    Public Property obr_numera() As String
        Get
            Return _obr_numera
        End Get
        Set(ByVal Value As String)
            _obr_numera = Value
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

    Public Property obr_oid() As Integer
        Get
            Return _obr_oid
        End Get
        Set(ByVal Value As Integer)
            _obr_oid = Value
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

    Public Property id_tipo_recurso() As Integer
        Get
            Return _id_tipo_recurso
        End Get
        Set(ByVal Value As Integer)
            _id_tipo_recurso = Value
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
    Public Property obr_fec_canc() As Date
        Get
            Return _obr_fec_canc
        End Get
        Set(ByVal Value As Date)
            _obr_fec_canc = Value
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


    Public Property obr_prog2() As Integer
        Get
            Return _obr_prog2
        End Get
        Set(ByVal Value As Integer)
            _obr_prog2 = Value
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
        Set(ByVal Value As string)
            _evid_pub1 = Value
        End Set
    End Property
    Public Property evid_pub2() As String
        Get
            Return _evid_pub2
        End Get
        Set(ByVal Value As string)
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
        Set(ByVal Value As string)
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

    Public Property accion() As Integer
        Get
            Return _accion
        End Get
        Set(ByVal Value As Integer)
            _accion = Value
        End Set
    End Property

    Public Property idusu() As Integer
        Get
            Return _idusu
        End Get
        Set(ByVal Value As Integer)
            _idusu = Value
        End Set
    End Property


    Public Property Mensaje() As String
        Get
            Return strMensaje
        End Get
        Set(ByVal Value As String)
            strMensaje = Value
        End Set
    End Property

#End Region


End Class
