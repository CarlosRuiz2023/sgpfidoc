Imports System.Data
Imports System.Data.SqlClient

Public Class clsTiposC
#Region "variables privadas"
    Private _IdTipo As Integer = 0
    Private _Nombre As String = String.Empty
    Private _Ini As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _Accion As String = String.Empty

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdTipo() As String
        Get
            Return _IdTipo
        End Get
        Set(ByVal Value As String)
            _IdTipo = Value
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

    Public Property Ini() As String
        Get
            Return _Ini
        End Get
        Set(ByVal Value As String)
            _Ini = Value
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
#End Region

#Region "Metodos"

    Public Shared Function Consulta_TiposC(ByVal objTipoC As clsTiposC) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdTipo As SqlParameter = New SqlParameter("@idtipo", SqlDbType.Int, 6)
        IdTipo.Value = objTipoC._IdTipo
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 100)
        Nombre.Value = objTipoC._Nombre
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objTipoC._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objTipoC._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objTipoC._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objTipoC._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objTipoC._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdTipo)
        params.Add(Nombre)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_TiposConv", params)
    End Function

    Public Shared Function Insertar(ByVal objTipoC As clsTiposC) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdTipo As SqlParameter = New SqlParameter("@idtipo", SqlDbType.Int, 6)
        IdTipo.Value = objTipoC._IdTipo
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 100)
        Nombre.Value = objTipoC._Nombre

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objTipoC._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objTipoC._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objTipoC._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objTipoC._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objTipoC._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdTipo)
        params.Add(Nombre)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_TiposConv", params)
    End Function

#End Region

End Class
