Public Class clsCoop

#Region "variables privadas"
    Private _idcoop As Integer = 0               'Número de cooperador'
    Private _apellidoP As String = String.Empty  'Numero que se le asigna al objeto propietario del documento (referencia)
    Private _apellidoM As String = String.Empty  'Numero que identifica el documento'
    Private _nombres As String = String.Empty   'Número asignado al documento por algun control externo'
    Private _callecoop As String = String.Empty      'Fecha en que se envía el documento impreso'
    Private _colcoop As String = String.Empty      'Fecha en que recibieron el acuse del documento (fecha escrita en el acuse)'
    Private _nooficialext As String = String.Empty     'Nombre de persona de quien recibe el documento de contestación'
    Private _nooficialint As String = String.Empty 'Numero identificador del usuario
    Private _telcoop As String = String.Empty             'Nombre del archivo digital escaneado'
    Private _nomficha As String = String.Empty                   'Usuario que escanea el documento y lo da de alta en el sistema'
    Private _estado As String = String.Empty                         'Fecha cuando se da de alta el documento'
    Private _pais As String = String.Empty         'Usuario que modifica el documento escaneado'
    Private _correo As String = String.Empty                 'Tipo de documento
    Private _usrcre As String = String.Empty                  'descripcion del documento
    Private _feccre As Date                             'descripcion del documento
    Private _usrmod As String = String.Empty                  'descripcion del documento
    Private _fecmod As Date
    Private _curp As String = String.Empty                  'descripcion del documento
    Private _relpred As Integer = 0                  'descripcion del documento   
    Private _ine As String = String.Empty                  'Número de la tarjeta INE 13 digitos
    Private _doc As String = String.Empty                  'Imagen de documento de identificación
    Private _accion As String = String.Empty                  'Variable para identificar la gestion del registro 0---->ALTA, 1 ----> EDITAR y 2 ----> BAJAR'
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property idcoop() As Integer
        Get
            Return _idcoop
        End Get
        Set(ByVal Value As Integer)
            _idcoop = Value
        End Set
    End Property
    Public Property apellidoP() As String
        Get
            Return _apellidoP
        End Get
        Set(ByVal Value As String)
            _apellidoP = Value
        End Set
    End Property
    Public Property apellidoM() As String
        Get
            Return _apellidoM
        End Get
        Set(ByVal Value As String)
            _apellidoM = Value
        End Set
    End Property
    Public Property nombres() As String
        Get
            Return _nombres
        End Get
        Set(ByVal Value As String)
            _nombres = Value
        End Set
    End Property
    Public Property callecoop() As String
        Get
            Return _callecoop
        End Get
        Set(ByVal Value As String)
            _callecoop = Value
        End Set
    End Property
    Public Property colcoop() As String
        Get
            Return _colcoop
        End Get
        Set(ByVal Value As String)
            _colcoop = Value
        End Set
    End Property
    Public Property nooficialext() As String
        Get
            Return _nooficialext
        End Get
        Set(ByVal Value As String)
            _nooficialext = Value
        End Set
    End Property
    Public Property nooficialint() As String
        Get
            Return _nooficialint
        End Get
        Set(ByVal Value As String)
            _nooficialint = Value
        End Set
    End Property
    Public Property telcoop() As String
        Get
            Return _telcoop
        End Get
        Set(ByVal Value As String)
            _telcoop = Value
        End Set
    End Property
    Public Property nomficha() As String
        Get
            Return _nomficha
        End Get
        Set(ByVal Value As String)
            _nomficha = Value
        End Set
    End Property
    Public Property estado() As String
        Get
            Return _estado
        End Get
        Set(ByVal Value As String)
            _estado = Value
        End Set
    End Property
    Public Property pais() As String
        Get
            Return _pais
        End Get
        Set(ByVal Value As String)
            _pais = Value
        End Set
    End Property

    Public Property correo() As String
        Get
            Return _correo
        End Get
        Set(ByVal Value As String)
            _correo = Value
        End Set
    End Property

    Public Property usrcre() As String
        Get
            Return _usrcre
        End Get
        Set(ByVal Value As String)
            _usrcre = Value
        End Set
    End Property
    Public Property feccre() As Date
        Get
            Return _feccre
        End Get
        Set(ByVal Value As Date)
            _feccre = Value
        End Set
    End Property
    Public Property usrmod() As String
        Get
            Return _usrmod
        End Get
        Set(ByVal Value As String)
            _usrmod = Value
        End Set
    End Property
    Public Property fecmod() As Date
        Get
            Return _fecmod
        End Get
        Set(ByVal Value As Date)
            _fecmod = Value
        End Set
    End Property
    Public Property curp() As String
        Get
            Return _curp
        End Get
        Set(ByVal Value As String)
            _curp = Value
        End Set
    End Property
    Public Property relpred() As Integer
        Get
            Return _relpred
        End Get
        Set(ByVal Value As Integer)
            _relpred = Value
        End Set
    End Property

    Public Property ine() As String
        Get
            Return _ine
        End Get
        Set(ByVal Value As String)
            _ine = Value
        End Set
    End Property
    Public Property doc() As String
        Get
            Return _doc
        End Get
        Set(ByVal Value As String)
            _doc = Value
        End Set
    End Property
    Public Property accion() As String
        Get
            Return _accion
        End Get
        Set(ByVal Value As String)
            _accion = Value
        End Set
    End Property
#End Region

#Region "Metodos"

#End Region


End Class
