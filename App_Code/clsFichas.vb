Imports System.Data
Imports System.Data.SqlClient

Public Class clsFichas
#Region "variables privadas"
    Private _IdSol As Integer = 0

    Private _FId As Integer = 0
    Private _FFecha As Date
    Private _FPlazo As String = String.Empty
    Private _FCoop As Integer = 0
    Private _FEntrega As String = String.Empty

    Private _Documento As String = String.Empty

    Private _Accion As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property FId() As Integer
        Get
            Return _FId
        End Get
        Set(ByVal Value As Integer)
            _FId = Value
        End Set
    End Property

    Public Property IdSol() As Integer
        Get
            Return _IdSol
        End Get
        Set(ByVal Value As Integer)
            _IdSol = Value
        End Set
    End Property
    Public Property FFecha() As Date
        Get
            Return _FFecha
        End Get
        Set(ByVal Value As Date)
            _FFecha = Value
        End Set
    End Property
    Public Property FPlazo() As String
        Get
            Return _FPlazo
        End Get
        Set(ByVal Value As String)
            _FPlazo = Value
        End Set
    End Property
    Public Property FCoop() As Integer
        Get
            Return _FCoop
        End Get
        Set(ByVal Value As Integer)
            _FCoop = Value
        End Set
    End Property
    Public Property FEntrega() As String
        Get
            Return _FEntrega
        End Get
        Set(ByVal Value As String)
            _FEntrega = Value
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

    Public Property Documento() As String
        Get
            Return _Documento
        End Get
        Set(ByVal Value As String)
            _Documento = Value
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

    Public Shared Function Consultar(ByVal objFichas As clsFichas) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objFichas._IdSol
        Dim FId As SqlParameter = New SqlParameter("@fid", SqlDbType.Int, 6)
        FId.Value = objFichas._FId
        Dim FFecha As SqlParameter = New SqlParameter("@ffecha", SqlDbType.Date, 10)
        FFecha.Value = objFichas._FFecha
        Dim FPlazo As SqlParameter = New SqlParameter("@fplazo", SqlDbType.NVarChar, 20)
        FPlazo.Value = objFichas._FPlazo
        Dim FCoop As SqlParameter = New SqlParameter("@fcoop", SqlDbType.Int, 6)
        FCoop.Value = objFichas._FCoop
        Dim FEntrega As SqlParameter = New SqlParameter("@fentrega", SqlDbType.NVarChar, 20)
        FEntrega.Value = objFichas._FEntrega
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objFichas._Accion

        Dim Documento As SqlParameter = New SqlParameter("@documento", SqlDbType.NVarChar, 255)
        Documento.Value = objFichas._Documento

        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objFichas._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objFichas._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objFichas._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objFichas._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(FId)
        params.Add(FFecha)
        params.Add(FPlazo)
        params.Add(FCoop)
        params.Add(FEntrega)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)


        params.Add(Accion)
        params.Add(Documento)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Fichas", params)
    End Function

    Public Shared Function Insertar(ByVal objFichas As clsFichas) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objFichas._IdSol
        Dim FId As SqlParameter = New SqlParameter("@fid", SqlDbType.Int, 6)
        FId.Value = objFichas._FId
        Dim FFecha As SqlParameter = New SqlParameter("@ffecha", SqlDbType.Date, 10)
        FFecha.Value = objFichas._FFecha
        Dim FPlazo As SqlParameter = New SqlParameter("@fplazo", SqlDbType.NVarChar, 20)
        FPlazo.Value = objFichas._FPlazo
        Dim FCoop As SqlParameter = New SqlParameter("@fcoop", SqlDbType.Int, 6)
        FCoop.Value = objFichas._FCoop
        Dim FEntrega As SqlParameter = New SqlParameter("@fentrega", SqlDbType.NVarChar, 20)
        FEntrega.Value = objFichas._FEntrega

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objFichas._Accion

        Dim Documento As SqlParameter = New SqlParameter("@documento", SqlDbType.NVarChar, 255)
        Documento.Value = objFichas._Documento

        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objFichas._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objFichas._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objFichas._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objFichas._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(FId)
        params.Add(FFecha)
        params.Add(FPlazo)
        params.Add(FCoop)
        params.Add(FEntrega)

        params.Add(Accion)
        params.Add(Documento)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Fichas", params)
    End Function

#End Region

End Class

