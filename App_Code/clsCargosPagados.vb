Public Class clsCargosPagados


#Region "variables privadas"
    Private _clv_coo As String = String.Empty
    Private _monto_pagado As Double = 0
    Private _idpago As Integer = 0
    Private _idcargo As Integer = 0
    Private _fecha_pago As Date
    Private _fecha_cargo As Date
    Private _coo_clv2 As String = String.Empty
    Private _tipo_mov As String = String.Empty
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
    Public Property monto_pagado() As Double
        Get
            Return _monto_pagado
        End Get
        Set(ByVal Value As Double)
            _monto_pagado = Value
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
    Public Property idcargo() As Integer
        Get
            Return _idcargo
        End Get
        Set(ByVal Value As Integer)
            _idcargo = Value
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
    Public Property fecha_cargo() As Date
        Get
            Return _fecha_cargo
        End Get
        Set(ByVal Value As Date)
            _fecha_cargo = Value
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
    Public Property tipo_mov() As String
        Get
            Return _tipo_mov
        End Get
        Set(ByVal Value As String)
            _tipo_mov = Value
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
