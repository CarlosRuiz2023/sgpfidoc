Public Class clsCalleDU

    Private _id As Integer = 0
    Private _objectid As Integer = 0
    Private _clavecalle As Integer = 0
    Private _nomactual As String = String.Empty
    Private _nomanterio As String = String.Empty
    Private _tipo As Integer = 0
    Private _clasificac As String = String.Empty
    Private _sector As Integer = 0
    Private _subsector As Integer = 0
    Private _sectorsub As Integer = 0
    Private _colonia As String = String.Empty
    Private _colindacon As String = String.Empty
    Private _sectorsubc As Integer = 0
    Private _jerarquia As String = String.Empty
    Private _inicia_jer As String = String.Empty
    Private _termina_je As String = String.Empty
    Private _corredor As String = String.Empty
    Private _actualizac As Date
    Private _observacio As String = String.Empty
    Private _shape_leng As Double = 0
    Private _accion As Integer = 0                   'Variable para identificar la gestion del registro 0---->ALTA, 1 ----> EDITAR y 2 ----> BAJA'    
    Shared conn As New clsConexion


    Public Property id() As Integer
        Get
            Return _id
        End Get
        Set(ByVal Value As Integer)
            _id = Value
        End Set
    End Property
    Public Property objectid() As Integer
        Get
            Return _objectid
        End Get
        Set(ByVal Value As Integer)
            _objectid = Value
        End Set
    End Property
    Public Property clavecalle() As Integer
        Get
            Return _clavecalle
        End Get
        Set(ByVal Value As Integer)
            _clavecalle = Value
        End Set
    End Property
    Public Property nomactual() As String
        Get
            Return _nomactual
        End Get
        Set(ByVal Value As String)
            _nomactual = Value
        End Set
    End Property
    Public Property nomanterio() As String
        Get
            Return _nomanterio
        End Get
        Set(ByVal Value As String)
            _nomanterio = Value
        End Set
    End Property

    Public Property tipo() As Integer
        Get
            Return _tipo
        End Get
        Set(ByVal Value As Integer)
            _tipo = Value
        End Set
    End Property

    Public Property clasificac() As String
        Get
            Return _clasificac

        End Get
        Set(ByVal Value As String)
            _clasificac = Value
        End Set
    End Property

    Public Property sector() As Integer
        Get
            Return _sector
        End Get
        Set(ByVal Value As Integer)
            _sector = Value
        End Set
    End Property
    Public Property subsector() As Integer
        Get
            Return _subsector
        End Get
        Set(ByVal Value As Integer)
            _subsector = Value
        End Set
    End Property
    Public Property sectorsub() As Integer
        Get
            Return _sectorsub
        End Get
        Set(ByVal Value As Integer)
            _sectorsub = Value
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

    Public Property colindacon() As String
        Get
            Return _colindacon
        End Get
        Set(ByVal Value As String)
            _colindacon = Value
        End Set
    End Property
    Public Property sectorsubc() As Integer
        Get
            Return _sectorsubc
        End Get
        Set(ByVal Value As Integer)
            _sectorsubc = Value
        End Set
    End Property
    Public Property jerarquia() As String
        Get
            Return _jerarquia
        End Get
        Set(ByVal Value As String)
            _jerarquia = Value
        End Set
    End Property
    Public Property inicia_jer() As String
        Get
            Return _inicia_jer
        End Get
        Set(ByVal Value As String)
            _inicia_jer = Value
        End Set
    End Property

    Public Property termina_je() As String
        Get
            Return _termina_je
        End Get
        Set(ByVal Value As String)
            _termina_je = Value
        End Set
    End Property

    Public Property corredor() As String
        Get
            Return _corredor
        End Get
        Set(ByVal Value As String)
            _corredor = Value
        End Set
    End Property

    Public Property actualizac() As String
        Get
            Return _actualizac
        End Get
        Set(ByVal Value As String)
            _actualizac = Value
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

    Public Property shape_leng() As Double
        Get
            Return _shape_leng
        End Get
        Set(ByVal Value As Double)
            _shape_leng = Value
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


End Class
