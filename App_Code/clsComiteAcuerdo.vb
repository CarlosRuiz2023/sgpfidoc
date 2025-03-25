Public Class clsComiteAcuerdo
#Region "variables privadas"
    Private _idcomite As Integer = 0
    Private _idacuerdo As Integer = 0
    Private _acta_comite As String = String.Empty
    Private _num_sesion As Integer = 0
    Private _fec_comite As Date
    Private _leyenda_comite As String = String.Empty
    Private _num_acuerdo As Integer = 0
    Private _folio_acuerdo As String = String.Empty
    Private _leyenda_acuerdo As String = String.Empty
    Private _estatus_acuerdo As String = String.Empty
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
    Public Property acta_comite() As String
        Get
            Return _acta_comite
        End Get
        Set(ByVal Value As String)
            _acta_comite = Value
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
    Public Property fec_comite() As Date
        Get
            Return _fec_comite
        End Get
        Set(ByVal Value As Date)
            _fec_comite = Value
        End Set
    End Property
    Public Property leyenda_comite() As String
        Get
            Return _leyenda_comite
        End Get
        Set(ByVal Value As String)
            _leyenda_comite = Value
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

    Public Property leyenda_acuerdo() As String
        Get
            Return _leyenda_acuerdo
        End Get
        Set(ByVal Value As String)
            _leyenda_acuerdo = Value
        End Set
    End Property

    Public Property estatus_acuerdo() As String
        Get
            Return _estatus_acuerdo
        End Get
        Set(ByVal Value As String)
            _estatus_acuerdo = Value
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
