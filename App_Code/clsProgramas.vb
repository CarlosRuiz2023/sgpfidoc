Imports System.Data
Imports System.Data.SqlClient

Public Class clsProgramas
#Region "variables privadas"
    Private _IdPrograma As Integer = 0
    Private _Nombre As String = String.Empty
    Private _Descripcion As String = String.Empty
    Private _Municipio As Integer = 0
    Private _Coop As Integer = 0
    Private _Accion As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _Activo As Integer = 0

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdPrograma() As String
        Get
            Return _IdPrograma
        End Get
        Set(ByVal Value As String)
            _IdPrograma = Value
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

    Public Property Descripcion() As String
        Get
            Return _Descripcion
        End Get
        Set(ByVal Value As String)
            _Descripcion = Value
        End Set
    End Property

    Public Property Municipio() As String
        Get
            Return _Municipio
        End Get
        Set(ByVal Value As String)
            _Municipio = Value
        End Set
    End Property

    Public Property Coop() As String
        Get
            Return _Coop
        End Get
        Set(ByVal Value As String)
            _Coop = Value
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

    Public Shared Function Consulta_Estatus(ByVal objProgramas As clsProgramas) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdPrograma As SqlParameter = New SqlParameter("@idprograma", SqlDbType.Int, 6)
        IdPrograma.Value = objProgramas._IdPrograma
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 100)
        Nombre.Value = objProgramas._Nombre
        Dim Descripcion As SqlParameter = New SqlParameter("@descripcion", SqlDbType.NVarChar, 150)
        Descripcion.Value = objProgramas._Descripcion
        Dim Municipio As SqlParameter = New SqlParameter("@municipio", SqlDbType.Int, 6)
        Municipio.Value = objProgramas._Municipio
        Dim Coop As SqlParameter = New SqlParameter("@coop", SqlDbType.Int, 6)
        Coop.Value = objProgramas._Coop
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objProgramas._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objProgramas._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objProgramas._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objProgramas._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objProgramas._FecMod
        Dim activo As SqlParameter = New SqlParameter("@activo", SqlDbType.Int, 6)
        activo.Value = objProgramas._Activo

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdPrograma)
        params.Add(Nombre)
        params.Add(Descripcion)
        params.Add(Municipio)
        params.Add(Coop)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(activo)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Programas", params)
    End Function

    Public Shared Function Insertar(ByVal objProgramas As clsProgramas) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdPrograma As SqlParameter = New SqlParameter("@idprograma", SqlDbType.Int, 6)
        IdPrograma.Value = objProgramas._IdPrograma
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 100)
        Nombre.Value = objProgramas._Nombre
        Dim Descripcion As SqlParameter = New SqlParameter("@descripcion", SqlDbType.NVarChar, 150)
        Descripcion.Value = objProgramas._Descripcion
        Dim Municipio As SqlParameter = New SqlParameter("@municipio", SqlDbType.Int, 6)
        Municipio.Value = objProgramas._Municipio
        Dim Coop As SqlParameter = New SqlParameter("@coop", SqlDbType.Int, 6)
        Coop.Value = objProgramas._Coop
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objProgramas._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objProgramas._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objProgramas._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objProgramas._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objProgramas._FecMod
        Dim activo As SqlParameter = New SqlParameter("@activo", SqlDbType.Int, 6)
        activo.Value = objProgramas._Activo

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdPrograma)
        params.Add(Nombre)
        params.Add(Descripcion)
        params.Add(Municipio)
        params.Add(Coop)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(activo)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Programas", params)
    End Function

#End Region

End Class
