Public Class clsTipoAnexoContrato

#Region "variables privadas"
    Private _idtipo_anexo_cont As Integer = 0
    Private _etiqueta_anexo As String = String.Empty
    Private _observaciones As String = String.Empty
    Private _usu_cre As Integer = 0
    Private _usu_mod As Integer = 0
    Private _fec_cre As Date
    Private _fec_mod As Date
    Private _cactivo As Integer = 0
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property idtipo_anexo_cont() As Integer
        Get
            Return _idtipo_anexo_cont
        End Get
        Set(ByVal Value As Integer)
            _idtipo_anexo_cont = Value
        End Set
    End Property
    Public Property etiqueta_anexo() As String
        Get
            Return _etiqueta_anexo
        End Get
        Set(ByVal Value As String)
            _etiqueta_anexo = Value
        End Set
    End Property
    Public Property observaciones() As String
        Get
            Return _observaciones
        End Get
        Set(ByVal Value As String)
            _observaciones = Value
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
    Public Property cactivo() As Integer
        Get
            Return _cactivo
        End Get
        Set(ByVal Value As Integer)
            _cactivo = Value
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

#Region "Metodos"

#End Region



End Class
