Public Class clsMovtoFinanc2

#Region "variables privadas"
    Private _mov_obra_sifidoc As String = String.Empty
    Private _mov_coop_sifidoc As String = String.Empty
    Private _fec_mov_as400 As Date
    Private _usu_sifidoc As String = String.Empty
    Private _monto_abono_sifidoc As Double = 0
    Private _monto_recargo_sifidoc As Double = 0
    Private _tipo_mov_sifidoc As Integer = 0
    Private _fec_aplic_mov As Date
    Private _clave_sifidoc As String = String.Empty
    Private _consecutivo_sifidoc As Integer = 0
    Private _fid As Integer = 0
    Private _usucre As String = String.Empty
    Private _monto_mov As Double = 0
    Private _tipo_mov As Integer = 0
    Private _id_mov As Integer = 0
    Private _folio_cajas As String = String.Empty
    Private _titulomov As String = String.Empty
    Private _estatus_mov As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property mov_obra_sifidoc() As String
        Get
            Return _mov_obra_sifidoc
        End Get
        Set(ByVal Value As String)
            _mov_obra_sifidoc = Value
        End Set
    End Property
    Public Property mov_coop_sifidoc() As String
        Get
            Return _mov_coop_sifidoc
        End Get
        Set(ByVal Value As String)
            _mov_coop_sifidoc = Value
        End Set
    End Property
    Public Property fec_mov_as400() As Date
        Get
            Return _fec_mov_as400
        End Get
        Set(ByVal Value As Date)
            _fec_mov_as400 = Value
        End Set
    End Property
    Public Property usu_sifidoc() As String
        Get
            Return _usu_sifidoc
        End Get
        Set(ByVal Value As String)
            _usu_sifidoc = Value
        End Set
    End Property
    Public Property monto_abono_sifidoc() As Double
        Get
            Return _monto_abono_sifidoc
        End Get
        Set(ByVal Value As Double)
            _monto_abono_sifidoc = Value
        End Set
    End Property
    Public Property monto_recargo_sifidoc() As Double
        Get
            Return _monto_recargo_sifidoc
        End Get
        Set(ByVal Value As Double)
            _monto_recargo_sifidoc = Value
        End Set
    End Property
    Public Property tipo_mov_sifidoc() As Integer
        Get
            Return _tipo_mov_sifidoc
        End Get
        Set(ByVal Value As Integer)
            _tipo_mov_sifidoc = Value
        End Set
    End Property
    Public Property fec_aplic_mov() As Date
        Get
            Return _fec_aplic_mov
        End Get
        Set(ByVal Value As Date)
            _fec_aplic_mov = Value
        End Set
    End Property
    Public Property clave_sifidoc() As String
        Get
            Return _clave_sifidoc
        End Get
        Set(ByVal Value As String)
            _clave_sifidoc = Value
        End Set
    End Property
    Public Property consecutivo_sifidoc() As Integer
        Get
            Return _consecutivo_sifidoc
        End Get
        Set(ByVal Value As Integer)
            _consecutivo_sifidoc = Value
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
    Public Property usucre() As String
        Get
            Return _usucre
        End Get
        Set(ByVal Value As String)
            _usucre = Value
        End Set
    End Property
    Public Property monto_mov() As Double
        Get
            Return _monto_mov
        End Get
        Set(ByVal Value As Double)
            _monto_mov = Value
        End Set
    End Property
    Public Property tipo_mov() As Integer
        Get
            Return _tipo_mov
        End Get
        Set(ByVal Value As Integer)
            _tipo_mov = Value
        End Set
    End Property
    Public Property id_mov() As Integer
        Get
            Return _id_mov
        End Get
        Set(ByVal Value As Integer)
            _id_mov = Value
        End Set
    End Property
    Public Property folio_cajas() As String
        Get
            Return _folio_cajas
        End Get
        Set(ByVal Value As String)
            _folio_cajas = Value
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
    Public Property estatus_mov() As String
        Get
            Return _estatus_mov
        End Get
        Set(ByVal Value As String)
            _estatus_mov = Value
        End Set
    End Property


#End Region

End Class

