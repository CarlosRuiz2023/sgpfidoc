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
Public Class WebServiceContratista
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetContratista_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseContratista

        Return GetContratista(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetContratista(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseContratista
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
            Using cmd As New NpgsqlCommand("public2.sp_contratista_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim contratistas = New List(Of clsContratista)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim contratista As clsContratista = New clsContratista()
                        contratista.idContratista = ValidarDBNull(row.Item("out_idcontratista_r"), "entero")
                        contratista.nom_cont = ValidarDBNull(row.Item("out_nom_cont_r"), "cadena")
                        contratista.razonsoc_cont = ValidarDBNull(row.Item("out_razonsoc_cont_r"), "cadena")
                        contratista.rfc_cont = ValidarDBNull(row.Item("out_rfc_cont_r"), "cadena")
                        contratista.num_prov_cont = ValidarDBNull(row.Item("out_num_prov_cont_r"), "cadena")
                        contratista.reg_pub_cont = ValidarDBNull(row.Item("out_reg_pub_cont_r"), "cadena")
                        contratista.repres_legal_cont = ValidarDBNull(row.Item("out_repres_legal_cont_r"), "cadena")
                        contratista.calle_cont = ValidarDBNull(row.Item("out_calle_cont_r"), "cadena")
                        contratista.colonia_cont = ValidarDBNull(row.Item("out_colonia_cont_r"), "cadena")
                        contratista.ciudad_cont = ValidarDBNull(row.Item("out_ciudad_cont_r"), "cadena")
                        contratista.estado_cont = ValidarDBNull(row.Item("out_estado_cont_r"), "cadena")
                        contratista.tel1_cont = ValidarDBNull(row.Item("out_tel1_cont_r"), "cadena")
                        contratista.tel2_cont = ValidarDBNull(row.Item("out_tel2_cont_r"), "cadena")
                        contratista.email = ValidarDBNull(row.Item("out_email_r"), "cadena")
                        contratista.cp_cont = ValidarDBNull(row.Item("out_cp_cont_r"), "cadena")
                        contratista.no_oficial_cont = ValidarDBNull(row.Item("out_no_oficial_r"), "cadena")
                        contratista.usu_cre = ValidarDBNull(row.Item("out_usu_cre_r"), "entero")
                        contratista.usu_mod = ValidarDBNull(row.Item("out_usu_mod_r"), "entero")
                        contratista.fec_cre = ValidarDBNull(row.Item("out_fec_cre_r"), "fecha")
                        contratista.fec_mod = ValidarDBNull(row.Item("out_fec_mod_r"), "fecha")
                        contratista.cestatus = ValidarDBNull(row.Item("out_cestatus_r"), "entero")
                        contratistas.Add(contratista)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseContratista = New JQGridJsonResponseContratista
                objeto.JQGridJsonResponseContratista(pagecount, currentpage, recordcount, contratistas)
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
    Public Function GuardarContratista(objContratista As clsContratista) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idContratistar As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_contratista", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idcontratista_in", objContratista.idContratista)
                cmd.Parameters.AddWithValue("@nom_cont_in", objContratista.nom_cont)
                cmd.Parameters.AddWithValue("@razonsoc_cont_in", objContratista.razonsoc_cont)
                cmd.Parameters.AddWithValue("@rfc_cont_in", objContratista.rfc_cont)
                cmd.Parameters.AddWithValue("@num_prov_cont_in", objContratista.num_prov_cont)
                cmd.Parameters.AddWithValue("@reg_pub_cont_in", objContratista.reg_pub_cont)
                cmd.Parameters.AddWithValue("@repres_legal_in", objContratista.repres_legal_cont)
                cmd.Parameters.AddWithValue("@calle_cont_in", objContratista.calle_cont)
                cmd.Parameters.AddWithValue("@colonia_cont_in", objContratista.colonia_cont)
                cmd.Parameters.AddWithValue("@ciudad_cont_in", objContratista.ciudad_cont)
                cmd.Parameters.AddWithValue("@estado_cont_in", objContratista.estado_cont)
                cmd.Parameters.AddWithValue("@tel1_cont_in", objContratista.tel1_cont)
                cmd.Parameters.AddWithValue("@tel2_cont_in", objContratista.tel2_cont)
                cmd.Parameters.AddWithValue("@email_in", objContratista.email)
                cmd.Parameters.AddWithValue("@cp_cont_in", objContratista.cp_cont)
                cmd.Parameters.AddWithValue("@no_oficial_cont_in", objContratista.no_oficial_cont)
                cmd.Parameters.AddWithValue("@usu_cre_cont_in", objContratista.usu_cre)
                cmd.Parameters.AddWithValue("@usu_mod_cont_in", objContratista.usu_mod)
                cmd.Parameters.AddWithValue("@fec_cre_in", objContratista.fec_cre)
                cmd.Parameters.AddWithValue("@fec_mod_in", objContratista.fec_mod)
                cmd.Parameters.AddWithValue("@cestatus_in", objContratista.cestatus)
                cmd.Parameters.AddWithValue("@accionx", objContratista.accion)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridcontratista As NpgsqlParameter = New NpgsqlParameter("@idcontratistar", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridcontratista.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridcontratista)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idContratistar = cmd.Parameters("@idcontratistar").Value()
                con.Close()
            End Using
        End Using
        Try
            Return messerror
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function


    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetContratista_q(idcontratista As Integer, accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_contratista_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idcontratista_in", idcontratista)
                cmd.Parameters.AddWithValue("@accion_in", accion)
                adapt.Fill(ds, "contratista")
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