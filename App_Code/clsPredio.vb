Public Class clsPredio
#Region "variables privadas"
    Private _pid As Integer = 0
    Private _cup As String = String.Empty
    Private _fecha_cr As Date
    Private _fecha_mo As Date
    Private _usrcre As Integer = 0
    Private _usrmod As Integer = 0
    Private _tipo As String = String.Empty
    Private _tipopredio As Integer = 0
    Private _ctapredial As String = String.Empty
    Private _ctaimuvi As String = String.Empty
    Private _observacio As String = String.Empty
    Private _usopredio As Integer
    Private _r20 As String = String.Empty
    Private _nooficial As String = String.Empty
    Private _sapal As String = String.Empty
    Private _geom As String = String.Empty
    Private _mzna As String = String.Empty
    Private _lote As String = String.Empty
    Private _accion As String = String.Empty
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property pid() As Integer
        Get
            Return _pid
        End Get
        Set(ByVal Value As Integer)
            _pid = Value
        End Set
    End Property
    Public Property cup() As String
        Get
            Return _cup
        End Get
        Set(ByVal Value As String)
            _cup = Value
        End Set
    End Property

    Public Property fecha_cr() As Date
        Get
            Return _fecha_cr
        End Get
        Set(ByVal Value As Date)
            _fecha_cr = Value
        End Set
    End Property

    Public Property fecha_mo() As Date
        Get
            Return _fecha_mo
        End Get
        Set(ByVal Value As Date)
            _fecha_mo = Value
        End Set
    End Property

    Public Property usrcre() As Integer
        Get
            Return _usrcre
        End Get
        Set(ByVal Value As Integer)
            _usrcre = Value
        End Set
    End Property
    Public Property usrmod() As Integer
        Get
            Return _usrmod
        End Get
        Set(ByVal Value As Integer)
            _usrmod = Value
        End Set
    End Property
    Public Property tipo() As String
        Get
            Return _tipo
        End Get
        Set(ByVal Value As String)
            _tipo = Value
        End Set
    End Property
    Public Property tipopredio() As Integer
        Get
            Return _tipopredio
        End Get
        Set(ByVal Value As Integer)
            _tipopredio = Value
        End Set
    End Property


    Public Property ctapredial() As String
        Get
            Return _ctapredial
        End Get
        Set(ByVal Value As String)
            _ctapredial = Value
        End Set
    End Property
    Public Property ctaimuvi() As String
        Get
            Return _ctaimuvi
        End Get
        Set(ByVal Value As String)
            _ctaimuvi = Value
        End Set
    End Property
    Public Property observacio() As String
        Get
            Return _observacio
        End Get
        Set(ByVal Value As String)
            _observacio = Value
        End Set
    End Property

    Public Property usopredio() As Integer
        Get
            Return _usopredio
        End Get
        Set(ByVal Value As Integer)
            _usopredio = Value
        End Set
    End Property
    Public Property r20() As String
        Get
            Return _r20
        End Get
        Set(ByVal Value As String)
            _r20 = Value
        End Set
    End Property
    Public Property nooficial() As String
        Get
            Return _nooficial
        End Get
        Set(ByVal Value As String)
            _nooficial = Value
        End Set
    End Property

    Public Property sapal() As String
        Get
            Return _sapal
        End Get
        Set(ByVal Value As String)
            _sapal = Value
        End Set
    End Property
    Public Property geom() As String
        Get
            Return _geom
        End Get
        Set(ByVal Value As String)
            _geom = Value
        End Set
    End Property
    Public Property mzna() As String
        Get
            Return _mzna
        End Get
        Set(ByVal Value As String)
            _mzna = Value
        End Set
    End Property
    Public Property lote() As String
        Get
            Return _lote
        End Get
        Set(ByVal Value As String)
            _lote = Value
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

    Public Property Mensaje() As String
        Get
            Return strMensaje
        End Get
        Set(ByVal Value As String)
            strMensaje = Value
        End Set
    End Property



#End Region

End Class
