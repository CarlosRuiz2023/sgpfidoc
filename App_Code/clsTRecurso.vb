Imports System.Data
Imports System.Data.SqlClient

Public Class clsTRecurso
#Region "variables privadas"
    Private _IdTipo As Integer = 0
    Private _Nombre As String = String.Empty
    Private _Activo As Integer = 0
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _Accion As String = String.Empty

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdTipo() As Integer
        Get
            Return _IdTipo
        End Get
        Set(ByVal Value As Integer)
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


    Public Property Activo() As Integer
        Get
            Return _Activo
        End Get
        Set(ByVal Value As Integer)
            _Activo = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consulta(ByVal objTipoR As clsTRecurso) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdTipo As SqlParameter = New SqlParameter("@idtipo", SqlDbType.Int, 6)
        IdTipo.Value = objTipoR._IdTipo
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 100)
        Nombre.Value = objTipoR._Nombre
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objTipoR._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objTipoR._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objTipoR._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objTipoR._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objTipoR._FecMod
        Dim Activo As SqlParameter = New SqlParameter("@activo", SqlDbType.Int, 6)
        Activo.Value = objTipoR._Activo

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdTipo)
        params.Add(Nombre)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Activo)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_TiposR", params)
    End Function

    Public Shared Function Insertar(ByVal objTipoR As clsTRecurso) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdTipo As SqlParameter = New SqlParameter("@idtipo", SqlDbType.Int, 6)
        IdTipo.Value = objTipoR._IdTipo
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 100)
        Nombre.Value = objTipoR._Nombre

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objTipoR._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objTipoR._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objTipoR._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objTipoR._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objTipoR._FecMod
        Dim Activo As SqlParameter = New SqlParameter("@activo", SqlDbType.Int, 6)
        Activo.Value = objTipoR._Activo

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdTipo)
        params.Add(Nombre)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Activo)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_TiposR", params)
    End Function

#End Region
End Class
