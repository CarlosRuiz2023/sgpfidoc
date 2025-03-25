Imports System.Data
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceRolAccionTarea
    Inherits System.Web.Services.WebService



    <WebMethod(Description:="Extrae los roles de usuario para enlistarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetRolAccionTarea(objRolAccionTarea As clsRolAccionTarea) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_rol_accion_tarea", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idrol_in", objRolAccionTarea.idrol)
                cmd.Parameters.AddWithValue("@idaccion_in", objRolAccionTarea.idaccion)
                cmd.Parameters.AddWithValue("@idtarea_in", objRolAccionTarea.idtarea)
                cmd.Parameters.AddWithValue("@fec_cre_in", objRolAccionTarea.fec_cre)
                cmd.Parameters.AddWithValue("@accionx", objRolAccionTarea.accion)
                adapt.Fill(ds, "rol")
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


    <WebMethod(Description:="Extrae los roles de usuario para enlistarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetUsuAccionTarea(idusu As Integer, accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_usu_accion_tarea_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idusu_in", idusu)
                cmd.Parameters.AddWithValue("@accionx", accion)
                adapt.Fill(ds, "regla")
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





    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetRolAccionTarea_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, idrol As Integer) As JQGridJsonResponseRolAccionTarea
        Return GetRolAccionTarea_g(pPageSize, pCurrentPage, pSortColumn, pSortOrder, idrol)

    End Function

    Private Function GetRolAccionTarea_g(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, idrol As Integer) As JQGridJsonResponseRolAccionTarea
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
            Using cmd As New NpgsqlCommand("public2.sp_rolacciontarea_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@idrol_in", idrol)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim rolacciontarea_s = New List(Of clsRolAccionTarea)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim rolacciontarea As clsRolAccionTarea = New clsRolAccionTarea()
                        rolacciontarea.idrol = ValidarDBNull(row.Item("out_idrol"), "entero")
                        rolacciontarea.idaccion = ValidarDBNull(row.Item("out_idaccion"), "entero")
                        rolacciontarea.idtarea = ValidarDBNull(row.Item("out_idtarea"), "entero")
                        rolacciontarea.fec_cre = ValidarDBNull(row.Item("out_fec_cre"), "fecha")
                        rolacciontarea.fec_alta_accion = ValidarDBNull(row.Item("out_fec_alta_accion"), "fecha")
                        rolacciontarea.etiqueta_accion = ValidarDBNull(row.Item("out_etiqueta_accion"), "cadena")
                        rolacciontarea.sp = ValidarDBNull(row.Item("out_sp"), "cadena")
                        rolacciontarea.descrip_tarea = ValidarDBNull(row.Item("out_descrip_tarea"), "cadena")
                        rolacciontarea.etiqueta_tarea = ValidarDBNull(row.Item("out_etiqueta_tarea"), "cadena")
                        rolacciontarea.limite_autorizacion = ValidarDBNull(row.Item("out_limite_autorizacion"), "entero")
                        rolacciontarea.fec_cre_tarea = ValidarDBNull(row.Item("out_fec_cre_tarea"), "fecha")
                        rolacciontarea_s.Add(rolacciontarea)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseRolAccionTarea = New JQGridJsonResponseRolAccionTarea
                objeto.JQGridJsonResponseRolAccionTarea(pagecount, currentpage, recordcount, rolacciontarea_s)
                Return objeto
            End Using
        End Using
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
