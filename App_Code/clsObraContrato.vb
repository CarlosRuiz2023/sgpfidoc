Public Class clsObraContrato

#Region "variables privadas"
    Private _oid As Integer = 0
    Private _obr_clv_int As Integer = 0
    Private _obr_clv As String = String.Empty
    Private _idcontrato As Integer = 0
    Private _num_contrato As String = String.Empty
    Private _calle As String = String.Empty
    Private _colonia As String = String.Empty
    Private _tramo As String = String.Empty
    Private _idprog As Integer = 0
    Private _nomprog As String = String.Empty
    Private _docto_contrato As String = String.Empty
    Private _idanexo_contrato As Integer = 0
    Private _docto_param1 As String = String.Empty
    Private _fecha_param2 As Date
    Private _valor_param3 As Integer = 0
    Private _valor_param4 As Double = 0
    Private _idtipo_anexo_contrato As Integer
    Private _etiqueta_anexo As String = String.Empty
    Private _idusu As Integer = 0
    Private _accion As Integer = 0
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property oid() As Integer
        Get
            Return _oid
        End Get
        Set(ByVal Value As Integer)
            _oid = Value
        End Set
    End Property
    Public Property obr_clv_int() As Integer
        Get
            Return _obr_clv_int
        End Get
        Set(ByVal Value As Integer)
            _obr_clv_int = Value
        End Set
    End Property

    Public Property obr_clv() As String
        Get
            Return _obr_clv
        End Get
        Set(ByVal Value As String)
            _obr_clv = Value
        End Set
    End Property

    Public Property idcontrato() As Integer
        Get
            Return _idcontrato
        End Get
        Set(ByVal Value As Integer)
            _idcontrato = Value
        End Set
    End Property

    Public Property num_contrato() As String
        Get
            Return _num_contrato
        End Get
        Set(ByVal Value As String)
            _num_contrato = Value
        End Set
    End Property
    Public Property calle() As String
        Get
            Return _calle
        End Get
        Set(ByVal Value As String)
            _calle = Value
        End Set
    End Property
    Public Property colonia() As String
        Get
            Return _colonia
        End Get
        Set(ByVal Value As String)
            _colonia = Value
        End Set
    End Property

    Public Property tramo() As String
        Get
            Return _tramo
        End Get
        Set(ByVal Value As String)
            _tramo = Value
        End Set
    End Property

    Public Property idprog() As Integer
        Get
            Return _idprog
        End Get
        Set(ByVal Value As Integer)
            _idprog = Value
        End Set
    End Property

    Public Property nomprog() As String
        Get
            Return _nomprog
        End Get
        Set(ByVal Value As String)
            _nomprog = Value
        End Set
    End Property

    Public Property docto_contrato() As String
        Get
            Return _docto_contrato
        End Get
        Set(ByVal Value As String)
            _docto_contrato = Value
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

    Public Property idtipo_anexo_contrato() As Integer
        Get
            Return _idtipo_anexo_contrato
        End Get
        Set(ByVal Value As Integer)
            _idtipo_anexo_contrato = Value
        End Set
    End Property

    Public Property etiqueta_anexo() As String
        Get
            Return _etiqueta_anexo
        End Get
        Set(ByVal Value As String)
            _etiqueta_anexo = Value
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
