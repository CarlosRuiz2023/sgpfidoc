Imports System.Data
Imports System.Data.SqlClient


Public Class clsOrigen

#Region "variables privadas"
    Private _IdOrigen As Integer = 0
    Private _Nombre As String = String.Empty
    Private _Accion As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _Activo As Integer = 0
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdOrigen() As String
        Get
            Return _IdOrigen
        End Get
        Set(ByVal Value As String)
            _IdOrigen = Value
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

    Public Property Activo() As Integer
        Get
            Return _Activo
        End Get
        Set(ByVal Value As Integer)
            _Activo = Value
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

    Public Shared Function Consulta(ByVal objOrigen As clsOrigen, ByRef tbl As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdOrigen As SqlParameter = New SqlParameter("@idorigen", SqlDbType.Int, 6)
        IdOrigen.Value = objOrigen._IdOrigen
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 100)
        Nombre.Value = objOrigen._Nombre
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objOrigen._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objOrigen._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objOrigen._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objOrigen._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objOrigen._FecMod
        Dim Activo As SqlParameter = New SqlParameter("@activo", SqlDbType.Int, 6)
        Activo.Value = objOrigen._Activo
        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        '---

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdOrigen)
        params.Add(Nombre)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Activo)
        params.Add(parIdError)
        params.Add(parDesError)

        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_Origen", params, objOrigen.Mensaje, tbl)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objOrigen.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objOrigen.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objOrigen.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objOrigen.strMensaje = intError & " - " & objOrigen.strMensaje
            End Select
            Return False
        Else
            objOrigen.strMensaje = "OK"
            Return True
        End If
    End Function


    Public Shared Function Insertar(ByVal objOrigen As clsOrigen) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdOrigen As SqlParameter = New SqlParameter("@idorigen", SqlDbType.Int, 6)
        IdOrigen.Value = objOrigen._IdOrigen
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 100)
        Nombre.Value = objOrigen._Nombre
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objOrigen._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objOrigen._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objOrigen._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objOrigen._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objOrigen._FecMod
        Dim Activo As SqlParameter = New SqlParameter("@activo", SqlDbType.Int, 6)
        Activo.Value = objOrigen._Activo

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdOrigen)
        params.Add(Nombre)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Activo)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Origen", params)
    End Function

#End Region
End Class
