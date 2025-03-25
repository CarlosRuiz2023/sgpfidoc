Imports System.Data

Public Class clsEstado

#Region "variables privadas"
    Private _IdOrigen As Integer = 0
    Private _Nombre As String = String.Empty
    Private _Accion As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdOrigen() As String
        Get
            Return _IdOrigen
        End Get
        Set(ByVal Value As String)
            _IdOrigen = Value
        End Set
    End Property

    Public Property Nombre() As String
        Get
            Return _Nombre
        End Get
        Set(ByVal Value As String)
            _Nombre = Value
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
    Public Shared Function consulta(ByVal objEst As clsEstado) As DataTable
        Dim strQuery As String = _
        "select a.FIDFPA,a.FIDREC,a.FIDIMP,a.FIDSTS from LCSFIDOC.FIDPF003 a inner join LCSFIDOC.FIDPF002 b on a.FIDIDC = b.FIDIDC where a.FIDIDC = 37070"
        Return conn.EjecutarConsultaD(strQuery)
    End Function
    Public Shared Function datos(ByVal objEst As clsEstado) As DataTable
        Dim strQuery As String = _
        "select b.FIDIDC,b.FIDSIS,b.FIDCOO,b.FIDNOM,b.FIDCAL,b.FIDNUE,b.FIDCOL,b.FIDOBR from LCSFIDOC.FIDPF003 as a inner join LCSFIDOC.FIDPF002 as b on a.FIDIDC = b.FIDIDC where a.FIDIDC = 37070"
        Return conn.EjecutarConsultaD(strQuery)
    End Function

#End Region
End Class

