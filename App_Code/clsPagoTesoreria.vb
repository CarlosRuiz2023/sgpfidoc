Public Class clsPagoTesoreria
    Private _Cooperador As String = String.Empty
    Private _Nombre As String = String.Empty
    Private _Fecha As Integer = 0
    Private _Importe As Double = 0
    Private _LetraRecibo As String = String.Empty
    Private _Recibo As Integer = 0

    Public Property Cooperador As String
        Get
            Return _Cooperador
        End Get
        Set(value As String)
            _Cooperador = value
        End Set
    End Property
    Public Property Nombre As String
        Get
            Return _Nombre
        End Get
        Set(value As String)
            _Nombre = value
        End Set
    End Property

    Public Property Fecha As Integer
        Get
            Return _Fecha
        End Get
        Set(value As Integer)
            _Fecha = value
        End Set
    End Property
    Public Property Importe As Double
        Get
            Return _Importe
        End Get
        Set(value As Double)
            _Importe = value
        End Set
    End Property
    Public Property LetraRecibo As String
        Get
            Return _LetraRecibo
        End Get
        Set(value As String)
            _LetraRecibo = value
        End Set
    End Property
    Public Property Recibo As Integer
        Get
            Return _Recibo
        End Get
        Set(value As Integer)
            _Recibo = value
        End Set
    End Property
End Class
