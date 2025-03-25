Public Class clsAbonoCapital
#Region "variables privadas"
    Private _clv_coo As String = String.Empty
    Private _monto_abonar As Double = 0
    Private _idpago As Integer = 0
    Private _fecha_pago As Date
    Private _coo_clv2 As String = String.Empty
    Private _folio_caja As String = String.Empty
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property clv_coo() As String
        Get
            Return _clv_coo
        End Get
        Set(ByVal Value As String)
            _clv_coo = Value
        End Set
    End Property
    Public Property monto_abonar() As Double
        Get
            Return _monto_abonar
        End Get
        Set(ByVal Value As Double)
            _monto_abonar = Value
        End Set
    End Property
    Public Property idpago() As Integer
        Get
            Return _idpago
        End Get
        Set(ByVal Value As Integer)
            _idpago = Value
        End Set
    End Property
    Public Property fecha_pago() As Date
        Get
            Return _fecha_pago
        End Get
        Set(ByVal Value As Date)
            _fecha_pago = Value
        End Set
    End Property
    Public Property coo_clv2() As String
        Get
            Return _coo_clv2
        End Get
        Set(ByVal Value As String)
            _coo_clv2 = Value
        End Set
    End Property
    Public Property folio_caja() As String
        Get
            Return _folio_caja
        End Get
        Set(ByVal Value As String)
            _folio_caja = Value
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

#Region "Metodos"

#End Region

End Class
