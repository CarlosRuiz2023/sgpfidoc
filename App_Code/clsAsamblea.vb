Public Class clsAsamblea

#Region "variables privadas"
    Private _idasamblea As Integer = 0
    Private _lugar As String = String.Empty
    Private _idpromotor As Integer = 0
    Private _idpresup As Integer = 0
    Private _nom_promotor As String = String.Empty
    Private _idtasamblea As Integer = 0
    Private _nom_tasamblea As String = String.Empty
    Private _fecha_asamblea As Date
    Private _num_asistentes As Integer = 0
    Private _num_asistentes_m As Integer = 0
    Private _fecha_programa As Date
    Private _docto_evidencia As String = String.Empty
    Private _oid As Integer = 0
    Private _calle As String = String.Empty
    Private _colonia As String = String.Empty
    Private _tramo As String = String.Empty
    Private _estatus_asamblea As Integer = 0
    Private _cestatus As String = String.Empty
    Private _usu_cre As Integer = 0
    Private _usu_mod As Integer = 0
    Private _fec_cre As Date
    Private _fec_mod As Date
    Private _accion As Integer = 0                   'Variable para identificar la gestion del registro 0---->ALTA, 1 ----> EDITAR y 2 ----> BAJA'    
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property idasamblea() As Integer
        Get
            Return _idasamblea
        End Get
        Set(ByVal Value As Integer)
            _idasamblea = Value
        End Set
    End Property
    Public Property lugar() As String
        Get
            Return _lugar
        End Get
        Set(ByVal Value As String)
            _lugar = Value
        End Set
    End Property
    Public Property idpromotor() As Integer
        Get
            Return _idpromotor
        End Get
        Set(ByVal Value As Integer)
            _idpromotor = Value
        End Set
    End Property
    Public Property idpresup() As Integer
        Get
            Return _idpresup
        End Get
        Set(ByVal Value As Integer)
            _idpresup = Value
        End Set
    End Property
    Public Property nom_promotor() As String
        Get
            Return _nom_promotor
        End Get
        Set(ByVal Value As String)
            _nom_promotor = Value
        End Set
    End Property

    Public Property idtasamblea() As Integer
        Get
            Return _idtasamblea
        End Get
        Set(ByVal Value As Integer)
            _idtasamblea = Value
        End Set
    End Property

    Public Property nom_tasamblea() As String
        Get
            Return _nom_tasamblea

        End Get
        Set(ByVal Value As String)
            _nom_tasamblea = Value
        End Set
    End Property

    Public Property fecha_asamblea() As Date
        Get
            Return _fecha_asamblea
        End Get
        Set(ByVal Value As Date)
            _fecha_asamblea = Value
        End Set
    End Property
    Public Property num_asistentes() As Integer
        Get
            Return _num_asistentes
        End Get
        Set(ByVal Value As Integer)
            _num_asistentes = Value
        End Set
    End Property
    Public Property num_asistentes_m() As Integer
        Get
            Return _num_asistentes_m
        End Get
        Set(ByVal Value As Integer)
            _num_asistentes_m = Value
        End Set
    End Property
    Public Property fecha_programa() As Date
        Get
            Return _fecha_programa
        End Get
        Set(ByVal Value As Date)
            _fecha_programa = Value
        End Set
    End Property

    Public Property docto_evidencia() As String
        Get
            Return _docto_evidencia
        End Get
        Set(ByVal Value As String)
            _docto_evidencia = Value
        End Set
    End Property
    Public Property oid() As Integer
        Get
            Return _oid
        End Get
        Set(ByVal Value As Integer)
            _oid = Value
        End Set
    End Property
    Public Property calle() As String
        Get
            Return _calle
        End Get
        Set(ByVal Value As String)
            _calle = Value
        End Set
    End Property
    Public Property colonia() As String
        Get
            Return _colonia
        End Get
        Set(ByVal Value As String)
            _colonia = Value
        End Set
    End Property

    Public Property tramo() As String
        Get
            Return _tramo
        End Get
        Set(ByVal Value As String)
            _tramo = Value
        End Set
    End Property

    Public Property estatus_asamblea() As Integer
        Get
            Return _estatus_asamblea
        End Get
        Set(ByVal Value As Integer)
            _estatus_asamblea = Value
        End Set
    End Property

    Public Property cestatus() As String
        Get
            Return _cestatus
        End Get
        Set(ByVal Value As String)
            _cestatus = Value
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


#End Region
End Class


