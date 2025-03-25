Public Class clsRolAccionTarea
#Region "variables privadas"
    Private _idrol As Integer = 0
    Private _idaccion As Integer = 0
    Private _idtarea As Integer = 0
    Private _fec_cre As Date
    Private _fec_alta_accion As Date
    Private _etiqueta_accion As String = String.Empty
    Private _sp As String = String.Empty
    Private _descrip_tarea As String = String.Empty
    Private _etiqueta_tarea As String = String.Empty
    Private _limite_autorizacion As Integer = 0
    Private _fec_cre_tarea As Date
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property idrol() As Integer
        Get
            Return _idrol
        End Get
        Set(ByVal Value As Integer)
            _idrol = Value
        End Set
    End Property

    Public Property idaccion() As Integer
        Get
            Return _idaccion
        End Get
        Set(ByVal Value As Integer)
            _idaccion = Value
        End Set
    End Property

    Public Property idtarea() As Integer
        Get
            Return _idtarea
        End Get
        Set(ByVal Value As Integer)
            _idtarea = Value
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
    Public Property fec_alta_accion() As Date
        Get
            Return _fec_alta_accion
        End Get
        Set(ByVal Value As Date)
            _fec_alta_accion = Value
        End Set
    End Property
    Public Property etiqueta_accion() As String
        Get
            Return _etiqueta_accion
        End Get
        Set(ByVal Value As String)
            _etiqueta_accion = Value
        End Set
    End Property
    Public Property sp() As String
        Get
            Return _sp
        End Get
        Set(ByVal Value As String)
            _sp = Value
        End Set
    End Property
    Public Property descrip_tarea() As String
        Get
            Return _descrip_tarea
        End Get
        Set(ByVal Value As String)
            _descrip_tarea = Value
        End Set
    End Property
    Public Property etiqueta_tarea() As String
        Get
            Return _etiqueta_tarea
        End Get
        Set(ByVal Value As String)
            _etiqueta_tarea = Value
        End Set
    End Property
    Public Property limite_autorizacion() As Integer
        Get
            Return _limite_autorizacion
        End Get
        Set(ByVal Value As Integer)
            _limite_autorizacion = Value
        End Set
    End Property
    Public Property fec_cre_tarea() As String
        Get
            Return _fec_cre_tarea
        End Get
        Set(ByVal Value As String)
            _fec_cre_tarea = Value
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

