Imports System.Data
Imports System.Data.SqlClient

Public Class clsControlO
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _FechaV As Date
    Private _FechaE As Date
    Private _Quien As String = String.Empty
    Private _Nota As String = String.Empty
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

    Public Property FechaV() As Date
        Get
            Return _FechaV
        End Get
        Set(ByVal Value As Date)
            _FechaV = Value
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
    Public Property Quien() As String
        Get
            Return _Quien
        End Get
        Set(ByVal Value As String)
            _Quien = Value
        End Set
    End Property
    Public Property Nota() As String
        Get
            Return _Nota
        End Get
        Set(ByVal Value As String)
            _Nota = Value
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

    Public Shared Function Consulta(ByVal objCon As clsControlO) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objCon._IdSol
        Dim Fechav As SqlParameter = New SqlParameter("@fechav", SqlDbType.Date, 15)
        Fechav.Value = objCon._FechaV
        Dim Fechae As SqlParameter = New SqlParameter("@fechae", SqlDbType.Date, 15)
        Fechae.Value = objCon._FechaE
        Dim Quien As SqlParameter = New SqlParameter("@quien", SqlDbType.NVarChar, 50)
        Quien.Value = objCon._Quien
        Dim Nota As SqlParameter = New SqlParameter("@nota", SqlDbType.NVarChar, 250)
        Nota.Value = objCon._Nota
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objCon._Accion

        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objCon._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objCon._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objCon._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objCon._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Fechav)
        params.Add(Fechae)
        params.Add(Quien)
        params.Add(Nota)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Control", params)
    End Function

    Public Shared Function Insertar(ByVal objCon As clsControlO) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objCon._IdSol
        Dim Fechav As SqlParameter = New SqlParameter("@fechav", SqlDbType.Date, 15)
        Fechav.Value = objCon._FechaV
        Dim Fechae As SqlParameter = New SqlParameter("@fechae", SqlDbType.Date, 15)
        Fechae.Value = objCon._FechaE
        Dim Quien As SqlParameter = New SqlParameter("@quien", SqlDbType.NVarChar, 50)
        Quien.Value = objCon._Quien
        Dim Nota As SqlParameter = New SqlParameter("@nota", SqlDbType.NVarChar, 250)
        Nota.Value = objCon._Nota
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objCon._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objCon._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objCon._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objCon._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objCon._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Fechav)
        params.Add(Fechae)
        params.Add(Quien)
        params.Add(Nota)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Control", params)
    End Function

#End Region

End Class
