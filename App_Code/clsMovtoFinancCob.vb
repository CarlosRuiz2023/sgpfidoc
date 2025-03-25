Public Class clsMovtoFinancCob

#Region "variables privadas"
    Private _mov_obr As String = String.Empty
    Private _mov_coop As String = String.Empty
    Private _mov_fecha As Date
    Private _mov_usu As String = String.Empty
    Private _mov_cap As Double = 0
    Private _mov_nor As Double = 0
    Private _mov_mora As Double = 0
    Private _mov_tipo As Integer = 0
    Private _mov_fecha_cap As Date
    Private _mov_ndep As String = String.Empty
    Private _mov_clv1 As String = String.Empty
    Private _mov_greq As Double = 0
    Private _mov_gejec As Double = 0
    Private _mov_recargos As Double = 0
    Private _mov_capital As Double = 0
    Private _mov_devolver As Double = 0
    Private _id As Integer = 0
    Private _id2 As Integer = 0
    Private _fid As Integer = 0
    Private _cactivo As Integer = 0
    Private _mov_cargo_pagado As Integer = 0
    Private _titulomov As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property mov_obr() As String
        Get
            Return _mov_obr
        End Get
        Set(ByVal Value As String)
            _mov_obr = Value
        End Set
    End Property
    Public Property mov_coop() As String
        Get
            Return _mov_coop
        End Get
        Set(ByVal Value As String)
            _mov_coop = Value
        End Set
    End Property
    Public Property mov_fecha() As Date
        Get
            Return _mov_fecha
        End Get
        Set(ByVal Value As Date)
            _mov_fecha = Value
        End Set
    End Property
    Public Property mov_usu() As String
        Get
            Return _mov_usu
        End Get
        Set(ByVal Value As String)
            _mov_usu = Value
        End Set
    End Property
    Public Property mov_cap() As Double
        Get
            Return _mov_cap
        End Get
        Set(ByVal Value As Double)
            _mov_cap = Value
        End Set
    End Property
    Public Property mov_nor() As Double
        Get
            Return _mov_nor
        End Get
        Set(ByVal Value As Double)
            _mov_nor = Value
        End Set
    End Property
    Public Property mov_mora() As Double
        Get
            Return _mov_mora
        End Get
        Set(ByVal Value As Double)
            _mov_mora = Value
        End Set
    End Property
    Public Property mov_tipo() As Integer
        Get
            Return _mov_tipo
        End Get
        Set(ByVal Value As Integer)
            _mov_tipo = Value
        End Set
    End Property
    Public Property mov_fecha_cap() As Date
        Get
            Return _mov_fecha_cap
        End Get
        Set(ByVal Value As Date)
            _mov_fecha_cap = Value
        End Set
    End Property
    Public Property mov_ndep() As String
        Get
            Return _mov_ndep
        End Get
        Set(ByVal Value As String)
            _mov_ndep = Value
        End Set
    End Property
    Public Property mov_clv1() As String
        Get
            Return _mov_clv1
        End Get
        Set(ByVal Value As String)
            _mov_clv1 = Value
        End Set
    End Property
    Public Property mov_greq() As Double
        Get
            Return _mov_greq
        End Get
        Set(ByVal Value As Double)
            _mov_greq = Value
        End Set
    End Property
    Public Property mov_gejec() As Double
        Get
            Return _mov_gejec
        End Get
        Set(ByVal Value As Double)
            _mov_gejec = Value
        End Set
    End Property
    Public Property mov_recargos() As Double
        Get
            Return _mov_recargos
        End Get
        Set(ByVal Value As Double)
            _mov_recargos = Value
        End Set
    End Property
    Public Property mov_capital() As Double
        Get
            Return _mov_capital
        End Get
        Set(ByVal Value As Double)
            _mov_capital = Value
        End Set
    End Property
    Public Property mov_devolver() As Double
        Get
            Return _mov_devolver
        End Get
        Set(ByVal Value As Double)
            _mov_devolver = Value
        End Set
    End Property
    Public Property id() As Integer
        Get
            Return _id
        End Get
        Set(ByVal Value As Integer)
            _id = Value
        End Set
    End Property
    Public Property id2() As Integer
        Get
            Return _id2
        End Get
        Set(ByVal Value As Integer)
            _id2 = Value
        End Set
    End Property
    Public Property fid() As Integer
        Get
            Return _fid
        End Get
        Set(ByVal Value As Integer)
            _fid = Value
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
    Public Property mov_cargo_pagado() As Integer
        Get
            Return _mov_cargo_pagado
        End Get
        Set(ByVal Value As Integer)
            _mov_cargo_pagado = Value
        End Set
    End Property
    Public Property titulomov() As String
        Get
            Return _titulomov
        End Get
        Set(ByVal Value As String)
            _titulomov = Value
        End Set
    End Property

#End Region

End Class
