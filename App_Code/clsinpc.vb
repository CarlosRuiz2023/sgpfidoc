Public Class clsinpc
    Private _year As Integer = 0
    Private _mes As Integer = 0
    Private _yearmes As String = String.Empty
    Private _valor_inpc As Double = 0
    Private _accion As Integer = 0


    Public Property year() As Integer
        Get
            Return _year
        End Get
        Set(ByVal Value As Integer)
            _year = Value
        End Set
    End Property
    Public Property mes() As Integer
        Get
            Return _mes
        End Get
        Set(ByVal Value As Integer)
            _mes = Value
        End Set
    End Property
    Public Property yearmes() As String
        Get
            Return _yearmes
        End Get
        Set(ByVal Value As String)
            _yearmes = Value
        End Set
    End Property

    Public Property valor_inpc() As Double
        Get
            Return _valor_inpc
        End Get
        Set(ByVal Value As Double)
            _valor_inpc = Value
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
