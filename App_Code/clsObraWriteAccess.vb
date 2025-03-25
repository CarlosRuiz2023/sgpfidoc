Public Class clsObraWriteAccess
#Region "variables privadas"
    Private _obr_clv As String = String.Empty
    Private _obr_call As String = String.Empty
    Private _obr_col As String = String.Empty
    Private _obr_mts As Double = 0
    Private _obr_cost As Double = 0
    Private _obr_stat As String = String.Empty
    Private _obr_est_act As String = String.Empty
    Private _obr_int As Integer = 0
    Private _obr_tramo As String = String.Empty
    Private _obr_fecha As String = String.Empty
    Private _obr_cost_total As Double = 0
    Private _obr_inc As Double = 0
    Private _obr_contab As String = String.Empty
    Private _obr_sis As String = String.Empty
    Private _col_nom As String = String.Empty
    Private _obr_digito As String = String.Empty
    Private _obr_programa As String = String.Empty
    Private _obr_cuentac As String = String.Empty
    Private _obr_digagr As String = String.Empty
    Private _obr_fecinip As String = String.Empty
    Private _obr_fecvenp As String = String.Empty
    Private _obr_npago As Integer = 0
    Private _obr_numera As String = String.Empty
    Private _obr_opergob As String = String.Empty
    Private _obr_usuario As String = String.Empty
    Private _obr_feciniproc As String = String.Empty
    Private _obr_fecinicob As String = String.Empty
    Private _accion As String = String.Empty
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property obr_clv() As String
        Get
            Return _obr_clv
        End Get
        Set(ByVal Value As String)
            _obr_clv = Value
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

    Public Property obr_stat() As String
        Get
            Return _obr_stat
        End Get
        Set(ByVal Value As String)
            _obr_stat = Value
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

    Public Property obr_tramo() As String
        Get
            Return _obr_tramo
        End Get
        Set(ByVal Value As String)
            _obr_tramo = Value
        End Set
    End Property

    Public Property obr_fecha() As String
        Get
            Return _obr_fecha
        End Get
        Set(ByVal Value As String)
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
    Public Property obr_contab() As String
        Get
            Return _obr_contab
        End Get
        Set(ByVal Value As String)
            _obr_contab = Value
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
    Public Property col_nom() As String
        Get
            Return _col_nom
        End Get
        Set(ByVal Value As String)
            _col_nom = Value
        End Set
    End Property
    Public Property obr_digito() As String
        Get
            Return _obr_digito
        End Get
        Set(ByVal Value As String)
            _obr_digito = Value
        End Set
    End Property
    Public Property obr_programa() As String
        Get
            Return _obr_programa
        End Get
        Set(ByVal Value As String)
            _obr_programa = Value
        End Set
    End Property
    Public Property obr_cuentac() As String
        Get
            Return _obr_cuentac
        End Get
        Set(ByVal Value As String)
            _obr_cuentac = Value
        End Set
    End Property
    Public Property obr_digagr() As String
        Get
            Return _obr_digagr
        End Get
        Set(ByVal Value As String)
            _obr_digagr = Value
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

    Public Property obr_usuario() As String
        Get
            Return _obr_usuario
        End Get
        Set(ByVal Value As String)
            _obr_usuario = Value
        End Set
    End Property

    Public Property obr_est_act() As String
        Get
            Return _obr_est_act
        End Get
        Set(ByVal Value As String)
            _obr_est_act = Value
        End Set
    End Property

    Public Property obr_feciniproc() As String
        Get
            Return _obr_feciniproc
        End Get
        Set(ByVal Value As String)
            _obr_feciniproc = Value
        End Set
    End Property

    Public Property obr_fecinicob() As String
        Get
            Return _obr_fecinicob
        End Get
        Set(ByVal Value As String)
            _obr_fecinicob = Value
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

    Public Property Mensaje() As String
        Get
            Return strMensaje
        End Get
        Set(ByVal Value As String)
            strMensaje = Value
        End Set
    End Property



#End Region

#Region "Metodos"




#End Region

End Class