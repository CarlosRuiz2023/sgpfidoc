Imports System.Data
Imports System.Data.SqlClient
Public Class clsPreobras
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _Longitud As Integer = 0
    Private _IdEstatus As Integer = 0
    Private _Calle As String = String.Empty
    Private _Colonia As String = String.Empty
    Private _Tramo As String = String.Empty
    Private _NomSolicitante As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _FecSol As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private strMensaje As String = String.Empty
    Private _Accion As String = String.Empty

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
    Public Property Longitud() As String
        Get
            Return _Longitud
        End Get
        Set(ByVal Value As String)
            _Longitud = Value
        End Set
    End Property
    Public Property IdEstatus() As Integer
        Get
            Return _IdEstatus
        End Get
        Set(ByVal Value As Integer)
            _IdEstatus = Value
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
    Public Property FecSol() As Date
        Get
            Return _FecSol
        End Get
        Set(ByVal Value As Date)
            _FecSol = Value
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

    Public Property Tramo() As String
        Get
            Return _Tramo
        End Get
        Set(ByVal Value As String)
            _Tramo = Value
        End Set
    End Property
    Public Property NomSolicitante() As String
        Get
            Return _NomSolicitante
        End Get
        Set(ByVal Value As String)
            _NomSolicitante = Value
        End Set
    End Property
    Public Property Calle() As String
        Get
            Return _Calle
        End Get
        Set(ByVal Value As String)
            _Calle = Value
        End Set
    End Property

    Public Property Colonia() As String
        Get
            Return _Colonia
        End Get
        Set(ByVal Value As String)
            _Colonia = Value
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

    Public Property Mensaje() As String
        Get
            Return strMensaje
        End Get
        Set(ByVal Value As String)
            strMensaje = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consulta_Preobras(ByVal objPreobras As clsPreobras, ByRef tbl As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)
        Dim strMensaje As String = String.Empty
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objPreobras._IdSol
        Dim Longitud As SqlParameter = New SqlParameter("@longitud", SqlDbType.Int, 6)
        Longitud.Value = objPreobras._Longitud
        Dim IdEstatusSol As SqlParameter = New SqlParameter("@EstatusSol", SqlDbType.Int, 6)
        IdEstatusSol.Value = objPreobras._IdEstatus
        Dim NomSolicitante As SqlParameter = New SqlParameter("@NombreSol", SqlDbType.NVarChar, 200)
        NomSolicitante.Value = objPreobras._NomSolicitante
        Dim Calle As SqlParameter = New SqlParameter("@calle", SqlDbType.NVarChar, 200)
        Calle.Value = objPreobras._Calle
        Dim Colonia As SqlParameter = New SqlParameter("@colonia", SqlDbType.NVarChar, 200)
        Colonia.Value = objPreobras._Colonia
        Dim Tramo As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 200)
        Tramo.Value = objPreobras._Tramo
        Dim FecSol As SqlParameter = New SqlParameter("@fecsol", SqlDbType.Date, 10)
        FecSol.Value = objPreobras._FecSol
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objPreobras._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objPreobras._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objPreobras._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objPreobras._FecMod
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objPreobras._Accion
        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Longitud)
        params.Add(IdEstatusSol)
        params.Add(NomSolicitante)
        params.Add(Calle)
        params.Add(Colonia)
        params.Add(Tramo)
        params.Add(FecSol)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)

        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_Preobras", params, objPreobras.Mensaje, tbl)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objPreobras.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objPreobras.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objPreobras.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objPreobras.strMensaje = intError & " - " & objPreobras.strMensaje
            End Select
            Return False
        Else
            objPreobras.strMensaje = "OK"
            Return True
        End If
    End Function
#End Region
End Class
