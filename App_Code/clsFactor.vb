Imports System.Data
Imports System.Data.SqlClient

Public Class clsFactor

#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _Factor As Integer = 0
    Private _Bene As Integer = 0
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

    Public Property Factor() As Integer
        Get
            Return _Factor
        End Get
        Set(ByVal Value As Integer)
            _Factor = Value
        End Set
    End Property

    Public Property Bene() As Integer
        Get
            Return _Bene
        End Get
        Set(ByVal Value As Integer)
            _Bene = Value
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
    Public Shared Function Consulta(ByVal objFac As clsFactor) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objFac._IdSol
        Dim Factor As SqlParameter = New SqlParameter("@factor", SqlDbType.Int, 6)
        Factor.Value = objFac._Factor
        Dim Bene As SqlParameter = New SqlParameter("@bene", SqlDbType.Int, 6)
        Bene.Value = objFac._Bene

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objFac._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objFac._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objFac._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objFac._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objFac._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Factor)
        params.Add(Bene)

        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Factor", params)
    End Function

    Public Shared Function Insertar(ByVal objFac As clsFactor) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objFac._IdSol
        Dim Factor As SqlParameter = New SqlParameter("@factor", SqlDbType.Int, 6)
        Factor.Value = objFac._Factor
        Dim Bene As SqlParameter = New SqlParameter("@bene", SqlDbType.Int, 6)
        Bene.Value = objFac._Bene

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objFac._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objFac._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objFac._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objFac._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objFac._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Factor)
        params.Add(Bene)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Factor", params)
    End Function

#End Region
End Class

