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
Public Class WebServiceFormatoComite
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetFormatoComite_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseFormatoComite

        Return GetFormatosComite(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetFormatosComite(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseFormatoComite
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
            Using cmd As New NpgsqlCommand("public2.sp_formato_comite_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim formatos_comite = New List(Of clsFormatoComite)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim formato_comite As clsFormatoComite = New clsFormatoComite()
                        formato_comite.idformato_comite = ValidarDBNull(row.Item("out_idformato_comiter"), "entero")
                        formato_comite.etiqueta_formato_comite = ValidarDBNull(row.Item("out_etiqueta_formato_comiter"), "cadena")
                        formato_comite.descrip = ValidarDBNull(row.Item("out_descripr"), "cadena")
                        formato_comite.fec_cre = ValidarDBNull(row.Item("out_fec_crer"), "fecha")
                        formato_comite.fec_mod = ValidarDBNull(row.Item("out_fec_modr"), "fecha")
                        formato_comite.usu_cre = ValidarDBNull(row.Item("out_usu_crer"), "entero")
                        formato_comite.usu_mod = ValidarDBNull(row.Item("out_usu_modr"), "entero")
                        formato_comite.cestatus = ValidarDBNull(row.Item("out_cestatusr"), "entero")
                        formatos_comite.Add(formato_comite)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseFormatoComite = New JQGridJsonResponseFormatoComite
                objeto.JQGridJsonResponseFormatoComite(pagecount, currentpage, recordcount, formatos_comite)
                Return objeto
            End Using
        End Using
    End Function

    Private Function ValidarDBNull(objParametro As Object, Formatodato As String) As Object
        If IsDBNull(objParametro.ToString) Then
            ValidarDBNull = ""
        Else
            If objParametro.ToString = "" Then
                If Formatodato = "entero" Then
                    ValidarDBNull = 0
                Else
                    If Formatodato = "fecha" Then
                        ValidarDBNull = "01/01/1900"
                    Else
                        If Formatodato = "real" Then
                            ValidarDBNull = "0.0"
                        Else
                            If Formatodato = "hora" Then
                                ValidarDBNull = "00:00:00"
                            Else
                                If Formatodato = "fechalarga" Then

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
    Public Function GuardarFormatoComite(objFormatoComite As clsFormatoComite) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idFormatoComiter As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_formato_comite", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idformato_comite_in", objFormatoComite.idformato_comite)
                cmd.Parameters.AddWithValue("@etiqueta_formato_comite_in", objFormatoComite.etiqueta_formato_comite)
                cmd.Parameters.AddWithValue("@descrip_formato_comite_in", objFormatoComite.descrip)
                cmd.Parameters.AddWithValue("@fec_cre_formato_comite_in", objFormatoComite.fec_cre)
                cmd.Parameters.AddWithValue("@fec_mod_formato_comite_in", objFormatoComite.fec_mod)
                cmd.Parameters.AddWithValue("@usu_cre_formato_comite_in", objFormatoComite.usu_cre)
                cmd.Parameters.AddWithValue("@usu_mod_formato_comite_in", objFormatoComite.usu_mod)
                cmd.Parameters.AddWithValue("@cestatus_in", objFormatoComite.cestatus)
                cmd.Parameters.AddWithValue("@accionx", objFormatoComite.accion)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridcomite As NpgsqlParameter = New NpgsqlParameter("@idFormatocomiter", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridcomite.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridcomite)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idFormatoComiter = cmd.Parameters("@idFormatocomiter").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Transaccion ejecutada correctamente:" & idFormatoComiter.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function



    <WebMethod(Description:="Extrae los Formatos de asamble para insertarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetFormatoComite(idformatocomite As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_formato_comite_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idformatocomite_in", idformatocomite)
                adapt.Fill(ds, "formato_comite")
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