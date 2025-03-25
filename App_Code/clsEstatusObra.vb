Imports System.Data
Imports System.Data.SqlClient
Public Class clsEstatusObra
#Region "variables privadas"
    Private _IdEstatusObra As Integer = 0
    Private _Estatus As String = String.Empty
    Private _DescEstatus As String = String.Empty
    Private _FecCre As Date
    Private _FecModif As Date
    Private _UsrCre As String = String.Empty
    Private _UsrModif As String = String.Empty
    Private _Accion As String = String.Empty
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region


#Region "Propiedades"
    Public Property IdEstatusObra() As Integer
        Get
            Return _IdEstatusObra
        End Get
        Set(ByVal Value As Integer)
            _IdEstatusObra = Value
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

    Public Property DescEstatus() As String
        Get
            Return _DescEstatus
        End Get
        Set(ByVal Value As String)
            _DescEstatus = Value
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
    Public Property FecModif() As Date
        Get
            Return _FecModif
        End Get
        Set(ByVal Value As Date)
            _FecModif = Value
        End Set
    End Property
    Public Property UsrCre() As String
        Get
            Return _UsrCre
        End Get
        Set(ByVal Value As String)
            _UsrCre = Value
        End Set
    End Property
    Public Property UsrModif() As String
        Get
            Return _UsrModif
        End Get
        Set(ByVal Value As String)
            _UsrModif = Value
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
    Public Shared Function Consulta_EstatusObra(ByVal objEstatusObra As clsEstatusObra, ByRef dt As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        Dim IdEstatusObra As SqlParameter = New SqlParameter("@IdEstatusObra", SqlDbType.Int, 6)
        IdEstatusObra.Value = objEstatusObra._IdEstatusObra
        Dim Estatus As SqlParameter = New SqlParameter("@Estatus", SqlDbType.NVarChar, 50)
        Estatus.Value = objEstatusObra._Estatus
        Dim DescEstatus As SqlParameter = New SqlParameter("@DescEstatus", SqlDbType.NVarChar, 300)
        DescEstatus.Value = objEstatusObra._DescEstatus
        Dim FecCre As SqlParameter = New SqlParameter("@FecCre", SqlDbType.Date, 10)
        FecCre.Value = objEstatusObra._FecCre
        Dim FecModif As SqlParameter = New SqlParameter("@FecModif", SqlDbType.Date, 10)
        FecModif.Value = objEstatusObra._FecModif
        Dim UsrCre As SqlParameter = New SqlParameter("@UsrCre", SqlDbType.NVarChar, 100)
        UsrCre.Value = objEstatusObra._UsrCre
        Dim UsrModif As SqlParameter = New SqlParameter("@UsrModif", SqlDbType.NVarChar, 100)
        UsrCre.Value = objEstatusObra._UsrModif
        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 10)
        Accion.Value = objEstatusObra._Accion


        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output
        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdEstatusObra)
        params.Add(Estatus)
        params.Add(DescEstatus)
        params.Add(FecCre)
        params.Add(FecModif)
        params.Add(UsrCre)
        params.Add(UsrModif)
        params.Add(Accion)

        params.Add(parIdError)
        params.Add(parDesError)
        params.Add(parAux1)

        objEstatusObra.strMensaje = Nothing
        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_EstatusObra", params, objEstatusObra.strMensaje, dt)

        'Evaluamos las respuesta de SQL

        If intError > 0 Then
            Select Case intError
                Case 2601
                    objEstatusObra.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objEstatusObra.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objEstatusObra.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objEstatusObra.strMensaje = intError & " - " & objEstatusObra.strMensaje
            End Select
            Return False
        Else
            objEstatusObra.strMensaje = "OK"
            Return True
        End If
    End Function

#End Region

End Class

