Public Class clsContrato
#Region "variables privadas"
    Private _idcontrato As Integer = 0
    Private _num_contrato As String = String.Empty
    Private _num_contrato_limpio As String = String.Empty
    Private _obs_contrato As String = String.Empty
    Private _monto_contrato_sin_iva As Double = 0
    Private _monto_contrato As Double = 0
    Private _iva_contrato As Double = 0
    Private _idcontratista As Integer = 0
    Private _nom_contratista As String = String.Empty
    Private _rfc_contratista As String = String.Empty
    Private _fec_contrato As Date
    Private _fec_ini_contrato As Date
    Private _fec_fin_contrato As Date
    Private _fec_prorroga As Date
    Private _anticipo As Double = 0
    Private _docto_contrato As String = String.Empty
    Private _idtipoasignacion As Integer = 0
    Private _tipo_asignacion As String = String.Empty
    Private _fec_cre As Date
    Private _fec_mod As Date
    Private _usu_cre As Integer
    Private _usu_mod As Integer
    Private _cestatus As Integer = 0
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property idcontrato() As Integer
        Get
            Return _idcontrato
        End Get
        Set(ByVal Value As Integer)
            _idcontrato = Value
        End Set
    End Property
    Public Property num_contrato() As String
        Get
            Return _num_contrato
        End Get
        Set(ByVal Value As String)
            _num_contrato = Value
        End Set
    End Property
    Public Property num_contrato_limpio() As String
        Get
            Return _num_contrato_limpio
        End Get
        Set(ByVal Value As String)
            _num_contrato_limpio = Value
        End Set
    End Property

    Public Property obs_contrato() As String
        Get
            Return _obs_contrato
        End Get
        Set(ByVal Value As String)
            _obs_contrato = Value
        End Set
    End Property

    Public Property monto_contrato_sin_iva() As Double
        Get
            Return _monto_contrato_sin_iva
        End Get
        Set(ByVal Value As Double)
            _monto_contrato_sin_iva = Value
        End Set
    End Property
    Public Property monto_contrato() As Double
        Get
            Return _monto_contrato
        End Get
        Set(ByVal Value As Double)
            _monto_contrato = Value
        End Set
    End Property
    Public Property iva_contrato() As Double
        Get
            Return _iva_contrato
        End Get
        Set(ByVal Value As Double)
            _iva_contrato = Value
        End Set
    End Property
    Public Property idcontratista() As Integer
        Get
            Return _idcontratista
        End Get
        Set(ByVal Value As Integer)
            _idcontratista = Value
        End Set
    End Property
    Public Property nom_contratista() As String
        Get
            Return _nom_contratista
        End Get
        Set(ByVal Value As String)
            _nom_contratista = Value
        End Set
    End Property

    Public Property rfc_contratista() As String
        Get
            Return _rfc_contratista
        End Get
        Set(ByVal Value As String)
            _rfc_contratista = Value
        End Set
    End Property
    Public Property fec_contrato() As Date
        Get
            Return _fec_contrato
        End Get
        Set(ByVal Value As Date)
            _fec_contrato = Value
        End Set
    End Property
    Public Property fec_ini_contrato() As Date
        Get
            Return _fec_ini_contrato
        End Get
        Set(ByVal Value As Date)
            _fec_ini_contrato = Value
        End Set
    End Property
    Public Property fec_fin_contrato() As Date
        Get
            Return _fec_fin_contrato
        End Get
        Set(ByVal Value As Date)
            _fec_fin_contrato = Value
        End Set
    End Property
    Public Property fec_prorroga() As Date
        Get
            Return _fec_prorroga
        End Get
        Set(ByVal Value As Date)
            _fec_prorroga = Value
        End Set
    End Property
    Public Property anticipo() As Double
        Get
            Return _anticipo
        End Get
        Set(ByVal Value As Double)
            _anticipo = Value
        End Set
    End Property
    Public Property docto_contrato() As String
        Get
            Return _docto_contrato
        End Get
        Set(ByVal Value As String)
            _docto_contrato = Value
        End Set
    End Property
    Public Property idtipoasignacion() As Integer
        Get
            Return _idtipoasignacion
        End Get
        Set(ByVal Value As Integer)
            _idtipoasignacion = Value
        End Set
    End Property
    Public Property tipo_asignacion() As String
        Get
            Return _tipo_asignacion
        End Get
        Set(ByVal Value As String)
            _tipo_asignacion = Value
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
    Public Property cestatus() As Integer
        Get
            Return _cestatus

        End Get
        Set(ByVal Value As Integer)
            _cestatus = Value
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
