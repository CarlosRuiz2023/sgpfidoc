Public Class clsPago
#Region "variables privadas"
    Public _coop_s As string = String.Empty
    Public _obra_s As String = String.Empty
    Public _fec_as400 As Date
    Public _usu_fidoc As String = String.Empty
    Public _importe As Double = 0.0
    Public _tipo_mov As Integer = 0
    Public _obra_coop_s As String = String.Empty
    Public _fid As Integer = 0
    Public _usucre AS String = String.Empty
    Public _p2_recibo AS String = String.Empty
    Public _recibo AS String = String.Empty
    Public _obr_clv_int AS Integer = 0
    Public _mov_activo AS Integer = 0
    Public _nombre AS String = String.Empty
    Public _elemento AS String = String.Empty
#End Region

#Region "Propiedades"
    Public Property Coops_s() As String
        Get
            Return _coop_s
        End Get
        Set(ByVal Value As String)
            _coop_s = Value
        End Set
    End Property
    Public Property Obra_s() As String
        Get
            Return _obra_s
        End Get
        Set(ByVal Value As String)
            _obra_s = Value
        End Set
    End Property
    Public Property Fec_as400() As Date
        Get
            Return _fec_as400
        End Get
        Set(ByVal Value As Date)
            _fec_as400 = Value
        End Set
    End Property
    Public Property Usu_fidoc() As String
        Get
            Return _usu_fidoc
        End Get
        Set(ByVal Value As String)
            _usu_fidoc = Value
        End Set
    End Property
    Public Property Importe() As Double
        Get
            Return _importe
        End Get
        Set(ByVal Value As Double)
            _importe = Value
        End Set
    End Property
    Public Property Tipo_mov() As Integer
        Get
            Return _tipo_mov
        End Get
        Set(ByVal Value As Integer)
            _tipo_mov = Value
        End Set
    End Property
    Public Property Obra_coop_s() As String
        Get
            Return _obra_coop_s
        End Get
        Set(ByVal Value As String)
            _obra_coop_s = Value
        End Set
    End Property
    Public Property Fid() As Integer
        Get
            Return _fid
        End Get
        Set(ByVal Value As Integer)
            _fid = Value
        End Set
    End Property
    Public Property Usucre() As String
        Get
            Return _usucre
        End Get
        Set(ByVal Value As String)
            _usucre = Value
        End Set
    End Property
    Public Property P2_recibo() As String
        Get
            Return _p2_recibo
        End Get
        Set(ByVal Value As String)
            _p2_recibo = Value
        End Set
    End Property
    Public Property Recibo() As String
        Get
            Return _recibo
        End Get
        Set(ByVal Value As String)
            _recibo = Value
        End Set
    End Property
    Public Property Obr_clv_int() As Integer
        Get
            Return _obr_clv_int
        End Get
        Set(ByVal Value As Integer)
            _obr_clv_int = Value
        End Set
    End Property
    Public Property Mov_activo() As Integer
        Get
            Return _mov_activo
        End Get
        Set(ByVal Value As Integer)
            _mov_activo = Value
        End Set
    End Property
    Public Property Nombre() As String
        Get
            Return _nombre
        End Get
        Set(ByVal Value As String)
            _nombre = Value
        End Set
    End Property
    Public Property Elemento() As String
        Get
            Return _elemento
        End Get
        Set(ByVal Value As String)
            _elemento = Value
        End Set
    End Property
#End Region
End Class
