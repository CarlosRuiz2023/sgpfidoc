Imports System.Data
Imports System.Data.SqlClient

Public Class clsEntregaO
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _FechaE As Date
    Private _Sena As Integer = 0
    Private _Asiste As String = String.Empty
    Private _Accion As String = String.Empty

    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdSol() As Integer
        Get
            Return _IdSol
        End Get
        Set(ByVal Value As Integer)
            _IdSol = Value
        End Set
    End Property

    Public Property FechaE() As Date
        Get
            Return _FechaE
        End Get
        Set(ByVal Value As Date)
            _FechaE = Value
        End Set
    End Property

    Public Property Sena() As Integer
        Get
            Return _Sena
        End Get
        Set(ByVal Value As Integer)
            _Sena = Value
        End Set
    End Property

    Public Property Asiste() As String
        Get
            Return _Asiste
        End Get
        Set(ByVal Value As String)
            _Asiste = Value
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

    Public Shared Function Consulta(ByVal objEntrega As clsEntregaO) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objEntrega._IdSol
        Dim Fechae As SqlParameter = New SqlParameter("@fechae", SqlDbType.Date, 15)
        Fechae.Value = objEntrega._FechaE
        Dim sena As SqlParameter = New SqlParameter("@sena", SqlDbType.Int, 6)
        sena.Value = objEntrega._Sena
        Dim asiste As SqlParameter = New SqlParameter("@asiste", SqlDbType.NVarChar, 200)
        asiste.Value = objEntrega._Asiste
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objEntrega._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objEntrega._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objEntrega._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objEntrega._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objEntrega._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Fechae)
        params.Add(sena)
        params.Add(asiste)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_EntregaO", params)
    End Function

    Public Shared Function Insertar(ByVal objEntrega As clsEntregaO) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objEntrega._IdSol
        Dim Fechae As SqlParameter = New SqlParameter("@fechae", SqlDbType.Date, 15)
        Fechae.Value = objEntrega._FechaE
        Dim sena As SqlParameter = New SqlParameter("@sena", SqlDbType.Int, 6)
        sena.Value = objEntrega._Sena
        Dim asiste As SqlParameter = New SqlParameter("@asiste", SqlDbType.NVarChar, 200)
        asiste.Value = objEntrega._Asiste
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objEntrega._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objEntrega._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objEntrega._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objEntrega._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objEntrega._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Fechae)
        params.Add(sena)
        params.Add(asiste)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_EntregaO", params)
    End Function

#End Region

End Class
