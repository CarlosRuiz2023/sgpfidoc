Public Class clsEstatusAsamblea

#Region "variables privadas"
    Private _idestatus_asamblea As Integer = 0
    Private _etiqueta_estatus_asamblea As String = String.Empty
    Private _cactivo As Integer = 0
    Private _fec_cre As Date
    Private _usu_cre As Integer = 0
    Private _accion As Integer = 0                 'Variable para identificar la gestion del registro 0---->ALTA, 1 ----> EDITAR y 2 ----> BAJA'    
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property idestatus_asamblea() As Integer
        Get
            Return _idestatus_asamblea
        End Get
        Set(ByVal Value As Integer)
            _idestatus_asamblea = Value
        End Set
    End Property
    Public Property etiqueta_estatus_asamblea() As String
        Get
            Return _etiqueta_estatus_asamblea
        End Get
        Set(ByVal Value As String)
            _etiqueta_estatus_asamblea = Value
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
    Public Property fec_cre() As Date
        Get
            Return _fec_cre
        End Get
        Set(ByVal Value As Date)
            _fec_cre = Value
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



