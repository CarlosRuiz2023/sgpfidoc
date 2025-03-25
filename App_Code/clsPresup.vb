Public Class clsPresup
#Region "variables privadas"
    Private _CostoMtoLineal As Double = 0
    Private _Dcto As String = String.Empty
    Private _ProgId As Integer = 0
    Private _MtsSeccion As Double = 0
    Private _MtsBanqueta As Double = 0
    Private _MtsArroyo As Double = 0
    Private _GastosAdmvos As Double = 0
    Private _Folio As String = String.Empty
    Private _Mts2Arroyo As Double = 0
    Private _Mts2Banqueta As Double = 0
    Private _DerramaVecinos As Double = 0
    Private _DerramaEU As Double = 0
    Private _EstatusPresup As Integer = 0
    Private _IdPresup As Integer = 0
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _oid As Integer = 0
    Private _solid As Integer = 0
    Private _IdPresupR As Integer = 0
    Private _CostoTotalObra As Double = 0
    Private _Accion As Integer = 0
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"


    Public Property CostoMtoLineal() As Double
        Get
            Return _CostoMtoLineal
        End Get
        Set(ByVal Value As Double)
            _CostoMtoLineal = Value
        End Set
    End Property
    Public Property CostoTotalObra() As Double
        Get
            Return _CostoTotalObra
        End Get
        Set(ByVal Value As Double)
            _CostoTotalObra = Value
        End Set
    End Property
    Public Property Dcto() As String
        Get
            Return _Dcto
        End Get
        Set(ByVal Value As String)
            _Dcto = Value
        End Set
    End Property
    Public Property ProgId() As Integer
        Get
            Return _ProgId
        End Get
        Set(ByVal Value As Integer)
            _ProgId = Value
        End Set
    End Property
    Public Property MtsSeccion() As Double
        Get
            Return _MtsSeccion
        End Get
        Set(ByVal Value As Double)
            _MtsSeccion = Value
        End Set
    End Property
    Public Property MtsBanqueta() As Double
        Get
            Return _MtsBanqueta
        End Get
        Set(ByVal Value As Double)
            _MtsBanqueta = Value
        End Set
    End Property
    Public Property MtsArroyo() As Double
        Get
            Return _MtsArroyo
        End Get
        Set(ByVal Value As Double)
            _MtsArroyo = Value
        End Set
    End Property
    Public Property GastosAdmvos() As Double
        Get
            Return _GastosAdmvos
        End Get
        Set(ByVal Value As Double)
            _GastosAdmvos = Value
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
    Public Property Mts2Arroyo() As Double
        Get
            Return _Mts2Arroyo
        End Get
        Set(ByVal Value As Double)
            _Mts2Arroyo = Value
        End Set
    End Property
    Public Property Mts2Banqueta() As Double
        Get
            Return _Mts2Banqueta
        End Get
        Set(ByVal Value As Double)
            _Mts2Banqueta = Value
        End Set
    End Property
    Public Property DerramaVecinos() As Double
        Get
            Return _DerramaVecinos
        End Get
        Set(ByVal Value As Double)
            _DerramaVecinos = Value
        End Set
    End Property
    Public Property DerramaEU() As Double
        Get
            Return _DerramaEU
        End Get
        Set(ByVal Value As Double)
            _DerramaEU = Value
        End Set
    End Property
    Public Property EstatusPresup() As Integer
        Get
            Return _EstatusPresup
        End Get
        Set(ByVal Value As Integer)
            _EstatusPresup = Value
        End Set
    End Property

    Public Property IdPresup() As Integer
        Get
            Return _IdPresup
        End Get
        Set(ByVal Value As Integer)
            _IdPresup = Value
        End Set
    End Property


    Public Property IdPresupR() As Integer
        Get
            Return _IdPresupR
        End Get
        Set(ByVal Value As Integer)
            _IdPresupR = Value
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

    Property oid As Integer
        Get
            Return _oid
        End Get
        Set(value As Integer)
            _oid = value
        End Set
    End Property

    Property solid As Integer
        Get
            Return _solid
        End Get
        Set(value As Integer)
            _solid = value
        End Set
    End Property

    Property Accion As Integer
        Get
            Return _Accion
        End Get
        Set(value As Integer)
            _Accion = value
        End Set
    End Property
    Property Mensaje() As String
        ' la parte Get es la que devuelve el valor de la propiedad
        Get
            Return strMensaje
        End Get
        ' la parte Set es la que se usa al asignar el nuevo valor
        Set(ByVal Value As String)
            If Value <> "" Then
                strMensaje = Value
            End If
        End Set
    End Property



#End Region

#Region "Metodos"


#End Region

End Class


