Public Class clsConvenio

#Region "variables privadas"
    Private _idConv As Integer = 0
    Private _fid As Integer = 0
    Private _fecconv As Date
    Private _factoractconv As Double = 0
    Private _recargosconv As Double = 0
    Private _desctorecargosconv As Double = 0
    Private _saldoact2 As Double = 0
    Private _recargoporconvenio As Double = 0
    Private _fechavencconv As Date
    Private _numpagos As Integer = 0
    Private _saldoconv As Double = 0
    Private _pagosconv As Double = 0
    Private _estatusconv As Integer = 0
    Private _archivoconv As String = String.Empty
    Private _usucre As Integer = 0
    Private _accion As Integer = 0

#End Region

#Region "Propiedades"
    Public Property idConv() As Integer
        Get
            Return _idConv
        End Get
        Set(ByVal Value As Integer)
            _idConv = Value
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
    Public Property fecconv() As Date
        Get
            Return _fecconv
        End Get
        Set(ByVal Value As Date)
            _fecconv = Value
        End Set
    End Property

    Public Property factoractconv() As Double
        Get
            Return _factoractconv
        End Get
        Set(ByVal Value As Double)
            _factoractconv = Value
        End Set
    End Property

    Public Property recargosconv() As Double
        Get
            Return _recargosconv
        End Get
        Set(ByVal Value As Double)
            _recargosconv = Value
        End Set
    End Property
    Public Property desctorecargosconv() As Double
        Get
            Return _desctorecargosconv
        End Get
        Set(ByVal Value As Double)
            _desctorecargosconv = Value
        End Set
    End Property
    Public Property saldoact2() As Double
        Get
            Return _saldoact2
        End Get
        Set(ByVal Value As Double)
            _saldoact2 = Value
        End Set
    End Property
    Public Property recargoporconvenio() As Double
        Get
            Return _recargoporconvenio
        End Get
        Set(ByVal Value As Double)
            _recargoporconvenio = Value
        End Set
    End Property
    Public Property numpagos() As Integer
        Get
            Return _numpagos
        End Get
        Set(ByVal Value As Integer)
            _numpagos = Value
        End Set
    End Property
    Public Property fechavencconv() As Date
        Get
            Return _fechavencconv
        End Get
        Set(ByVal Value As Date)
            _fechavencconv = Value
        End Set
    End Property
    Public Property saldoconv() As Double
        Get
            Return _saldoconv
        End Get
        Set(ByVal Value As Double)
            _saldoconv = Value
        End Set
    End Property

    Public Property pagosconv() As Double
        Get
            Return _pagosconv
        End Get
        Set(ByVal Value As Double)
            _pagosconv = Value
        End Set
    End Property
    Public Property archivoconv() As String
        Get
            Return _archivoconv
        End Get
        Set(ByVal Value As String)
            _archivoconv = Value
        End Set
    End Property

    Public Property estatusconv() As Integer
        Get
            Return _estatusconv
        End Get
        Set(ByVal Value As Integer)
            _estatusconv = Value
        End Set
    End Property

    Public Property usucre() As Integer
        Get
            Return _usucre
        End Get
        Set(ByVal Value As Integer)
            _usucre = Value
        End Set
    End Property

    Public Property accion() As Integer
        Get
            Return _Accion
        End Get
        Set(ByVal Value As Integer)
            _Accion = Value
        End Set
    End Property
#End Region

#Region "Metodos"
#End Region
End Class
