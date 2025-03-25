Public Class clsAnuencia
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _IdAnu As Integer = 0
    Private _Folio As String = String.Empty
    Private _NomPromCalle As String = String.Empty
    Private _DomicProm As String = String.Empty
    Private _TelProm As String = String.Empty
    Private _PromFidoc As String = String.Empty
    Private _NumPromFidoc As Integer = 0
    Private _FecEntrega As Date
    Private _FecRecibo As Date
    Private _EstatusAnuencia As String = String.Empty
    Private _NumEstAnu As Integer = 0
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _docdig As String = String.Empty
    Private _Accion As String = String.Empty
    Private _AnuAceptaPresup As Integer = 0
#End Region

#Region "Propiedades"
    Public Property IdSol() As Integer
        Get
            Return _IdSol
        End Get
        Set(ByVal Value As Integer)
            _IdSol = Value
        End Set
    End Property

    Public Property IdAnu() As Integer
        Get
            Return _IdAnu
        End Get
        Set(ByVal Value As Integer)
            _IdAnu = Value
        End Set
    End Property
    Public Property Folio() As String
        Get
            Return _Folio
        End Get
        Set(ByVal Value As String)
            _Folio = Value
        End Set
    End Property

    Public Property NomPromCalle() As String
        Get
            Return _NomPromCalle
        End Get
        Set(ByVal Value As String)
            _NomPromCalle = Value
        End Set
    End Property
    Public Property DomicProm() As String
        Get
            Return _DomicProm
        End Get
        Set(ByVal Value As String)
            _DomicProm = Value
        End Set
    End Property

    Public Property TelProm() As String
        Get
            Return _TelProm
        End Get
        Set(ByVal Value As String)
            _TelProm = Value
        End Set
    End Property

    Public Property PromFidoc() As String
        Get
            Return _PromFidoc
        End Get
        Set(ByVal Value As String)
            _PromFidoc = Value
        End Set
    End Property
    Public Property NumPromFidoc() As Integer
        Get
            Return _NumPromFidoc
        End Get
        Set(ByVal Value As Integer)
            _NumPromFidoc = Value
        End Set
    End Property

    Public Property FecEntrega() As Date
        Get
            Return _FecEntrega
        End Get
        Set(ByVal Value As Date)
            _FecEntrega = Value
        End Set
    End Property
    Public Property FecRecibo() As Date
        Get
            Return _FecRecibo
        End Get
        Set(ByVal Value As Date)
            _FecRecibo = Value
        End Set
    End Property
    Public Property EstatusAnuencia() As String
        Get
            Return _EstatusAnuencia
        End Get
        Set(ByVal Value As String)
            _EstatusAnuencia = Value
        End Set
    End Property
    Public Property NumEstAnu() As Integer
        Get
            Return _NumEstAnu
        End Get
        Set(ByVal Value As Integer)
            _NumEstAnu = Value
        End Set
    End Property
    Public Property UsuCre() As String
        Get
            Return _UsuCre
        End Get
        Set(ByVal Value As String)
            _UsuCre = Value
        End Set
    End Property

    Public Property FecCre() As Date
        Get
            Return _FecCre
        End Get
        Set(ByVal Value As Date)
            _FecCre = Value
        End Set
    End Property

    Public Property UsuMod() As String
        Get
            Return _UsuMod
        End Get
        Set(ByVal Value As String)
            _UsuMod = Value
        End Set
    End Property

    Public Property FecMod() As Date
        Get
            Return _FecMod
        End Get
        Set(ByVal Value As Date)
            _FecMod = Value
        End Set
    End Property
    Public Property docdig() As String
        Get
            Return _docdig
        End Get
        Set(ByVal Value As String)
            _docdig = Value
        End Set
    End Property

    Public Property Accion() As String
        Get
            Return _Accion
        End Get
        Set(ByVal Value As String)
            _Accion = Value
        End Set
    End Property


#End Region

#Region "Metodos"



#End Region
End Class
