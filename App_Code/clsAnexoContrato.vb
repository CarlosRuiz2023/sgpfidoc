Public Class clsAnexoContrato
#Region "variables privadas"
    Private _idcontrato As Integer = 0
    Private _idanexo_contrato As Integer = 0
    Private _idtipo_anexo_contrato As Integer = 0
    Private _etiqueta_anexo_contrato As String = String.Empty
    Private _docto_param1 As String = String.Empty
    Private _fecha_param2 As Date
    Private _valor_param3 As Integer = 0
    Private _valor_param4 As Double = 0
    Private _usu_cre As Integer = 0
    Private _usu_mod As Integer = 0
    Private _fec_cre As Date
    Private _fec_mod As Date
    Private _cactivo As Integer = 0
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property idcontrato() As Integer
        Get
            Return _idcontrato
        End Get
        Set(ByVal Value As Integer)
            _idcontrato = Value
        End Set
    End Property
    Public Property idanexo_contrato() As Integer
        Get
            Return _idanexo_contrato
        End Get
        Set(ByVal Value As Integer)
            _idanexo_contrato = Value
        End Set
    End Property
    Public Property idtipo_anexo_contrato() As Integer
        Get
            Return _idtipo_anexo_contrato
        End Get
        Set(ByVal Value As Integer)
            _idtipo_anexo_contrato = Value
        End Set
    End Property
    Public Property etiqueta_anexo_contrato() As String
        Get
            Return _etiqueta_anexo_contrato
        End Get
        Set(ByVal Value As String)
            _etiqueta_anexo_contrato = Value
        End Set
    End Property
    Public Property docto_param1() As String
        Get
            Return _docto_param1
        End Get
        Set(ByVal Value As String)
            _docto_param1 = Value
        End Set
    End Property
    Public Property fecha_param2() As Date
        Get
            Return _fecha_param2
        End Get
        Set(ByVal Value As Date)
            _fecha_param2 = Value
        End Set
    End Property
    Public Property valor_param3() As Integer
        Get
            Return _valor_param3
        End Get
        Set(ByVal Value As Integer)
            _valor_param3 = Value
        End Set
    End Property
    Public Property valor_param4() As Double
        Get
            Return _valor_param4
        End Get
        Set(ByVal Value As Double)
            _valor_param4 = Value
        End Set
    End Property
    Public Property usu_cre() As Integer
        Get
            Return _usu_cre
        End Get
        Set(ByVal Value As Integer)
            _usu_cre = Value
        End Set
    End Property
    Public Property usu_mod() As Integer
        Get
            Return _usu_mod
        End Get
        Set(ByVal Value As Integer)
            _usu_mod = Value
        End Set
    End Property
    Public Property fec_cre() As Date
        Get
            Return _fec_cre
        End Get
        Set(ByVal Value As Date)
            _fec_cre = Value
        End Set
    End Property
    Public Property fec_mod() As Date
        Get
            Return _fec_mod
        End Get
        Set(ByVal Value As Date)
            _fec_mod = Value
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
    Public Property accion() As Integer
        Get
            Return _accion
        End Get
        Set(ByVal Value As Integer)
            _accion = Value
        End Set
    End Property
#End Region

End Class
