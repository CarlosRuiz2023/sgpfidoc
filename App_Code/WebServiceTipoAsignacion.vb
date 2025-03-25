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
Public Class WebServiceTipoAsignacion
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTipoAsignacion_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseTipoAsignacion

        Return GetTiposAsignacion(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetTiposAsignacion(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseTipoAsignacion
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
            Using cmd As New NpgsqlCommand("public2.sp_tipo_asignacion_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim tipos_asignacion = New List(Of clsTipoAsig)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim tipo_asignacion As clsTipoAsig = New clsTipoAsig()
                        tipo_asignacion.idasignacion = ValidarDBNull(row.Item("out_idtipoasignacion_r"), "entero")
                        tipo_asignacion.etiqueta = ValidarDBNull(row.Item("out_etiqueta_r"), "cadena")
                        tipo_asignacion.descrip_tipo_asig = ValidarDBNull(row.Item("out_descrip_tipo_asig_r"), "cadena")
                        tipo_asignacion.idusu = ValidarDBNull(row.Item("out_usu_cre_r"), "cadena")
                        tipo_asignacion.fec_cre = ValidarDBNull(row.Item("out_fec_cre_r"), "fecha")
                        tipo_asignacion.cactivo = ValidarDBNull(row.Item("out_cactivo_r"), "cadena")
                        tipos_asignacion.Add(tipo_asignacion)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseTipoAsignacion = New JQGridJsonResponseTipoAsignacion
                objeto.JQGridJsonResponseTipoAsignacion(pagecount, currentpage, recordcount, tipos_asignacion)
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

    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetTipoAsignacion(idasignacion As Integer, accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_tipo_asignacion_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idasignacion_in", idasignacion)
                cmd.Parameters.AddWithValue("@accion_in", accion)
                adapt.Fill(ds, "tipo_asignacion")
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
    Public Function GuardarTipoAsignacion(objTipoAsig As clsTipoAsig) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idTipoAsignacionr As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_tipo_asignacion", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idasignacion_in", objTipoAsig.idasignacion)
                cmd.Parameters.AddWithValue("@etiqueta_in", objTipoAsig.etiqueta)
                cmd.Parameters.AddWithValue("@descrip_tipo_asig_in", objTipoAsig.descrip_tipo_asig)
                cmd.Parameters.AddWithValue("@cactivo_in", objTipoAsig.cactivo)
                cmd.Parameters.AddWithValue("@fec_cre_in", objTipoAsig.fec_cre)
                cmd.Parameters.AddWithValue("@idusu_in", objTipoAsig.cactivo)
                cmd.Parameters.AddWithValue("@accionx", objTipoAsig.accion)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridasignacion As NpgsqlParameter = New NpgsqlParameter("@idtipoasignacionr", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridasignacion.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridasignacion)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idTipoAsignacionr = cmd.Parameters("@idtipoasignacionr").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Transaccion ejecutada correctamente:" & idTipoAsignacionr.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function


End Class