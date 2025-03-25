Public Class clsFormatoComite

#Region "variables privadas"
    Private _idformato_comite As Integer = 0
    Private _etiqueta_formato_comite As String = String.Empty
    Private _descrip As String = String.Empty
    Private _fec_cre As Date
    Private _fec_mod As Date
    Private _usu_cre As Integer = 0
    Private _usu_mod As Integer = 0
    Private _accion As Integer = 0
    Private _cestatus As Integer = 0
#End Region

#Region "Propiedades"
    Public Property idformato_comite() As Integer
        Get
            Return _idformato_comite
        End Get
        Set(ByVal Value As Integer)
            _idformato_comite = Value
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
    Public Property descrip() As String
        Get
            Return _descrip
        End Get
        Set(ByVal Value As String)
            _descrip = Value
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