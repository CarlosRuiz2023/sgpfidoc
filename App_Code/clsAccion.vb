Public Class clsAccion

#Region "variables privadas"
    Private _idaccion As Integer = 0  'Identificador de accion'
    Private _fec_alta_accion As Date
    Private _etiqueta_accion As String = String.Empty
    Private _accion As Integer = 0
    Private _cactivo As Integer = 0
#End Region

#Region "Propiedades"

    Public Property idaccion() As Integer
        Get
            Return _idaccion
        End Get
        Set(ByVal Value As Integer)
            _idaccion = Value
        End Set
    End Property
    Public Property fec_alta_accion() As Date
        Get
            Return _fec_alta_accion
        End Get
        Set(ByVal Value As Date)
            _fec_alta_accion = Value
        End Set
    End Property
    Public Property etiqueta_accion() As String
        Get
            Return _etiqueta_accion
        End Get
        Set(ByVal Value As String)
            _etiqueta_accion = Value
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
    Public Property cactivo() As Integer
        Get
            Return _cactivo
        End Get
        Set(ByVal Value As Integer)
            _cactivo = Value
        End Set
    End Property

#End Region


End Class
