Public Class clsContratista
#Region "variables privadas"
    Private _idContratista As Integer = 0
    Private _nom_cont As String = String.Empty
    Private _razonsoc_cont As String = String.Empty
    Private _rfc_cont As String = String.Empty
    Private _num_prov_cont As String = String.Empty
    Private _reg_pub_cont As String = String.Empty
    Private _repres_legal_cont As String = String.Empty
    Private _calle_cont As String = String.Empty
    Private _colonia_cont As String = String.Empty
    Private _ciudad_cont As String = String.Empty
    Private _estado_cont As String = String.Empty
    Private _tel1_cont As String = String.Empty
    Private _tel2_cont As String = String.Empty
    Private _email As String = String.Empty
    Private _cp_cont As String = String.Empty
    Private _no_oficial_cont As String = String.Empty
    Private _usu_cre As Integer
    Private _usu_mod As Integer
    Private _fec_cre As Date
    Private _fec_mod As Date
    Private _cestatus As Integer = 0
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property idContratista() As Integer
        Get
            Return _idContratista
        End Get
        Set(ByVal Value As Integer)
            _idContratista = Value
        End Set
    End Property
    Public Property nom_cont() As String
        Get
            Return _nom_cont
        End Get
        Set(ByVal Value As String)
            _nom_cont = Value
        End Set
    End Property
    Public Property razonsoc_cont() As String
        Get
            Return _razonsoc_cont
        End Get
        Set(ByVal Value As String)
            _razonsoc_cont = Value
        End Set
    End Property

    Public Property rfc_cont() As String
        Get
            Return _rfc_cont
        End Get
        Set(ByVal Value As String)
            _rfc_cont = Value
        End Set
    End Property

    Public Property num_prov_cont() As String
        Get
            Return _num_prov_cont
        End Get
        Set(ByVal Value As String)
            _num_prov_cont = Value
        End Set
    End Property
    Public Property reg_pub_cont() As String
        Get
            Return _reg_pub_cont
        End Get
        Set(ByVal Value As String)
            _reg_pub_cont = Value
        End Set
    End Property
    Public Property repres_legal_cont() As String
        Get
            Return _repres_legal_cont
        End Get
        Set(ByVal Value As String)
            _repres_legal_cont = Value
        End Set
    End Property
    Public Property calle_cont() As String
        Get
            Return _calle_cont
        End Get
        Set(ByVal Value As String)
            _calle_cont = Value
        End Set
    End Property
    Public Property colonia_cont() As String
        Get
            Return _colonia_cont
        End Get
        Set(ByVal Value As String)
            _colonia_cont = Value
        End Set
    End Property
    Public Property ciudad_cont() As String
        Get
            Return _ciudad_cont
        End Get
        Set(ByVal Value As String)
            _ciudad_cont = Value
        End Set
    End Property
    Public Property estado_cont() As String
        Get
            Return _estado_cont
        End Get
        Set(ByVal Value As String)
            _estado_cont = Value
        End Set
    End Property
    Public Property tel1_cont() As String
        Get
            Return _tel1_cont
        End Get
        Set(ByVal Value As String)
            _tel1_cont = Value
        End Set
    End Property
    Public Property tel2_cont() As String
        Get
            Return _tel2_cont
        End Get
        Set(ByVal Value As String)
            _tel2_cont = Value
        End Set
    End Property
    Public Property email() As String
        Get
            Return _email
        End Get
        Set(ByVal Value As String)
            _email = Value
        End Set
    End Property
    Public Property cp_cont() As String
        Get
            Return _cp_cont
        End Get
        Set(ByVal Value As String)
            _cp_cont = Value
        End Set
    End Property
    Public Property no_oficial_cont() As String
        Get
            Return _no_oficial_cont
        End Get
        Set(ByVal Value As String)
            _no_oficial_cont = Value
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
    Public Property fec_cre() As Date
        Get
            Return _fec_cre
        End Get
        Set(ByVal Value As Date)
            _fec_cre = Value
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

    Public Property accion() As Integer
        Get
            Return _accion
        End Get
        Set(ByVal Value As Integer)
            _accion = Value
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
#End Region
End Class
