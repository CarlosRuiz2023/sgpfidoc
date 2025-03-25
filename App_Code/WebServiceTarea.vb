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
Public Class WebServiceTarea
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTareas_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseTarea
        Return GetTareas(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetTareas(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseTarea
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
            Using cmd As New NpgsqlCommand("public2.sp_tarea_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim tareas = New List(Of clsTarea)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim tarea As clsTarea = New clsTarea()
                        tarea.idtarea = ValidarDBNull(row.Item("out_idtarear"), "entero")
                        tarea.sp = ValidarDBNull(row.Item("out_spr"), "cadena")
                        tarea.descrip_tarea = ValidarDBNull(row.Item("out_descrip_tarear"), "cadena")
                        tarea.etiqueta_tarea = ValidarDBNull(row.Item("out_etiqueta_tarear"), "cadena")
                        tarea.limite_autorizacion = ValidarDBNull(row.Item("out_limite_autorizacionr"), "cadena")
                        tarea.cactivo = ValidarDBNull(row.Item("out_cactivor"), "cadena")
                        tarea.fec_cre_tarea = ValidarDBNull(row.Item("out_fec_cre_tarear"), "cadena")
                        tareas.Add(tarea)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseTarea = New JQGridJsonResponseTarea
                objeto.JQGridJsonResponseTarea(pagecount, currentpage, recordcount, tareas)
                Return objeto
            End Using
        End Using
    End Function

    <WebMethod(Description:="Extrae los roles de usuario para enlistarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetTarea(idTarea As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_tarea_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idtareax", idTarea)
                adapt.Fill(ds, "tarea")
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

    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GuardarTarea(objTarea As clsTarea) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idtarear As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_tarea", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idtarea_in", objTarea.idtarea)
                cmd.Parameters.AddWithValue("@sp_in", objTarea.sp)
                cmd.Parameters.AddWithValue("@descrip_tarea_in", objTarea.descrip_tarea)
                cmd.Parameters.AddWithValue("@etiqueta_tarea_in", objTarea.etiqueta_tarea)
                cmd.Parameters.AddWithValue("@limite_autorizacion_in", objTarea.limite_autorizacion)
                cmd.Parameters.AddWithValue("@cactivo_in", objTarea.cactivo)
                cmd.Parameters.AddWithValue("@fec_cre_tarea_in", objTarea.fec_cre_tarea)
                cmd.Parameters.AddWithValue("@accionx", objTarea.accion)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridrol As NpgsqlParameter = New NpgsqlParameter("@idtarear", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridrol.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridrol)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idtarear = cmd.Parameters("@idtarear").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente:" & idtarear.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function

    <WebMethod(Description:="Extrae los roles de usuario para enlistarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ConsultaPermisoTarea(idusu As Integer, idtarea As Integer, idaccion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_permiso_usuario_tarea_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idusu_in", idusu)
                cmd.Parameters.AddWithValue("@idtarea_in", idTarea)
                cmd.Parameters.AddWithValue("@idaccion_in", idaccion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                con.Close()
            End Using
        End Using
        Try
            Return messerror & ":" & numerror.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try

    End Function



    <WebMethod(Description:="Registra y ejecuta la Tarea")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function RegistraEjecuta_Tarea(objUsuarioTareaAccion As clsUsuarioTareaAccion, objHistAct As clsHistorico_Act) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_usuario_accion_tarea", con)
                Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@id_accion_tarea_in", objUsuarioTareaAccion.id_accion_tarea)
                cmd.Parameters.AddWithValue("@fid_in", objUsuarioTareaAccion.fid)
                cmd.Parameters.AddWithValue("@pid_in", objUsuarioTareaAccion.pid)
                cmd.Parameters.AddWithValue("@oid_in", objUsuarioTareaAccion.oid)
                cmd.Parameters.AddWithValue("@obr_clv_int_in", objUsuarioTareaAccion.obr_clv_int)
                cmd.Parameters.AddWithValue("@cid_in", objUsuarioTareaAccion.cid)
                cmd.Parameters.AddWithValue("@idtarea_in", objUsuarioTareaAccion.idtarea)
                cmd.Parameters.AddWithValue("@id_usu_solicita_in", objUsuarioTareaAccion.idusu_solicita)
                cmd.Parameters.AddWithValue("@id_usu_autoriza_in", objUsuarioTareaAccion.idusu_autoriza)
                cmd.Parameters.AddWithValue("@id_usu_rubrica_in", objUsuarioTareaAccion.idusu_rubrica)
                cmd.Parameters.AddWithValue("@id_usu_rubrica2_in", objUsuarioTareaAccion.idusu_rubrica2)
                cmd.Parameters.AddWithValue("@folio_solic_in", objUsuarioTareaAccion.folio_solic)
                cmd.Parameters.AddWithValue("@parametro1_in", objUsuarioTareaAccion.parametro1)
                cmd.Parameters.AddWithValue("@parametro2_in", objUsuarioTareaAccion.parametro2)
                cmd.Parameters.AddWithValue("@parametro3_in", objUsuarioTareaAccion.parametro3)
                cmd.Parameters.AddWithValue("@parametro4_in", objUsuarioTareaAccion.parametro4)
                cmd.Parameters.AddWithValue("@parametro5_in", objUsuarioTareaAccion.parametro5)
                cmd.Parameters.AddWithValue("@parametro6_in", objUsuarioTareaAccion.parametro6)
                cmd.Parameters.AddWithValue("@parametro7_in", objUsuarioTareaAccion.parametro7)
                cmd.Parameters.AddWithValue("@parametro8_in", objUsuarioTareaAccion.parametro8)
                cmd.Parameters.AddWithValue("@parametro9_in", objUsuarioTareaAccion.parametro9)
                cmd.Parameters.AddWithValue("@parametro10_in", objUsuarioTareaAccion.parametro10)
                cmd.Parameters.AddWithValue("@parametro11_in", objUsuarioTareaAccion.parametro11)
                cmd.Parameters.AddWithValue("@parametro12_in", objUsuarioTareaAccion.parametro12)
                cmd.Parameters.AddWithValue("@parametro13_in", objUsuarioTareaAccion.parametro13)
                cmd.Parameters.AddWithValue("@parametro14_in", objUsuarioTareaAccion.parametro14)
                cmd.Parameters.AddWithValue("@parametro15_in", objUsuarioTareaAccion.parametro15)
                cmd.Parameters.AddWithValue("@parametro16_in", objUsuarioTareaAccion.parametro16)
                cmd.Parameters.AddWithValue("@parametro17_in", objUsuarioTareaAccion.parametro17)
                cmd.Parameters.AddWithValue("@parametro18_in", objUsuarioTareaAccion.parametro18)
                cmd.Parameters.AddWithValue("@parametro19_in", objUsuarioTareaAccion.parametro19)
                cmd.Parameters.AddWithValue("@parametro20_in", objUsuarioTareaAccion.parametro20)
                cmd.Parameters.AddWithValue("@idactividad_in", objHistAct.idactividad)
                cmd.Parameters.AddWithValue("@estatus_actividad_in", objHistAct.estatus_actividad)
                cmd.Parameters.AddWithValue("@fecha_actividad_in", objHistAct.fecha_actividad)
                cmd.Parameters.AddWithValue("@hora_actividad_in", objHistAct.hora_actividad)
                cmd.Parameters.AddWithValue("@idusu_in", objHistAct.idusu)
                cmd.Parameters.AddWithValue("@idaccion_in", objHistAct.idaccion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)


                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                con.Close()
            End Using
        End Using
        Try
            Return numerror.ToString + ":" + messerror
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