Public Class clsComite

#Region "variables privadas"
    Private _idcomite As Integer = 0
    Private _num_sesion As Integer = 0
    Private _num_sesion_romano As String = String.Empty
    Private _leyenda As String = String.Empty
    Private _tipo_sesion As Integer = 0
    Private _etiqueta_tipo_comite As String = String.Empty
    Private _formato_comite As Integer = 0
    Private _etiqueta_formato_comite As String = String.Empty
    Private _fec_comite As Date
    Private _acta_comite As String = String.Empty
    Private _usu_cre As Integer = 0
    Private _usu_mod As Integer = 0
    Private _fec_cre As Date
    Private _fec_mod As Date
    Private _cestatus As Integer = 0
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
    Public Property num_sesion() As Integer
        Get
            Return _num_sesion
        End Get
        Set(ByVal Value As Integer)
            _num_sesion = Value
        End Set
    End Property
    Public Property num_sesion_romano() As String
        Get
            Return _num_sesion_romano
        End Get
        Set(ByVal Value As String)
            _num_sesion_romano = Value
        End Set
    End Property

    Public Property leyenda() As String
        Get
            Return _leyenda
        End Get
        Set(ByVal Value As String)
            _leyenda = Value
        End Set
    End Property

    Public Property tipo_sesion() As Integer
        Get
            Return _tipo_sesion
        End Get
        Set(ByVal Value As Integer)
            _tipo_sesion = Value
        End Set
    End Property
    Public Property etiqueta_tipo_comite() As String
        Get
            Return _etiqueta_tipo_comite
        End Get
        Set(ByVal Value As String)
            _etiqueta_tipo_comite = Value
        End Set
    End Property

    Public Property formato_comite() As Integer
        Get
            Return _formato_comite
        End Get
        Set(ByVal Value As Integer)
            _formato_comite = Value
        End Set
    End Property
    Public Property etiqueta_formato_comite() As String
        Get
            Return _etiqueta_formato_comite
        End Get
        Set(ByVal Value As String)
            _etiqueta_formato_comite = Value
        End Set
    End Property
    Public Property fec_comite() As Date
        Get
            Return _fec_comite
        End Get
        Set(ByVal Value As Date)
            _fec_comite = Value
        End Set
    End Property
    Public Property acta_comite() As String
        Get
            Return _acta_comite
        End Get
        Set(ByVal Value As String)
            _acta_comite = Value
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



