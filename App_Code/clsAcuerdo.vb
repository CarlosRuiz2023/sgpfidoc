Public Class clsAcuerdo

#Region "variables privadas"
    Private _idcomite As Integer = 0
    Private _idacuerdo As Integer = 0
    Private _num_acuerdo As Integer = 0
    Private _folio_acuerdo As String = String.Empty
    Private _num_acuerdo_romano As String = String.Empty
    Private _descrip_acuerdo As String = String.Empty
    Private _fec_cre As Date
    Private _fec_mod As Date
    Private _usu_cre As Integer = 0
    Private _usu_mod As Integer = 0
    Private _cestatus As Integer = 0
    Private _acuerdo_terminado As Integer = 0
    Private _acuerdo_terminado_txt As String = String.Empty
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
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
    Public Property num_acuerdo() As Integer
        Get
            Return _num_acuerdo
        End Get
        Set(ByVal Value As Integer)
            _num_acuerdo = Value
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
    Public Property num_acuerdo_romano() As String
        Get
            Return _num_acuerdo_romano
        End Get
        Set(ByVal Value As String)
            _num_acuerdo_romano = Value
        End Set
    End Property

    Public Property descrip_acuerdo() As String
        Get
            Return _descrip_acuerdo
        End Get
        Set(ByVal Value As String)
            _descrip_acuerdo = Value
        End Set
    End Property
    Public Property usu_cre() As Integer
        Get
            Return _usu_cre
        End Get
        Set(ByVal Value As Integer)
            _usu_cre = Value
        End Set
    End Property
    Public Property usu_mod() As Integer
        Get
            Return _usu_mod
        End Get
        Set(ByVal Value As Integer)
            _usu_mod = Value
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
    Public Property fec_cre() As Date
        Get
            Return _fec_cre
        End Get
        Set(ByVal Value As Date)
            _fec_cre = Value
        End Set
    End Property
    Public Property cestatus() As Integer
        Get
            Return _cestatus
        End Get
        Set(ByVal Value As Integer)
            _cestatus = Value
        End Set
    End Property
    Public Property acuerdo_terminado() As Integer
        Get
            Return _acuerdo_terminado
        End Get
        Set(ByVal Value As Integer)
            _acuerdo_terminado = Value
        End Set
    End Property
    Public Property acuerdo_terminado_txt() As String
        Get
            Return _acuerdo_terminado_txt
        End Get
        Set(ByVal Value As String)
            _acuerdo_terminado_txt = Value
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
