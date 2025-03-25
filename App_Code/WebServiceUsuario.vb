Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceUsuario
    Inherits System.Web.Services.WebService


    Public Conn As SqlConnection = New SqlConnection("Data Source=192.168.1.4;Initial Catalog=fidoc;user id=usrfidoc;password=pwdfidoc;")

    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetUsuario() As String
        Dim query As String = "select * from musuarios where cActivo= 1 and mUsuArea like '%CALIDAD%'"
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "Usuario")
        Try
            Dim sb = New StringBuilder()
            Using writer = New StringWriter(sb)
                custDS.WriteXml(writer)
                Dim xml As String = sb.ToString()
                Return xml
            End Using
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function

    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetUsuarioProm() As String
        Dim query As String = "select * from musuarios where cActivo= 1 and mUsuArea like '%prom%'"
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "UsuarioProm")
        Try
            Dim sb = New StringBuilder()
            Using writer = New StringWriter(sb)
                custDS.WriteXml(writer)
                Dim xml As String = sb.ToString()
                Return xml
            End Using
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function

    <WebMethod(Description:="Retorna listado de usuarios que son ministros ejecutores")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetUsuarioMinistros(accion As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_lista_usuarios", con)
                Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.Parameters.AddWithValue("@accion", accion)
                cmd.CommandType = CommandType.StoredProcedure
                custDA.Fill(ds, "UsuarioMinistros")

                Try
                    Dim sb = New StringBuilder()
                    Using writer = New StringWriter(sb)
                        ds.WriteXml(writer)
                        Dim xml As String = sb.ToString()
                        Return xml
                    End Using
                Catch ex As Exception
                    Return "Error " & ex.Message
                End Try
                con.Close()
            End Using
        End Using
    End Function

    <WebMethod(Description:="Retorna listado de usuarios que son ministros ejecutores")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetUsuario(idusu As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_usuario_q", con)
                Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.Parameters.AddWithValue("@idusu", idusu)
                cmd.CommandType = CommandType.StoredProcedure
                custDA.Fill(ds, "usuario")
                Try
                    Dim sb = New StringBuilder()
                    Using writer = New StringWriter(sb)
                        ds.WriteXml(writer)
                        Dim xml As String = sb.ToString()
                        Return xml
                    End Using
                Catch ex As Exception
                    Return "Error " & ex.Message
                End Try
                con.Close()
            End Using
        End Using
    End Function


    <WebMethod(Description:="Retorna listado de usuarios que son ministros ejecutores")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetRolUsuario(accion As String, idusu As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_rol_usuario_q", con)
                Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.Parameters.AddWithValue("@accionx", accion)
                cmd.Parameters.AddWithValue("@idusux", idusu)
                cmd.CommandType = CommandType.StoredProcedure
                custDA.Fill(ds, "rolusuario")

                Try
                    Dim sb = New StringBuilder()
                    Using writer = New StringWriter(sb)
                        ds.WriteXml(writer)
                        Dim xml As String = sb.ToString()
                        Return xml
                    End Using
                Catch ex As Exception
                    Return "Error " & ex.Message
                End Try
                con.Close()
            End Using
        End Using
    End Function



    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetUsuarioCalidad() As String
        Dim query As String = "select * from musuarios where cActivo= 1 and mUsuArea like '%cal%'"
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "UsuarioCal")
        Try
            Dim sb = New StringBuilder()
            Using writer = New StringWriter(sb)
                custDS.WriteXml(writer)
                Dim xml As String = sb.ToString()
                Return xml
            End Using
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function


    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetUsuarioDir() As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("select musunombre  from musuarios where cactivo= 1 and musuidrol=3", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.MissingSchemaAction = MissingSchemaAction.AddWithKey
                adapt.Fill(dt, "usudir")
            End Using
        End Using

        Try
            Dim sb = New StringBuilder()
            Using writer = New StringWriter(sb)
                dt.WriteXml(writer)
                Dim xml As String = sb.ToString()
                Return xml
            End Using
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function


    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GuardarUsuario(objUsuario As clsUsuarios) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idusux As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_usuarios", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@usuid_in", objUsuario.IdUsuario)
                cmd.Parameters.AddWithValue("@usunombre_in", objUsuario.Nombre)
                cmd.Parameters.AddWithValue("@usucorreo_in", objUsuario.Correo)
                cmd.Parameters.AddWithValue("@usucuenta_in", objUsuario.Usuario)
                cmd.Parameters.AddWithValue("@usupass_in", objUsuario.Pass)
                cmd.Parameters.AddWithValue("@usuidrol_in", objUsuario.IdRol)
                cmd.Parameters.AddWithValue("@usurfc_in", objUsuario.Rfc)
                cmd.Parameters.AddWithValue("@usucurp_in", objUsuario.Curp)
                cmd.Parameters.AddWithValue("@ususs_in", objUsuario.Ss)
                cmd.Parameters.AddWithValue("@usuempleado_in", objUsuario.Empleado)
                cmd.Parameters.AddWithValue("@usuusucre_in", objUsuario.UsuCre)
                cmd.Parameters.AddWithValue("@usuusumod_in", objUsuario.UsuMod)
                cmd.Parameters.AddWithValue("@usuestatus_in", objUsuario.UsuEstatus)
                cmd.Parameters.AddWithValue("@usuactivo_in", objUsuario.Activo)
                cmd.Parameters.AddWithValue("@usulastlogin_in", objUsuario.FecUltCon)
                cmd.Parameters.AddWithValue("@usufeccre_in", objUsuario.FecCre)
                cmd.Parameters.AddWithValue("@usufecmod_in", objUsuario.FecMod)
                cmd.Parameters.AddWithValue("@usuidarea_in", objUsuario.idarea)
                cmd.Parameters.AddWithValue("@accion", objUsuario.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@NoError", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@DescError", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridusu As NpgsqlParameter = New NpgsqlParameter("@idusux", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridusu.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridusu)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()
                idusux = cmd.Parameters("@idusux").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Mensaje:" & messerror & " No.Error:" & numerror & " IdUsu:" & idusux.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function



    'Webservice utilizado para relacionar toda la situación financiera por frente
    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetUsuariosGral(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, idusu As Integer) As JQGridJsonResponseUsuario
        Return GetUsuarios(pPageSize, pCurrentPage, pSortColumn, pSortOrder, idusu)

    End Function

    Private Function GetUsuarios(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, idusu As Integer) As JQGridJsonResponseUsuario
        Dim constr2 As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim dt2 As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Dim fidx As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr2)
            Using cmd As New NpgsqlCommand("public2.sp_usuarios_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@idusu", idusu)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim usuarios = New List(Of clsUsuarios)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim usuario As clsUsuarios = New clsUsuarios()
                        usuario.IdUsuario = ValidarDBNull(row.Item("out_musuid"), "entero")
                        usuario.Nombre = ValidarDBNull(row.Item("out_musunombre"), "cadena")
                        usuario.idarea = ValidarDBNull(row.Item("out_midarea"), "entero")
                        usuario.Area = ValidarDBNull(row.Item("out_area"), "cadena")
                        usuario.Correo = ValidarDBNull(row.Item("out_musucorreo"), "cadena")
                        usuario.Usuario = ValidarDBNull(row.Item("out_musucuenta"), "cadena")
                        usuario.Pass = ValidarDBNull(row.Item("out_musupass"), "cadena")
                        usuario.IdRol = ValidarDBNull(row.Item("out_musuidrol"), "entero")
                        usuario.RolTxt = ValidarDBNull(row.Item("out_musurolnombre"), "cadena")
                        usuario.Rfc = ValidarDBNull(row.Item("out_musurfc"), "cadena")
                        usuario.Curp = ValidarDBNull(row.Item("out_musucurp"), "cadena")
                        usuario.Ss = ValidarDBNull(row.Item("out_mususs"), "cadena")
                        usuario.Empleado = ValidarDBNull(row.Item("out_musuempleado"), "entero")
                        usuario.UsuCre = ValidarDBNull(row.Item("out_usrcre"), "cadena")
                        usuario.UsuMod = ValidarDBNull(row.Item("out_usrmod"), "cadena")
                        usuario.UsuEstatus = ValidarDBNull(row.Item("out_musuestatus"), "entero")
                        usuario.Activo = ValidarDBNull(row.Item("out_cactivo"), "entero")
                        usuario.FecUltCon = ValidarDBNull(row.Item("out_musulastlogin"), "fechalarga")
                        usuario.FecMod = ValidarDBNull(row.Item("out_fecmod"), "fecha")
                        usuario.FecCre = ValidarDBNull(row.Item("out_feccre"), "fecha")
                        usuarios.Add(usuario)
                    Next row

                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseUsuario = New JQGridJsonResponseUsuario
                objeto.JQGridJsonResponseUsuario(pagecount, currentpage, recordcount, usuarios)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetUsuario(idusu As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("select musucuenta,musunombre,musuidrol  from musuarios where cactivo= 1 and musuid=" + idusu, con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.MissingSchemaAction = MissingSchemaAction.AddWithKey
                adapt.Fill(dt, "usuario")
            End Using
        End Using

        Try
            Dim sb = New StringBuilder()
            Using writer = New StringWriter(sb)
                dt.WriteXml(writer)
                Dim xml As String = sb.ToString()
                Return xml
            End Using
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
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
                        If tipodato = "real" Then
                            ValidarDBNull = "0.0"
                        Else
                            If tipodato = "hora" Then
                                ValidarDBNull = "00:00:00"
                            Else
                                If tipodato = "fechalarga" Then

                                    ValidarDBNull = "01/01/1900 00:00:00.000-00"
                                Else
                                    ValidarDBNull = ""
                                End If
                            End If
                        End If
                    End If
                End If
            Else
                ValidarDBNull = objParametro.ToString
            End If
        End If
        Return ValidarDBNull
    End Function
End Class
