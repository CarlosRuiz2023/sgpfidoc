Imports System.Data
Imports System.Data.SqlClient
Imports Npgsql



Public Class clsConexion

    Public oConexion As SqlConnection
    Public oConexion2 As SqlConnection
    Public oConexion4 As NpgsqlConnection
    Public oConexion3 As IBM.Data.DB2.iSeries.iDB2Connection
    Dim strMensajeError As String

    'Cambiar la conexion a la base de datos que se estará utilizando
    Public Sub New()
        'oConexion = New SqlConnection(ConfigurationManager.ConnectionStrings("cf").ConnectionString) 'Conexion a 192.1.1.241 en web.config
        oConexion = New SqlConnection(ConfigurationManager.ConnectionStrings("cf25").ConnectionString) 'Conexion a 192.1.25.25 en web.config
        oConexion2 = New SqlConnection(ConfigurationManager.ConnectionStrings("cf25").ConnectionString) 'conexion a 192.1.1.4 en web.config
        oConexion4 = New NpgsqlConnection(ConfigurationManager.ConnectionStrings("cf5").ConnectionString)
    End Sub

    Public Function Conectar() As Boolean
        Try
            oConexion.Open()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Function ConectarPsql() As Boolean
        Try
            oConexion4.Open()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Sub Desconectar()
        oConexion.Close()
    End Sub


    Public Sub DesconectarPgsql()
        oConexion4.Close()
    End Sub
    Public Function Conectar2() As Boolean
        Try
            oConexion2.Open()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Sub Desconectar2()
        oConexion2.Close()
    End Sub
    Public Function Conectar3() As Boolean
        Try
            oConexion3.Open()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Sub Desconectar3()
        oConexion3.Close()
    End Sub

    ''' <summary>
    ''' Ejecuta una operación.  Una instrucción SQL que no devuelve datos
    ''' </summary>
    ''' <param name="sentencia"></param>
    ''' <param name="parametros"></param>
    ''' <remarks></remarks>
    Public Function EjecutarOperacionPrueba(ByVal sentencia As String, ByVal parametros As IList(Of SqlClient.SqlParameter), ByRef strMsjError As String) As Integer
        Try
            Me.Conectar()
            Dim comando2 As New SqlClient.SqlCommand(sentencia, oConexion)
            comando2.CommandType = CommandType.StoredProcedure
            For Each param In parametros
                comando2.Parameters.Add(param)
            Next
            comando2.ExecuteNonQuery()
            'tbl.load(comando2.ExecuteReader)
            Dim resp1 As Integer = comando2.Parameters("@NoError").Value()
            strMsjError = comando2.Parameters("@DescError").Value()
            Return resp1
        Catch ex1 As SqlException
            strMsjError = ex1.Message
            Return ex1.Number
        End Try
    End Function
    '****24/01/2017--- Funcion para crear una consulta y llenar los registros por referencia

    Public Function EjecutarOperacionPrueba2(ByVal sentencia As String, ByVal parametros As IList(Of SqlClient.SqlParameter), ByRef strMsjError As String, ByRef tbl As DataTable) As Integer
        tbl = New DataTable()
        Try
            Me.Conectar()
            Dim comando2 As New SqlClient.SqlCommand(sentencia, oConexion)
            comando2.CommandType = CommandType.StoredProcedure
            For Each param In parametros
                comando2.Parameters.Add(param)
            Next
            Dim dr As SqlDataReader = comando2.ExecuteReader(CommandBehavior.CloseConnection)
            tbl.Load(dr)
            Dim resp1 As Integer = comando2.Parameters("@NoError").Value()
            strMsjError = comando2.Parameters("@DescError").Value()
            comando2 = Nothing
            Desconectar()
            Return resp1
        Catch ex1 As SqlException
            strMsjError = ex1.Message
            Return ex1.Number
        End Try
    End Function

    Public Function EjecutarOperacionPrueba3(ByVal sentencia As String, ByVal parametros As IList(Of SqlClient.SqlParameter), ByRef strMsjError As String, ByRef intAux1 As Integer) As Integer
        Try
            Me.Conectar()
            Dim comando2 As New SqlClient.SqlCommand(sentencia, oConexion)
            comando2.CommandType = CommandType.StoredProcedure
            For Each param In parametros
                comando2.Parameters.Add(param)
            Next
            comando2.ExecuteNonQuery()
            'tbl.load(comando2.ExecuteReader)
            Dim resp1 As Integer = comando2.Parameters("@NoError").Value()
            strMsjError = comando2.Parameters("@DescError").Value()
            intAux1 = comando2.Parameters("@Aux1").Value()
            comando2 = Nothing
            Desconectar()
            Return resp1
        Catch ex1 As SqlException
            strMsjError = ex1.Message
            Return ex1.Number
        End Try
    End Function

    Public Function EjecutarOperacion(ByVal sentencia As String, ByVal parametros As IList(Of SqlClient.SqlParameter)) As Integer

        EjecutarOperacion = True
        Dim valor As Integer

        Try
            Me.Conectar()
            Dim comando As New SqlClient.SqlCommand(sentencia, oConexion)
            comando.CommandType = CommandType.StoredProcedure

            For Each param In parametros
                comando.Parameters.Add(param)
            Next

            valor = Convert.ToInt32(comando.ExecuteScalar())
            comando = Nothing
            Desconectar()

            Return valor
        Catch ex1 As SqlException
            Select Case ex1.Number
                Case 201
                    strMensajeError = "El número de parámetros no es correcto"
                Case 2627
                    strMensajeError = "Se está intentando agregar un alumno ya existente"
                Case 2812
                    strMensajeError = "No se ha hallado el SP solicitado"
                Case Else
                    strMensajeError = ex1.Number & " - " & ex1.Message
            End Select
            Return False
        Catch ex2 As ArgumentException
            strMensajeError = ex2.Message

            'Catch e As ArgumentNullException
            'Catch e As SecurityException
            'Catch e As DirectoryNotFoundException
            'Catch e As IOException
            Return False
        Catch ex3 As Exception
            strMensajeError = ex3.Message
            Return False
        End Try
    End Function
    Public Function EjecutarOperacionPgsql(ByVal sentencia As String, ByVal parametros As IList(Of Npgsql.NpgsqlParameter), ByRef MensajeDefault As String) As Integer

        Dim respuesta As Integer = 0
        Dim messerror As String = Nothing

        Try
            Me.ConectarPsql()
            Dim comando As New Npgsql.NpgsqlCommand(sentencia, oConexion4)
            comando.CommandType = CommandType.StoredProcedure

            comando.Parameters.Add("@username", NpgsqlTypes.NpgsqlDbType.Varchar).Value = parametros(0).Value
            comando.Parameters.Add("@pass", NpgsqlTypes.NpgsqlDbType.Varchar).Value = parametros(1).Value

            Dim resp As NpgsqlParameter = New NpgsqlParameter("@resp", NpgsqlTypes.NpgsqlDbType.Integer, 36)
            resp.Direction = ParameterDirection.Output
            Dim descerror As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255)
            descerror.Direction = ParameterDirection.Output

            comando.Parameters.Add(resp)
            comando.Parameters.Add(descerror)

            comando.ExecuteNonQuery()

            EjecutarOperacionPgsql = ValidarDBNull(comando.Parameters("@resp").Value(), "entero")
            MensajeDefault = comando.Parameters("@descerror").Value()

        Catch ex As Npgsql.NpgsqlException
            ' Manejar errores de PostgreSQL
            MensajeDefault = "Error de PostgreSQL: " & ex.Message
            EjecutarOperacionPgsql = -1 ' O algún otro valor de error
            ' Registrar el error (opcional)
            Console.WriteLine(ex.ToString())
        Catch ex As Exception
            ' Manejar otros errores
            MensajeDefault = "Error general: " & ex.Message
            EjecutarOperacionPgsql = -1 ' O algún otro valor de error
            ' Registrar el error (opcional)
            Console.WriteLine(ex.ToString())
        Finally
            DesconectarPgsql()
        End Try

        Return EjecutarOperacionPgsql

    End Function

    Private Function ValidarDBNull(objParametro As Object, tipodato As String) As Object
        If IsDBNull(objParametro.ToString) Then
            ValidarDBNull = ""
        Else
            If objParametro.ToString = "" Then
                If tipodato = "entero" Then
                    ValidarDBNull = 0
                Else
                    If tipodato = "fecha" Then
                        ValidarDBNull = "01/01/1900"
                    Else
                        ValidarDBNull = ""
                    End If
                End If
            Else
                ValidarDBNull = objParametro.ToString
            End If
        End If
        Return ValidarDBNull
    End Function

    Public Function EjecutarConsulta(ByVal sentencia As String, ByVal parametros As List(Of SqlClient.SqlParameter)) As DataTable
        Dim adaptador As New SqlClient.SqlDataAdapter()
        Dim resultado As New DataSet()

        adaptador.SelectCommand = New SqlClient.SqlCommand(sentencia, oConexion)
        adaptador.SelectCommand.CommandType = CommandType.StoredProcedure

        For Each param In parametros
            adaptador.SelectCommand.Parameters.Add(param)
        Next
        Try
            adaptador.Fill(resultado)
            adaptador = Nothing
            Return resultado.Tables.Item(0)

        Catch ex1 As SqlException
            Select Case ex1.Number
                Case 64
                    strMensajeError = "Error de comunicación " & ex1.Number
                Case Else
                    strMensajeError = ex1.Number & " - " & ex1.Message

            End Select
        Catch ex2 As Exception
            strMensajeError = ex2.Message
        End Try
    End Function
    Public Function EjecutarConsultaPsql(ByVal sentencia As String, ByVal parametros As List(Of Npgsql.NpgsqlParameter)) As DataTable
        Dim adaptador As New NpgsqlDataAdapter()
        Dim resultado As New DataSet()

        adaptador.SelectCommand = New NpgsqlCommand(sentencia, oConexion4)
        adaptador.SelectCommand.CommandType = CommandType.StoredProcedure

        For Each param In parametros
            adaptador.SelectCommand.Parameters.Add(param)
        Next

        adaptador.Fill(resultado)
        adaptador = Nothing
        Return resultado.Tables.Item(0)
    End Function

    Public Function transaccion()
        oConexion.BeginTransaction()

    End Function

    ''' <summary>
    ''' Ejecuta una operación.  Una instrucción SQL que no devuelve datos
    ''' </summary>
    ''' <param name="sentencia"></param>
    ''' <param name="parametros"></param>
    ''' <remarks></remarks>
    Public Function EjecutarOperacion2(ByVal sentencia As String, ByVal parametros As List(Of SqlClient.SqlParameter)) As Integer
        EjecutarOperacion2 = True
        Dim valor As Integer
        Try
            Me.Conectar2()
            Dim comando As New SqlClient.SqlCommand(sentencia, oConexion2)
            comando.CommandType = CommandType.StoredProcedure

            For Each param In parametros
                comando.Parameters.Add(param)
            Next
            'comando.ExecuteNonQuery()

            valor = Convert.ToInt32(comando.ExecuteScalar())
            comando = Nothing
            Desconectar2()

            Return valor
        Catch ex1 As SqlException
            Select Case ex1.Number
                Case 201
                    strMensajeError = "El número de parámetros no es correcto"
                Case 2627
                    strMensajeError = "Se está intentando agregar un alumno ya existente"
                Case 2812
                    strMensajeError = "No se ha hallado el SP solicitado"
                Case Else
                    strMensajeError = ex1.Number & " - " & ex1.Message
            End Select

            Return False
        Catch ex2 As ArgumentException
            strMensajeError = ex2.Message

            'Catch e As ArgumentNullException
            'Catch e As SecurityException
            'Catch e As DirectoryNotFoundException
            'Catch e As IOException

        Catch ex3 As Exception
            strMensajeError = ex3.Message
            Return False
        End Try
    End Function
    Public Function EjecutarConsulta2(ByVal sentencia As String) As DataTable
        Dim adaptador As New SqlClient.SqlDataAdapter()
        Dim resultado As New DataSet()

        adaptador.SelectCommand = New SqlClient.SqlCommand(sentencia, oConexion2)
        adaptador.SelectCommand.CommandType = CommandType.Text

        Try
            adaptador.Fill(resultado)
            adaptador = Nothing
            Return resultado.Tables.Item(0)

        Catch ex1 As SqlException
            Select Case ex1.Number
                Case Else
                    strMensajeError = ex1.Number & " - " & ex1.Message
            End Select
        Catch ex2 As Exception
            strMensajeError = ex2.Message
        End Try

    End Function
    Public Function transaccion2()
        oConexion2.BeginTransaction()
    End Function

    Public Function EjecutarConsulta3(ByVal sentencia As String) As DataTable
        Dim adaptador As New SqlClient.SqlDataAdapter()
        Dim resultado As New DataSet()

        adaptador.SelectCommand = New SqlClient.SqlCommand(sentencia, oConexion)
        adaptador.SelectCommand.CommandType = CommandType.Text

        Try
            adaptador.Fill(resultado)
            adaptador = Nothing
            Return resultado.Tables.Item(0)

        Catch ex1 As SqlException
            Select Case ex1.Number
                Case Else
                    strMensajeError = ex1.Number & " - " & ex1.Message
            End Select
        Catch ex2 As Exception
            strMensajeError = ex2.Message
        End Try

    End Function

    Public Function EjecutarConsultaO(ByVal sentencia As String) As DataTable
        Dim adaptador As New SqlClient.SqlDataAdapter()
        Dim resultado As New DataSet()

        adaptador.SelectCommand = New SqlClient.SqlCommand(sentencia, oConexion)
        adaptador.SelectCommand.CommandType = CommandType.Text

        Try
            adaptador.Fill(resultado)
            adaptador = Nothing
            Return resultado.Tables.Item(0)

        Catch ex1 As SqlException
            Select Case ex1.Number
                Case Else
                    strMensajeError = ex1.Number & " - " & ex1.Message
            End Select
        Catch ex2 As Exception
            strMensajeError = ex2.Message
        End Try
    End Function

    Public Function EjecutarConsultaD(ByVal sentencia As String) As DataTable
        Dim adaptador As New IBM.Data.DB2.iSeries.iDB2DataAdapter
        Dim resultado As New DataSet()

        Me.Conectar3()
        adaptador.SelectCommand = New IBM.Data.DB2.iSeries.iDB2Command(sentencia, oConexion3)
        adaptador.SelectCommand.CommandType = CommandType.Text

        Try
            adaptador.Fill(resultado)
            adaptador = Nothing
            Return resultado.Tables.Item(0)

        Catch ex1 As IBM.Data.DB2.iSeries.iDB2Exception
            Select Case ex1.ErrorCode
                Case Else
                    strMensajeError = ex1.ErrorCode & " - " & ex1.Message
            End Select
        Catch ex2 As Exception
            strMensajeError = ex2.Message
        End Try
    End Function


End Class
