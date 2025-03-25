Imports System.Data
Imports System.Data.SqlClient

Public Class clsObraSIG
#Region "variables privadas"
    Private _oid As Integer = 0
    Private _idCalle As Integer = 0
    Private _idSEC As Integer = 0
    Private _idSSC As Integer = 0
    Private _Calle As String = String.Empty
    Private _Colonia As String = String.Empty
    Private _Tramo As String = String.Empty
    Private _longMts As Double = 0
    Private _NoObra As String = String.Empty
    Private _NoObra2 As String = String.Empty
    Private _NoObra3 As String = String.Empty
    Private _NoObra4 As String = String.Empty
    Private _Accion As String = String.Empty
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property oid() As Integer
        Get
            Return _oid
        End Get
        Set(ByVal Value As Integer)
            _oid = Value
        End Set
    End Property
    Public Property idCalle() As Integer
        Get
            Return _idCalle
        End Get
        Set(ByVal Value As Integer)
            _idCalle = Value
        End Set
    End Property
    Public Property idSEC() As Integer
        Get
            Return _idSEC
        End Get
        Set(ByVal Value As Integer)
            _idSEC = Value
        End Set
    End Property
    Public Property idSSC() As Integer
        Get
            Return _idSSC
        End Get
        Set(ByVal Value As Integer)
            _idSSC = Value
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
    Public Property Tramo() As String
        Get
            Return _Tramo
        End Get
        Set(ByVal Value As String)
            _Tramo = Value
        End Set
    End Property

    Public Property longMts() As Double
        Get
            Return _longMts
        End Get
        Set(ByVal Value As Double)
            _longMts = Value
        End Set
    End Property
    Public Property NoObra() As String
        Get
            Return _NoObra

        End Get
        Set(ByVal Value As String)
            _NoObra = Value
        End Set
    End Property
    Public Property NoObra2() As String
        Get
            Return _NoObra

        End Get
        Set(ByVal Value As String)
            _NoObra = Value
        End Set
    End Property

    Public Property NoObra3() As String
        Get
            Return _NoObra

        End Get
        Set(ByVal Value As String)
            _NoObra = Value
        End Set
    End Property
    Public Property NoObra4() As String
        Get
            Return _NoObra

        End Get
        Set(ByVal Value As String)
            _NoObra = Value
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
    Public Shared Function Consulta_ObraSIG(ByVal objObraSIG As clsObraSIG, ByRef dt As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        Dim oid As SqlParameter = New SqlParameter("@oid", SqlDbType.Int, 6)
        oid.Value = objObraSIG._oid
        Dim idCalle As SqlParameter = New SqlParameter("@idCalle", SqlDbType.Int, 6)
        idCalle.Value = objObraSIG._idCalle
        Dim idSEC As SqlParameter = New SqlParameter("@idSEC", SqlDbType.Int, 6)
        idSEC.Value = objObraSIG._idSEC
        Dim idSSC As SqlParameter = New SqlParameter("@idSSC", SqlDbType.Int, 6)
        idSSC.Value = objObraSIG._idSSC
        Dim Tramo As SqlParameter = New SqlParameter("@Tramo", SqlDbType.NVarChar, 500)
        Tramo.Value = objObraSIG._Tramo
        Dim NoObra As SqlParameter = New SqlParameter("@NoObra", SqlDbType.NVarChar, 500)
        Tramo.Value = objObraSIG._NoObra
        Dim NoObra2 As SqlParameter = New SqlParameter("@NoObra2", SqlDbType.NVarChar, 500)
        Tramo.Value = objObraSIG._NoObra2
        Dim NoObra3 As SqlParameter = New SqlParameter("@NoObra3", SqlDbType.NVarChar, 500)
        Tramo.Value = objObraSIG._NoObra3
        Dim NoObra4 As SqlParameter = New SqlParameter("@NoObra4", SqlDbType.NVarChar, 500)
        NoObra4.Value = objObraSIG._NoObra4
        Dim longMts As SqlParameter = New SqlParameter("@longMts", SqlDbType.Float, 6)
        longMts.Value = objObraSIG._longMts


        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 50)
        Accion.Value = objObraSIG._Accion


        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output
        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(oid)
        params.Add(idCalle)
        params.Add(idSEC)
        params.Add(idSSC)
        params.Add(Tramo)
        params.Add(longMts)
        params.Add(NoObra)
        params.Add(NoObra2)
        params.Add(NoObra3)
        params.Add(NoObra4)
        params.Add(Accion)

        params.Add(parIdError)
        params.Add(parDesError)
        params.Add(parAux1)

        objObraSIG.strMensaje = Nothing
        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_ObraSIG", params, objObraSIG.strMensaje, dt)

        'Evaluamos las respuesta de SQL

        If intError > 0 Then
            Select Case intError
                Case 2601
                    objObraSIG.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objObraSIG.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objObraSIG.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objObraSIG.strMensaje = intError & " - " & objObraSIG.strMensaje
            End Select
            Return False
        Else
            objObraSIG.strMensaje = "OK"
            Return True
        End If
    End Function



    Public Shared Function Consulta_CalleSIG(ByVal objObraSIG As clsObraSIG, ByRef dt As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        Dim oid As SqlParameter = New SqlParameter("@oid", SqlDbType.Int, 6)
        oid.Value = objObraSIG._oid
        Dim idCalle As SqlParameter = New SqlParameter("@idCalle", SqlDbType.Int, 6)
        idCalle.Value = objObraSIG._idCalle
        Dim idSEC As SqlParameter = New SqlParameter("@idSEC", SqlDbType.Int, 6)
        idSEC.Value = objObraSIG._idSEC
        Dim idSSC As SqlParameter = New SqlParameter("@idSSC", SqlDbType.Int, 6)
        idSSC.Value = objObraSIG._idSSC
        Dim Calle As SqlParameter = New SqlParameter("@Calle", SqlDbType.NVarChar, 100)
        Calle.Value = objObraSIG._Calle
        Dim Colonia As SqlParameter = New SqlParameter("@Colonia", SqlDbType.NVarChar, 100)
        Colonia.Value = objObraSIG._Colonia
        Dim Tramo As SqlParameter = New SqlParameter("@Tramo", SqlDbType.NVarChar, 100)
        Tramo.Value = objObraSIG._Tramo
        Dim NoObra As SqlParameter = New SqlParameter("@NoObra", SqlDbType.NVarChar, 100)
        Tramo.Value = objObraSIG._NoObra
        Dim NoObra2 As SqlParameter = New SqlParameter("@NoObra2", SqlDbType.NVarChar, 100)
        Tramo.Value = objObraSIG._NoObra2
        Dim NoObra3 As SqlParameter = New SqlParameter("@NoObra3", SqlDbType.NVarChar, 100)
        Tramo.Value = objObraSIG._NoObra3
        Dim NoObra4 As SqlParameter = New SqlParameter("@NoObra4", SqlDbType.NVarChar, 100)
        NoObra4.Value = objObraSIG._NoObra4
        Dim longMts As SqlParameter = New SqlParameter("@longMts", SqlDbType.Float, 6)
        longMts.Value = objObraSIG._longMts


        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 50)
        Accion.Value = objObraSIG._Accion


        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output
        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(oid)
        params.Add(idCalle)
        params.Add(idSEC)
        params.Add(idSSC)
        params.Add(Calle)
        params.Add(Colonia)
        params.Add(Tramo)
        params.Add(longMts)
        params.Add(NoObra)
        params.Add(NoObra2)
        params.Add(NoObra3)
        params.Add(NoObra4)
        params.Add(Accion)

        params.Add(parIdError)
        params.Add(parDesError)
        params.Add(parAux1)

        objObraSIG.strMensaje = Nothing
        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_ObraSIG", params, objObraSIG.strMensaje, dt)

        'Evaluamos las respuesta de SQL

        If intError > 0 Then
            Select Case intError
                Case 2601
                    objObraSIG.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objObraSIG.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objObraSIG.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objObraSIG.strMensaje = intError & " - " & objObraSIG.strMensaje
            End Select
            Return False
        Else
            objObraSIG.strMensaje = "OK"
            Return True
        End If
    End Function

#End Region

End Class

