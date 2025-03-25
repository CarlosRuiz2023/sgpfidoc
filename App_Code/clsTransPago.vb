Public Class clsTransPago
#Region "variables privadas"
    Private _fid_o As Integer = 0
    Private _fid_d As Integer = 0
    Private _id_mov As Integer = 0
    Private _monto_trans As Double = 0
    Private _idusu As Integer = 0
    Private _strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property fid_o() As Integer
        Get
            Return _fid_o
        End Get
        Set(ByVal Value As Integer)
            _fid_o = Value
        End Set
    End Property
    Public Property fid_d() As Integer
        Get
            Return _fid_d
        End Get
        Set(ByVal Value As Integer)
            _fid_d = Value
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
    Public Property idusu() As Integer
        Get
            Return _idusu
        End Get
        Set(ByVal Value As Integer)
            _idusu = Value
        End Set
    End Property

    Public Property monto_trans() As Double
        Get
            Return _monto_trans
        End Get
        Set(ByVal Value As Double)
            _monto_trans = Value
        End Set
    End Property

    Public Property strMensaje() As String
        Get
            Return _strMensaje
        End Get
        Set(ByVal Value As String)
            _strMensaje = Value
        End Set
    End Property
#End Region
End Class
