Public Class clsCobCifras

#Region "variables privadas"
    Private _numadeudos As Integer = 0
    Private _totalsaldocon As Double = 0
    Private _totalsaldosin As Double = 0
    Private _noobras As Integer = 0
    Private _nopredios As Integer = 0
    Private _accion As String = String.Empty

#End Region

#Region "Propiedades"
    Public Property numadeudos() As Integer
        Get
            Return _numadeudos
        End Get
        Set(ByVal Value As Integer)
            _numadeudos = Value
        End Set
    End Property

    Public Property totalsaldocon() As Double
        Get
            Return _totalsaldocon
        End Get
        Set(ByVal Value As Double)
            _totalsaldocon = Value
        End Set
    End Property

    Public Property totalsaldosin() As Double
        Get
            Return _totalsaldosin
        End Get
        Set(ByVal Value As Double)
            _totalsaldosin = Value
        End Set
    End Property
    Public Property noobras() As Integer
        Get
            Return _noobras
        End Get
        Set(ByVal Value As Integer)
            _noobras = Value
        End Set
    End Property

    Public Property nopredios() As Integer
        Get
            Return _nopredios
        End Get
        Set(ByVal Value As Integer)
            _nopredios = Value
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
