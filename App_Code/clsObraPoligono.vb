Imports System.Data
Imports System.Data.SqlClient
Public Class clsObraPoligono
#Region "variables privadas"
    Private _ObrClv As String = String.Empty
    Private _IdPoligono As Integer = 0
    Private _FecReg As Date
    Private _Identificador As String = String.Empty
    Private _Etiqueta As String = String.Empty
    Private _UsrCre As Integer = 0
    Private _Accion As String = String.Empty
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property ObrClv() As String
        Get
            Return _ObrClv
        End Get
        Set(ByVal Value As String)
            _ObrClv = Value
        End Set
    End Property

    Public Property IdPoligono() As Integer
        Get
            Return _IdPoligono
        End Get
        Set(ByVal Value As Integer)
            _IdPoligono = Value
        End Set
    End Property

    Public Property FecReg() As Date
        Get
            Return _FecReg
        End Get
        Set(ByVal Value As Date)
            _FecReg = Value
        End Set
    End Property

    Public Property Identificador() As String
        Get
            Return _Identificador
        End Get
        Set(ByVal Value As String)
            _Identificador = Value
        End Set
    End Property
    Public Property Etiqueta() As String
        Get
            Return _Etiqueta
        End Get
        Set(ByVal Value As String)
            _Etiqueta = Value
        End Set
    End Property
    Public Property UsrCre() As Double
        Get
            Return _UsrCre
        End Get
        Set(ByVal Value As Double)
            _UsrCre = Value
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
    Public Shared Function Consulta_ObraPoligono(ByVal objObraPoligono As clsObraPoligono, ByRef dt As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        Dim ObrClv As SqlParameter = New SqlParameter("@ObrClv", SqlDbType.NVarChar, 50)
        ObrClv.Value = objObraPoligono._ObrClv
        Dim IdPoligono As SqlParameter = New SqlParameter("@IdPoligono", SqlDbType.NVarChar, 100)
        IdPoligono.Value = objObraPoligono._IdPoligono
        Dim FecReg As SqlParameter = New SqlParameter("@FecReg", SqlDbType.Date, 6)
        FecReg.Value = objObraPoligono._FecReg
        Dim Identificador As SqlParameter = New SqlParameter("@Identificador", SqlDbType.NVarChar, 300)
        Identificador.Value = objObraPoligono._Identificador
        Dim Etiqueta As SqlParameter = New SqlParameter("@Etiqueta", SqlDbType.NVarChar, 100)
        Etiqueta.Value = objObraPoligono._Etiqueta
        Dim UsrCre As SqlParameter = New SqlParameter("@UsrCre", SqlDbType.Float, 2)
        UsrCre.Value = objObraPoligono._UsrCre
        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 50)
        Accion.Value = objObraPoligono._Accion


        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output
        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(ObrClv)
        params.Add(IdPoligono)
        params.Add(FecReg)
        params.Add(Identificador)
        params.Add(Etiqueta)
        params.Add(UsrCre)
        params.Add(Accion)

        params.Add(parIdError)
        params.Add(parDesError)
        params.Add(parAux1)

        objObraPoligono.strMensaje = Nothing
        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_ObraPoligono", params, objObraPoligono.strMensaje, dt)

        'Evaluamos las respuesta de SQL

        If intError > 0 Then
            Select Case intError
                Case 2601
                    objObraPoligono.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objObraPoligono.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objObraPoligono.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objObraPoligono.strMensaje = intError & " - " & objObraPoligono.strMensaje
            End Select
            Return False
        Else
            objObraPoligono.strMensaje = "OK"
            Return True
        End If
    End Function


    Public Shared Function InsertarObraPoligono(ByVal objObraPoligono As clsObraPoligono) As Boolean
        Dim params = New List(Of SqlParameter)

        Dim ObrClv As SqlParameter = New SqlParameter("@ObrClv", SqlDbType.NVarChar, 50)
        ObrClv.Value = objObraPoligono._ObrClv
        Dim IdPoligono As SqlParameter = New SqlParameter("@IdPoligono", SqlDbType.NVarChar, 100)
        IdPoligono.Value = objObraPoligono._IdPoligono
        Dim FecReg As SqlParameter = New SqlParameter("@FecReg", SqlDbType.Date, 6)
        FecReg.Value = objObraPoligono._FecReg
        Dim Identificador As SqlParameter = New SqlParameter("@Identificador", SqlDbType.NVarChar, 300)
        Identificador.Value = objObraPoligono._Identificador
        Dim Etiqueta As SqlParameter = New SqlParameter("@Etiqueta", SqlDbType.NVarChar, 100)
        Etiqueta.Value = objObraPoligono._Etiqueta
        Dim UsrCre As SqlParameter = New SqlParameter("@UsrCre", SqlDbType.Float, 2)
        UsrCre.Value = objObraPoligono._UsrCre
        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 50)
        Accion.Value = objObraPoligono._Accion


        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output
        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo

        params.Add(ObrClv)
        params.Add(IdPoligono)
        params.Add(FecReg)
        params.Add(Identificador)
        params.Add(Etiqueta)
        params.Add(UsrCre)
        params.Add(Accion)

        params.Add(parIdError)
        params.Add(parDesError)
        params.Add(parAux1)


        '-------------------------Invoca la función para ejecutar el SP
        Dim intError As Integer = conn.EjecutarOperacionPrueba("SP_ObraPoligono", params, objObraPoligono.strMensaje)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objObraPoligono.strMensaje = "EXISTE UNA ASAMBLEA DE COSTO CAPTURADA"
                Case 2627
                    objObraPoligono.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objObraPoligono.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objObraPoligono.strMensaje = intError & " - " & objObraPoligono.strMensaje
            End Select
            Return False
        Else
            objObraPoligono.strMensaje = "OK"
            Return True
        End If
    End Function



#End Region

End Class