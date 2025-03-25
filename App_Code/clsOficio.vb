Imports System.Data
Imports System.Data.SqlClient

Public Class clsOficio
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _Estatus As String = String.Empty
    Private _FechaE As Date
    Private _FechaA As Date
    Private _Quien As String = String.Empty
    Private _FechaR As Date
    Private _Documento As String = String.Empty
    Private _Oficio As String = String.Empty
    Private _Usu As Integer = 0
    Private _Accion As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdSol() As String
        Get
            Return _IdSol
        End Get
        Set(ByVal Value As String)
            _IdSol = Value
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
    Public Property FechaE() As String
        Get
            Return _FechaE
        End Get
        Set(ByVal Value As String)
            _FechaE = Value
        End Set
    End Property
    Public Property FechaA() As String
        Get
            Return _FechaA
        End Get
        Set(ByVal Value As String)
            _FechaA = Value
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
    Public Property FechaR() As String
        Get
            Return _FechaR
        End Get
        Set(ByVal Value As String)
            _FechaR = Value
        End Set
    End Property

    Public Property Documento() As String
        Get
            Return _Documento
        End Get
        Set(ByVal Value As String)
            _Documento = Value
        End Set
    End Property

    Public Property Oficio() As String
        Get
            Return _Oficio
        End Get
        Set(ByVal Value As String)
            _Oficio = Value
        End Set
    End Property
    Public Property Usu() As Integer
        Get
            Return _Usu
        End Get
        Set(ByVal Value As Integer)
            _Usu = Value
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
    Public Shared Function Consulta(ByVal objOficio As clsOficio) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objOficio._IdSol
        Dim Estatus As SqlParameter = New SqlParameter("@estatus", SqlDbType.NVarChar, 15)
        Estatus.Value = objOficio._Estatus
        Dim FechaE As SqlParameter = New SqlParameter("@fechae", SqlDbType.Date, 10)
        FechaE.Value = objOficio._FechaE
        Dim FechaA As SqlParameter = New SqlParameter("@fechaa", SqlDbType.Date, 10)
        FechaA.Value = objOficio._FechaA
        Dim Quien As SqlParameter = New SqlParameter("@quien", SqlDbType.NVarChar, 150)
        Quien.Value = objOficio._Quien
        Dim Documento As SqlParameter = New SqlParameter("@documento", SqlDbType.NVarChar, 250)
        Documento.Value = objOficio._Documento
        Dim oficio As SqlParameter = New SqlParameter("@oficio", SqlDbType.NVarChar, 50)
        oficio.Value = objOficio._Oficio
        Dim FechaR As SqlParameter = New SqlParameter("@fechar", SqlDbType.Date, 10)
        FechaR.Value = objOficio._FechaR
        Dim Usu As SqlParameter = New SqlParameter("@usu", SqlDbType.Int, 6)
        Usu.Value = objOficio._Usu
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 20)
        Accion.Value = objOficio._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objOficio._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objOficio._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objOficio._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objOficio._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Estatus)
        params.Add(FechaE)
        params.Add(FechaA)
        params.Add(Quien)
        params.Add(Documento)
        params.Add(FechaR)
        params.Add(oficio)
        params.Add(Usu)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Oficio", params)
    End Function

    Public Shared Function Insertar(ByVal objOficio As clsOficio) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objOficio._IdSol
        Dim Estatus As SqlParameter = New SqlParameter("@estatus", SqlDbType.NVarChar, 15)
        Estatus.Value = objOficio._Estatus
        Dim FechaE As SqlParameter = New SqlParameter("@fechae", SqlDbType.Date, 10)
        FechaE.Value = objOficio._FechaE
        Dim FechaA As SqlParameter = New SqlParameter("@fechaa", SqlDbType.Date, 10)
        FechaA.Value = objOficio._FechaA
        Dim Quien As SqlParameter = New SqlParameter("@quien", SqlDbType.NVarChar, 150)
        Quien.Value = objOficio._Quien
        Dim Documento As SqlParameter = New SqlParameter("@documento", SqlDbType.NVarChar, 250)
        Documento.Value = objOficio._Documento
        Dim FechaR As SqlParameter = New SqlParameter("@fechar", SqlDbType.Date, 10)
        FechaR.Value = objOficio._FechaR
        Dim oficio As SqlParameter = New SqlParameter("@oficio", SqlDbType.NVarChar, 50)
        oficio.Value = objOficio._Oficio
        Dim Usu As SqlParameter = New SqlParameter("@usu", SqlDbType.Int, 6)
        Usu.Value = objOficio._Usu
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 20)
        Accion.Value = objOficio._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objOficio._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objOficio._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objOficio._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objOficio._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Estatus)
        params.Add(FechaE)
        params.Add(FechaA)
        params.Add(Quien)
        params.Add(Documento)
        params.Add(FechaR)
        params.Add(oficio)
        params.Add(Usu)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Oficio", params)
    End Function
#End Region

End Class
