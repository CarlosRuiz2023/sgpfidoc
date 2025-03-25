Imports System.Data
Imports System.Data.SqlClient
Public Class clsPoligono
#Region "variables privadas"
    Private _IdPoligono As Integer = 0
    Private _Etiqueta As String = String.Empty
    Private _OrigenGob As String = String.Empty
    Private _Descripcion As String = String.Empty
    Private _FechaReg As Date
    Private _FechaModif As Date
    Private _UsrCre As String = String.Empty
    Private _UsrModif As String = String.Empty
    Private _Vigencia As String = String.Empty
    Private _NumRegistro As String = String.Empty
    Private _Accion As String = String.Empty
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdPoligono() As Integer
        Get
            Return _IdPoligono
        End Get
        Set(ByVal Value As Integer)
            _IdPoligono = Value
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

    Public Property OrigenGob() As String
        Get
            Return _OrigenGob
        End Get
        Set(ByVal Value As String)
            _OrigenGob = Value
        End Set
    End Property

    Public Property Descripcion() As String
        Get
            Return _Descripcion
        End Get
        Set(ByVal Value As String)
            _Descripcion = Value
        End Set
    End Property

    Public Property FechaReg() As Date
        Get
            Return _FechaReg
        End Get
        Set(ByVal Value As Date)
            _FechaReg = Value
        End Set
    End Property
    Public Property FechaModif() As Date
        Get
            Return _FechaModif
        End Get
        Set(ByVal Value As Date)
            _FechaModif = Value
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

    Public Property Vigencia() As String
        Get
            Return _Vigencia
        End Get
        Set(ByVal Value As String)
            _Vigencia = Value
        End Set
    End Property
    Public Property NumRegistro() As String
        Get
            Return _NumRegistro
        End Get
        Set(ByVal Value As String)
            _NumRegistro = Value
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
    Public Shared Function Consulta_Poligonos(ByVal objPoligono As clsPoligono, ByRef dt As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        Dim idPoligono As SqlParameter = New SqlParameter("@idPoligono", SqlDbType.Int, 6)
        idPoligono.Value = objPoligono._IdPoligono
        Dim Etiqueta As SqlParameter = New SqlParameter("@Etiqueta", SqlDbType.NVarChar, 50)
        Etiqueta.Value = objPoligono._Etiqueta
        Dim OrigenGob As SqlParameter = New SqlParameter("@OrigenGob", SqlDbType.NVarChar, 50)
        OrigenGob.Value = objPoligono._OrigenGob
        Dim Descripcion As SqlParameter = New SqlParameter("@Descripcion", SqlDbType.NVarChar, 300)
        Descripcion.Value = objPoligono._Descripcion
        Dim FechaReg As SqlParameter = New SqlParameter("@fecreg", SqlDbType.Date, 10)
        FechaReg.Value = objPoligono._FechaReg
        Dim FechaModif As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FechaModif.Value = objPoligono._FechaModif
        Dim UsrCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 100)
        UsrCre.Value = objPoligono._UsrCre
        Dim UsrModif As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 100)
        UsrModif.Value = objPoligono._UsrModif
        Dim Vigencia As SqlParameter = New SqlParameter("@Vigencia", SqlDbType.NVarChar, 200)
        Vigencia.Value = objPoligono._Vigencia
        Dim NumRegistro As SqlParameter = New SqlParameter("@NoRegistro", SqlDbType.NVarChar, 200)
        NumRegistro.Value = objPoligono._NumRegistro
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objPoligono._Accion


        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output
        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(idPoligono)
        params.Add(Etiqueta)
        params.Add(OrigenGob)
        params.Add(Descripcion)
        params.Add(FechaReg)
        params.Add(FechaModif)
        params.Add(UsrCre)
        params.Add(UsrModif)
        params.Add(Vigencia)
        params.Add(NumRegistro)
        params.Add(Accion)

        params.Add(parIdError)
        params.Add(parDesError)
        params.Add(parAux1)

        objPoligono.strMensaje = Nothing
        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_Poligono", params, objPoligono.strMensaje, dt)

        'Evaluamos las respuesta de SQL

        If intError > 0 Then
            Select Case intError
                Case 2601
                    objPoligono.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objPoligono.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objPoligono.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objPoligono.strMensaje = intError & " - " & objPoligono.strMensaje
            End Select
            Return False
        Else
            objPoligono.strMensaje = "OK"
            Return True
        End If
    End Function

    Public Shared Function Insertar(ByVal objPoligono As clsPoligono) As Boolean
        Dim params = New List(Of SqlParameter)


        Dim idPoligono As SqlParameter = New SqlParameter("@idPoligono", SqlDbType.Int, 6)
        idPoligono.Value = objPoligono._IdPoligono
        Dim Etiqueta As SqlParameter = New SqlParameter("@Etiqueta", SqlDbType.NVarChar, 50)
        Etiqueta.Value = objPoligono._Etiqueta
        Dim OrigenGob As SqlParameter = New SqlParameter("@OrigenGob", SqlDbType.NVarChar, 50)
        OrigenGob.Value = objPoligono._OrigenGob
        Dim Descripcion As SqlParameter = New SqlParameter("@Descripcion", SqlDbType.NVarChar, 300)
        Descripcion.Value = objPoligono._Descripcion
        Dim FechaReg As SqlParameter = New SqlParameter("@fecreg", SqlDbType.Date, 10)
        FechaReg.Value = objPoligono._FechaReg
        Dim FechaModif As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FechaModif.Value = objPoligono._FechaModif
        Dim UsrCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsrCre.Value = objPoligono._UsrCre
        Dim UsrModif As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsrModif.Value = objPoligono._UsrModif
        Dim Vigencia As SqlParameter = New SqlParameter("@Vigencia", SqlDbType.NVarChar, 50)
        Vigencia.Value = objPoligono._Vigencia
        Dim NumRegistro As SqlParameter = New SqlParameter("@NoRegistro", SqlDbType.NVarChar, 50)
        NumRegistro.Value = objPoligono._NumRegistro
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 50)
        Accion.Value = objPoligono._Accion


        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output
        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output


        '--------------------------Agrega los parámetros a un arreglo
        params.Add(idPoligono)
        params.Add(Etiqueta)
        params.Add(OrigenGob)
        params.Add(Descripcion)
        params.Add(FechaReg)
        params.Add(FechaModif)
        params.Add(UsrCre)
        params.Add(UsrModif)
        params.Add(Vigencia)
        params.Add(NumRegistro)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)
        params.Add(parAux1)

        '    '-----------r--------------Invoca la función para ejecutar el SP
        objPoligono.strMensaje = Nothing
        Dim intError As Integer = conn.EjecutarOperacionPrueba3("SP_Poligono", params, objPoligono.strMensaje, objPoligono.IdPoligono)

        'Evaluamos las respuesta de SQL

        If intError > 0 Then
            Select Case intError
                Case 2601
                    objPoligono.strMensaje = "Ya se tiene un presupuesto guardado con el mismo programa"
                Case 2627
                    objPoligono.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objPoligono.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objPoligono.strMensaje = intError & " - " & objPoligono.strMensaje
            End Select
            Return False
        Else
            objPoligono.strMensaje = "OK"
            Return True
        End If

    End Function

#End Region

End Class
