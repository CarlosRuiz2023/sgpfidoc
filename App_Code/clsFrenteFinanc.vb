Public Class clsFrenteFinanc
#Region "variables privadas"
    Private _fid As Integer = 0  'Número de frente'
    Private _porcentaje As Double = 0
    Private _monto_descto As Double = 0
    Private _fec_ofrece As Date
    Private _fec_aplic As Date
    Private _usrcre As String = String.Empty
    Private _cactivo As Integer = 0
    Private _accion As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property fid() As Integer
        Get
            Return _fid
        End Get
        Set(ByVal Value As Integer)
            _fid = Value
        End Set
    End Property
    Public Property porcentaje() As Double
        Get
            Return _porcentaje
        End Get
        Set(ByVal Value As Double)
            _porcentaje = Value
        End Set
    End Property
    Public Property monto_descto() As Double
        Get
            Return _monto_descto
        End Get
        Set(ByVal Value As Double)
            _monto_descto = Value
        End Set
    End Property
    Public Property fec_ofrece() As Date
        Get
            Return _fec_ofrece
        End Get
        Set(ByVal Value As Date)
            _fec_ofrece = Value
        End Set
    End Property
    Public Property fec_aplic() As Date
        Get
            Return _fec_aplic
        End Get
        Set(ByVal Value As Date)
            _fec_aplic = Value
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
    Public Property cactivo() As Integer
        Get
            Return _cactivo
        End Get
        Set(ByVal Value As Integer)
            _cactivo = Value
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
End Class
