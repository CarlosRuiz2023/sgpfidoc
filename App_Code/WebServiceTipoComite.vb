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
Public Class WebServiceTipoComite
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTipoComite_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseTipoComite

        Return GetTiposComite(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetTiposComite(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseTipoComite
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
            Using cmd As New NpgsqlCommand("public2.sp_tipo_comite_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim tipos_comite = New List(Of clsTipoComite)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim tipo_comite As clsTipoComite = New clsTipoComite()
                        tipo_comite.idtipo_comite = ValidarDBNull(row.Item("out_idtipo_comiter"), "entero")
                        tipo_comite.etiqueta_tipo_comite = ValidarDBNull(row.Item("out_etiqueta_tipo_comiter"), "cadena")
                        tipo_comite.descrip = ValidarDBNull(row.Item("out_descripr"), "cadena")
                        tipo_comite.fec_cre = ValidarDBNull(row.Item("out_fec_crer"), "fecha")
                        tipo_comite.fec_mod = ValidarDBNull(row.Item("out_fec_modr"), "fecha")
                        tipo_comite.usu_cre = ValidarDBNull(row.Item("out_usu_crer"), "entero")
                        tipo_comite.usu_mod = ValidarDBNull(row.Item("out_usu_modr"), "entero")
                        tipo_comite.cestatus = ValidarDBNull(row.Item("out_cestatusr"), "entero")
                        tipos_comite.Add(tipo_comite)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseTipoComite = New JQGridJsonResponseTipoComite
                objeto.JQGridJsonResponseTipoComite(pagecount, currentpage, recordcount, tipos_comite)
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
    Public Function GuardarTipoComite(objTipoComite As clsTipoComite) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idTipoComiter As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_tipo_comite", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idtipo_comite_in", objTipoComite.idtipo_comite)
                cmd.Parameters.AddWithValue("@etiqueta_tipo_comite_in", objTipoComite.etiqueta_tipo_comite)
                cmd.Parameters.AddWithValue("@descrip_tipo_comite_in", objTipoComite.descrip)
                cmd.Parameters.AddWithValue("@fec_cre_tipo_comite_in", objTipoComite.fec_cre)
                cmd.Parameters.AddWithValue("@fec_mod_tipo_comite_in", objTipoComite.fec_mod)
                cmd.Parameters.AddWithValue("@usu_cre_tipo_comite_in", objTipoComite.usu_cre)
                cmd.Parameters.AddWithValue("@usu_mod_tipo_comite_in", objTipoComite.usu_mod)
                cmd.Parameters.AddWithValue("@cestatus_in", objTipoComite.cestatus)
                cmd.Parameters.AddWithValue("@accionx", objTipoComite.accion)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridcomite As NpgsqlParameter = New NpgsqlParameter("@idtipocomiter", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridcomite.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridcomite)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idTipoComiter = cmd.Parameters("@idtipocomiter").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Transaccion ejecutada correctamente:" & idTipoComiter.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function



    <WebMethod(Description:="Extrae los tipos de asamble para insertarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetTipoComite(idtipocomite As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_tipo_comite_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idtipocomite_in", idtipocomite)
                adapt.Fill(ds, "tipo_comite")
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

End Class