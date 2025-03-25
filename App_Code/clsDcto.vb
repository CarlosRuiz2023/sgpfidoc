Public Class clsDcto


#Region "variables privadas"
    Private _idsol As Integer = 0  'Número de solicitud de obra'
    Private _idref As Integer = 0 'Numero que se le asigna al objeto propietario del documento (referencia)
    Private _iddcto As Integer = 0 'Numero que identifica el documento'
    Private _folio As String = String.Empty   'Número asignado al documento por algun control externo'
    Private _FecSolic As Date      'Fecha en que se envía el documento impreso'
    Private _FecRecib As Date      'Fecha en que recibieron el acuse del documento (fecha escrita en el acuse)'
    Private _NomRecibe As String = String.Empty     'Nombre de persona de quien recibe el documento de contestación'
    Private _NumRecibe As Integer = 0 'Numero identificador del usuario
    Private _NomArchivo As String = String.Empty             'Nombre del archivo digital escaneado'
    Private _UsuCre As String = String.Empty                   'Usuario que escanea el documento y lo da de alta en el sistema'
    Private _FecCre As Date                          'Fecha cuando se da de alta el documento'
    Private _UsuMod As String = String.Empty         'Usuario que modifica el documento escaneado'
    Private _FecMod As Date                          'Fecha del dia en que se modifica o actualiza el documento guardado'
    Private _TipoDcto As Integer = 0                 'Tipo de documento
    Private _DesDcto As String = String.Empty                  'descripcion del documento
    '1---> FACTIBILIDAD       
    '2---> Solicitud de revisión a SAPAL
    '3---> Respuesta de SAPAL a solicitud de revisión
    '4---> Solicitud de Traza a Desarrollo Urbano (DU)
    '5---> Respuesta de Desarrollo Urbano
    '6---> Anuencia 
    Private _accion As Integer = 0                   'Variable para identificar la gestion del registro 0---->ALTA, 1 ----> EDITAR y 2 ----> BAJAR'

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property idsol() As Integer
        Get
            Return _idsol
        End Get
        Set(ByVal Value As Integer)
            _idsol = Value
        End Set
    End Property
    Public Property idref() As Integer
        Get
            Return _idref
        End Get
        Set(ByVal Value As Integer)
            _idref = Value
        End Set
    End Property
    Public Property iddcto() As Integer
        Get
            Return _iddcto
        End Get
        Set(ByVal Value As Integer)
            _iddcto = Value
        End Set
    End Property
    Public Property folio() As String
        Get
            Return _folio
        End Get
        Set(ByVal Value As String)
            _folio = Value
        End Set
    End Property
    Public Property FecSolic() As Date
        Get
            Return _FecSolic
        End Get
        Set(ByVal Value As Date)
            _FecSolic = Value
        End Set
    End Property
    Public Property FecRecib() As Date
        Get
            Return _FecRecib
        End Get
        Set(ByVal Value As Date)
            _FecRecib = Value
        End Set
    End Property
    Public Property NomRecibe() As String
        Get
            Return _NomRecibe
        End Get
        Set(ByVal Value As String)
            _NomRecibe = Value
        End Set
    End Property
    Public Property NumRecibe() As Integer
        Get
            Return _NumRecibe
        End Get
        Set(ByVal Value As Integer)
            _NumRecibe = Value
        End Set
    End Property
    Public Property NomArchivo() As String
        Get
            Return _NomArchivo
        End Get
        Set(ByVal Value As String)
            _NomArchivo = Value
        End Set
    End Property
    Public Property UsuCre() As String
        Get
            Return _UsuCre
        End Get
        Set(ByVal Value As String)
            _UsuCre = Value
        End Set
    End Property
    Public Property FecCre() As Date
        Get
            Return _FecCre
        End Get
        Set(ByVal Value As Date)
            _FecCre = Value
        End Set
    End Property
    Public Property UsuMod() As String
        Get
            Return _UsuMod
        End Get
        Set(ByVal Value As String)
            _UsuMod = Value
        End Set
    End Property
    Public Property FecMod() As Date
        Get
            Return _FecMod
        End Get
        Set(ByVal Value As Date)
            _FecMod = Value
        End Set
    End Property
    Public Property TipoDcto() As Integer
        Get
            Return _TipoDcto
        End Get
        Set(ByVal Value As Integer)
            _TipoDcto = Value
        End Set
    End Property
    Public Property DesDcto() As String
        Get
            Return _DesDcto
        End Get
        Set(ByVal Value As String)
            _DesDcto = Value
        End Set
    End Property
    Public Property Accion() As Integer
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
