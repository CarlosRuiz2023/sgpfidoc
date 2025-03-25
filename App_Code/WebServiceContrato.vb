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
Public Class WebServiceContrato
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetContrato_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseContrato

        Return GetContrato(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetContrato(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseContrato
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
            Using cmd As New NpgsqlCommand("public2.sp_contrato_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim contratos = New List(Of clsContrato)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim contrato As clsContrato = New clsContrato()
                        contrato.idcontrato = ValidarDBNull(row.Item("out_idcontrato_r"), "entero")
                        contrato.num_contrato = ValidarDBNull(row.Item("out_num_contrato_r"), "cadena")
                        contrato.num_contrato_limpio = ValidarDBNull(row.Item("out_num_contrato_limpio_r"), "cadena")
                        contrato.obs_contrato = ValidarDBNull(row.Item("out_obs_contrato_r"), "cadena")
                        contrato.monto_contrato_sin_iva = ValidarDBNull(row.Item("out_monto_contrato_sin_iva_r"), "real")
                        contrato.monto_contrato = ValidarDBNull(row.Item("out_monto_contrato_r"), "real")
                        contrato.iva_contrato = ValidarDBNull(row.Item("out_iva_contrato_r"), "real")
                        contrato.idcontratista = ValidarDBNull(row.Item("out_idcontratista_r"), "cadena")
                        contrato.nom_contratista = ValidarDBNull(row.Item("out_nom_contratista_r"), "cadena")
                        contrato.rfc_contratista = ValidarDBNull(row.Item("out_rfc_contratista_r"), "cadena")
                        contrato.fec_contrato = ValidarDBNull(row.Item("out_fec_contrato_r"), "cadena")
                        contrato.fec_ini_contrato = ValidarDBNull(row.Item("out_fec_ini_contrato_r"), "cadena")
                        contrato.fec_fin_contrato = ValidarDBNull(row.Item("out_fec_fin_contrato_r"), "cadena")
                        contrato.fec_prorroga = ValidarDBNull(row.Item("out_fec_prorroga_r"), "cadena")
                        contrato.anticipo = ValidarDBNull(row.Item("out_anticipo_r"), "real")
                        contrato.docto_contrato = ValidarDBNull(row.Item("out_docto_contrato_r"), "cadena")
                        contrato.idtipoasignacion = ValidarDBNull(row.Item("out_idtipoasignacion_r"), "entero")
                        contrato.tipo_asignacion = ValidarDBNull(row.Item("out_tipo_asignacion_r"), "cadena")
                        contrato.fec_cre = ValidarDBNull(row.Item("out_fec_cre_r"), "fecha")
                        contrato.fec_mod = ValidarDBNull(row.Item("out_fec_mod_r"), "fecha")
                        contrato.usu_cre = ValidarDBNull(row.Item("out_usu_cre_r"), "fecha")
                        contrato.usu_mod = ValidarDBNull(row.Item("out_usu_mod_r"), "fecha")
                        contrato.cestatus = ValidarDBNull(row.Item("out_cestatus_r"), "entero")
                        contratos.Add(contrato)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseContrato = New JQGridJsonResponseContrato
                objeto.JQGridJsonResponseContrato(pagecount, currentpage, recordcount, contratos)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Recaba los contratos de una obra")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetContrato_x_ObraGrid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponseObraContrato
        Return GetContratoxObra(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pfiltro)

    End Function

    Private Function GetContratoxObra(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseObraContrato
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
            Using cmd As New NpgsqlCommand("public2.sp_contratos_x_obra_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pPageNumber)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim contratos_x_obra = New List(Of clsObraContrato)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim contrato_x_obra As clsObraContrato = New clsObraContrato()
                        contrato_x_obra.oid = ValidarDBNull(row.Item("out_oid"), "entero")
                        contrato_x_obra.obr_clv_int = ValidarDBNull(row.Item("out_obr_clv_int"), "entero")
                        contrato_x_obra.obr_clv = ValidarDBNull(row.Item("out_obr_clv"), "cadena")
                        contrato_x_obra.idcontrato = ValidarDBNull(row.Item("out_idcontrato"), "entero")
                        contrato_x_obra.num_contrato = ValidarDBNull(row.Item("out_num_contrato"), "cadena")
                        contrato_x_obra.calle = ValidarDBNull(row.Item("out_calle"), "cadena")
                        contrato_x_obra.colonia = ValidarDBNull(row.Item("out_colonia"), "cadena")
                        contrato_x_obra.tramo = ValidarDBNull(row.Item("out_tramo"), "cadena")
                        contrato_x_obra.idprog = ValidarDBNull(row.Item("out_idprog"), "integer")
                        contrato_x_obra.nomprog = ValidarDBNull(row.Item("out_nomprog"), "cadena")
                        contrato_x_obra.docto_contrato = ValidarDBNull(row.Item("out_docto_contrato"), "cadena")
                        contrato_x_obra.idanexo_contrato = ValidarDBNull(row.Item("out_idanexo_contrato"), "entero")
                        contrato_x_obra.docto_param1 = ValidarDBNull(row.Item("out_docto_param1"), "cadena")
                        contrato_x_obra.fecha_param2 = ValidarDBNull(row.Item("out_fecha_param2"), "fecha")
                        contrato_x_obra.valor_param3 = ValidarDBNull(row.Item("out_valor_param3"), "entero")
                        contrato_x_obra.valor_param4 = ValidarDBNull(row.Item("out_valor_param4"), "real")
                        contrato_x_obra.idtipo_anexo_contrato = ValidarDBNull(row.Item("out_idtipo_anexo_contrato"), "entero")
                        contrato_x_obra.etiqueta_anexo = ValidarDBNull(row.Item("out_etiqueta_anexo"), "cadena")
                        contratos_x_obra.Add(contrato_x_obra)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseObraContrato = New JQGridJsonResponseObraContrato
                objeto.JQGridJsonResponseObraContrato(pagecount, currentpage, recordcount, contratos_x_obra)
                Return objeto
            End Using
        End Using
    End Function



    <WebMethod(Description:="Recaba los contratos de una obra")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetContratoAnexos_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseContratoAnexos
        Return GetContratoAnexos(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetContratoAnexos(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseContratoAnexos
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
            Using cmd As New NpgsqlCommand("public2.sp_contrato_anexos_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim contratos_anexos = New List(Of clsContratoAnexos)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim contrato_anexos As clsContratoAnexos = New clsContratoAnexos()
                        contrato_anexos.oid = ValidarDBNull(row.Item("oid_r"), "entero")
                        contrato_anexos.obr_clv_int = ValidarDBNull(row.Item("obr_clv_int_r"), "entero")
                        contrato_anexos.obr_clv = ValidarDBNull(row.Item("obr_clv_r"), "cadena")
                        contrato_anexos.idcontrato = ValidarDBNull(row.Item("idcontrato_r"), "entero")
                        contrato_anexos.num_contrato_limpio = ValidarDBNull(row.Item("num_contrato_limpio_r"), "cadena")
                        contrato_anexos.calle = ValidarDBNull(row.Item("calle_r"), "cadena")
                        contrato_anexos.colonia = ValidarDBNull(row.Item("colonia_r"), "cadena")
                        contrato_anexos.tramo = ValidarDBNull(row.Item("tramo_r"), "cadena")
                        contrato_anexos.obr_prog2 = ValidarDBNull(row.Item("obr_prog2_r"), "integer")
                        contrato_anexos.nomprog = ValidarDBNull(row.Item("nomprog_r"), "cadena")
                        contrato_anexos.docto_contrato = ValidarDBNull(row.Item("docto_contrato_r"), "cadena")
                        contrato_anexos.cestatus_contrato = ValidarDBNull(row.Item("cestatus_contrato_r"), "integer")
                        contrato_anexos.idanexo_contrato = ValidarDBNull(row.Item("idanexo_contrato_r"), "integer")
                        contrato_anexos.idtipo_anexo_contrato = ValidarDBNull(row.Item("idtipo_anexo_contrato_r"), "integer")
                        contrato_anexos.etiqueta_anexo = ValidarDBNull(row.Item("etiqueta_anexo_r"), "cadena")
                        contrato_anexos.docto_param1 = ValidarDBNull(row.Item("docto_param1_r"), "cadena")
                        contrato_anexos.fecha_param2 = ValidarDBNull(row.Item("fecha_param2_r"), "fecha")
                        contrato_anexos.valor_param3 = ValidarDBNull(row.Item("valor_param3_r"), "entero")
                        contrato_anexos.valor_param4 = ValidarDBNull(row.Item("valor_param4_r"), "real")
                        contrato_anexos.cactivo_anexo_contrato = ValidarDBNull(row.Item("cactivo_anexo_contrato_r"), "entero")
                        contratos_anexos.Add(contrato_anexos)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseContratoAnexos = New JQGridJsonResponseContratoAnexos
                objeto.JQGridJsonResponseContratoAnexos(pagecount, currentpage, recordcount, contratos_anexos)
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
    Public Function GuardarContrato(objContrato As clsContrato) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idContrato As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_contrato", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idcontrato_in", objContrato.idcontrato)
                cmd.Parameters.AddWithValue("@num_contrato_in", objContrato.num_contrato)
                cmd.Parameters.AddWithValue("@num_contrato_limpio_in", objContrato.num_contrato_limpio)
                cmd.Parameters.AddWithValue("@obs_contrato_in", objContrato.obs_contrato)
                cmd.Parameters.AddWithValue("@monto_contrato_sin_iva_in", objContrato.monto_contrato_sin_iva)
                cmd.Parameters.AddWithValue("@monto_contrato_in", objContrato.monto_contrato)
                cmd.Parameters.AddWithValue("@iva_contrato_in", objContrato.iva_contrato)
                cmd.Parameters.AddWithValue("@idcontratista_in", objContrato.idcontratista)
                cmd.Parameters.AddWithValue("@fec_contrato_in", objContrato.fec_contrato)
                cmd.Parameters.AddWithValue("@fec_ini_contrato_in", objContrato.fec_ini_contrato)
                cmd.Parameters.AddWithValue("@fec_fin_contrato_in", objContrato.fec_fin_contrato)
                cmd.Parameters.AddWithValue("@fec_prorroga_in", objContrato.fec_prorroga)
                cmd.Parameters.AddWithValue("@anticipo_in", objContrato.anticipo)
                cmd.Parameters.AddWithValue("@docto_contrato_in", objContrato.docto_contrato)
                cmd.Parameters.AddWithValue("@idtipoasignacion_in", objContrato.idtipoasignacion)
                cmd.Parameters.AddWithValue("@usu_cre_in", objContrato.usu_cre)
                cmd.Parameters.AddWithValue("@usu_mod_in", objContrato.usu_mod)
                cmd.Parameters.AddWithValue("@fec_cre_in", objContrato.fec_cre)
                cmd.Parameters.AddWithValue("@fec_mod_in", objContrato.fec_mod)
                cmd.Parameters.AddWithValue("@cestatus_in", objContrato.cestatus)
                cmd.Parameters.AddWithValue("@accionx", objContrato.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridcontrato As NpgsqlParameter = New NpgsqlParameter("@idcontrator", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridcontrato.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridcontrato)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idContrato = cmd.Parameters("@idcontrator").Value()
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
    Public Function RegistraContratoObra(objObraContrato As clsObraContrato) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idContrato As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_contrato_obra", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@oid_in", objObraContrato.oid)
                cmd.Parameters.AddWithValue("@idcontrato_in", objObraContrato.idcontrato)
                cmd.Parameters.AddWithValue("@idusu_in", objObraContrato.idusu)
                cmd.Parameters.AddWithValue("@accion_in", objObraContrato.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridcontrato As NpgsqlParameter = New NpgsqlParameter("@idcontrator", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridcontrato.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridcontrato)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idContrato = cmd.Parameters("@idcontrator").Value()
                con.Close()
            End Using
        End Using
        Try
            Return messerror
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function



    <WebMethod(Description:="Extrae los tipos de asamble para insertarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetContrato_q(idcontrato As Integer, idaccion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_contrato_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idcontrato_in", idcontrato)
                cmd.Parameters.AddWithValue("@idaccion_in", idaccion)
                adapt.Fill(ds, "contratos")
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


    <WebMethod(Description:="Extrae los tipos de asamble para insertarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetContrato_q2(contratos As String, idaccion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_contrato_q2", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idcontratos_in", contratos)
                cmd.Parameters.AddWithValue("@idaccion_in", idaccion)
                adapt.Fill(ds, "contratos")
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