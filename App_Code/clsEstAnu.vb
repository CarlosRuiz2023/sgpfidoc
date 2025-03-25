Imports System.Data
Imports System.Data.SqlClient

Public Class clsEstAnu
#Region "variables privadas"
    Private _IdEstatus As Integer = 0
    Private _Estatus As String = String.Empty
    Private _Accion As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdEstatus() As String
        Get
            Return _IdEstatus
        End Get
        Set(ByVal Value As String)
            _IdEstatus = Value
        End Set
    End Property

    Public Property Estatus() As String
        Get
            Return _Estatus
        End Get
        Set(ByVal Value As String)
            _Estatus = Value
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

    Public Shared Function Consulta_Estatus(ByVal objEstatus As clsEstAnu) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdEstatus As SqlParameter = New SqlParameter("@idestatus", SqlDbType.Int, 6)
        IdEstatus.Value = objEstatus._IdEstatus
        Dim Estatus As SqlParameter = New SqlParameter("@estatus", SqlDbType.NVarChar, 50)
        Estatus.Value = objEstatus._Estatus
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objEstatus._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objEstatus._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objEstatus._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objEstatus._FecMod
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objEstatus._Accion

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdEstatus)
        params.Add(Estatus)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Accion)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_EstatusAnu", params)
    End Function

    Public Shared Function Insertar(ByVal objEstatus As clsEstAnu) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdEstatus As SqlParameter = New SqlParameter("@idestatus", SqlDbType.Int, 6)
        IdEstatus.Value = objEstatus._IdEstatus
        Dim Estatus As SqlParameter = New SqlParameter("@estatus", SqlDbType.NVarChar, 50)
        Estatus.Value = objEstatus._Estatus
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objEstatus._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objEstatus._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objEstatus._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objEstatus._FecMod
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objEstatus._Accion

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdEstatus)
        params.Add(Estatus)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Accion)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_EstatusAnu", params)
    End Function

#End Region
End Class
