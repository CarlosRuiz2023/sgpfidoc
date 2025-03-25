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
Public Class WebServiceComite
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetComite_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseComite

        Return GetComite(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetComite(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseComite
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
            Using cmd As New NpgsqlCommand("public2.sp_comite_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim comites = New List(Of clsComite)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim comite As clsComite = New clsComite()
                        comite.idcomite = ValidarDBNull(row.Item("out_idcomiter"), "entero")
                        comite.num_sesion = ValidarDBNull(row.Item("out_num_sesionr"), "entero")
                        comite.num_sesion_romano = ValidarDBNull(row.Item("out_num_sesion_romanor"), "cadena")
                        comite.leyenda = ValidarDBNull(row.Item("out_leyendar"), "cadena")
                        comite.acta_comite = ValidarDBNull(row.Item("out_acta_comiter"), "cadena")
                        comite.tipo_sesion = ValidarDBNull(row.Item("out_tipo_sesionr"), "integer")
                        comite.etiqueta_tipo_comite = ValidarDBNull(row.Item("out_tipo_sesion_etiquetar"), "cadena")
                        comite.formato_comite = ValidarDBNull(row.Item("out_formato_comiter"), "integer")
                        comite.etiqueta_formato_comite = ValidarDBNull(row.Item("out_etiqueta_formato_comiter"), "cadena")
                        comite.fec_comite = ValidarDBNull(row.Item("out_fec_comiter"), "fecha")
                        comite.usu_cre = ValidarDBNull(row.Item("out_usu_crer"), "entero")
                        comite.usu_mod = ValidarDBNull(row.Item("out_usu_modr"), "entero")
                        comite.fec_cre = ValidarDBNull(row.Item("out_fec_crer"), "fecha")
                        comite.fec_mod = ValidarDBNull(row.Item("out_fec_modr"), "fecha")
                        comite.cestatus = ValidarDBNull(row.Item("out_cestatusr"), "entero")
                        comites.Add(comite)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseComite = New JQGridJsonResponseComite
                objeto.JQGridJsonResponseComite(pagecount, currentpage, recordcount, comites)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GuardarComite(objComite As clsComite) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idComite As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_comite", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idcomite_in", objComite.idcomite)
                cmd.Parameters.AddWithValue("@num_sesion_in", objComite.num_sesion)
                cmd.Parameters.AddWithValue("@tipo_sesion_in", objComite.tipo_sesion)
                cmd.Parameters.AddWithValue("@formato_comite_in", objComite.formato_comite)
                cmd.Parameters.AddWithValue("@acta_comite_in", objComite.acta_comite)
                cmd.Parameters.AddWithValue("@num_sesion_romano_in", objComite.num_sesion_romano)
                cmd.Parameters.AddWithValue("@leyenda_in", objComite.leyenda)
                cmd.Parameters.AddWithValue("@fec_comite_in", objComite.fec_comite)
                cmd.Parameters.AddWithValue("@fec_cre_in", objComite.fec_cre)
                cmd.Parameters.AddWithValue("@fec_mod_in", objComite.fec_mod)
                cmd.Parameters.AddWithValue("@usu_cre_in", objComite.usu_cre)
                cmd.Parameters.AddWithValue("@usu_mod_in", objComite.usu_mod)
                cmd.Parameters.AddWithValue("@cestatus_in", objComite.cestatus)
                cmd.Parameters.AddWithValue("@accionx", objComite.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridcomite As NpgsqlParameter = New NpgsqlParameter("@idcomiter", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridcomite.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridcomite)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idComite = cmd.Parameters("@idcomiter").Value()
                con.Close()
            End Using
        End Using
        Try
            Return messerror
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function


    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetComite(idcomite As Integer, accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_comite_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idcomite_in", idcomite)
                cmd.Parameters.AddWithValue("@accion_in", accion)
                adapt.Fill(dt, "comites")
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
                con.Close()
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