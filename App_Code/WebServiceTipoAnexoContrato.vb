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
Public Class WebServiceTipoAnexoContrato
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTipoAnexoContrato_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseTipoAnexoContrato
        Return GetTipoAnexoContrato(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetTipoAnexoContrato(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseTipoAnexoContrato
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
            Using cmd As New NpgsqlCommand("public2.sp_tipo_anexo_contrato_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim TiposAnexoContrato = New List(Of clsTipoAnexoContrato)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim TipoAnexoContrato As clsTipoAnexoContrato = New clsTipoAnexoContrato()
                        TipoAnexoContrato.idtipo_anexo_cont = ValidarDBNull(row.Item("out_idtipo_anexo_cont_r"), "entero")
                        TipoAnexoContrato.etiqueta_anexo = ValidarDBNull(row.Item("out_etiqueta_anexo_r"), "cadena")
                        TipoAnexoContrato.observaciones = ValidarDBNull(row.Item("out_observaciones_r"), "cadena")
                        TipoAnexoContrato.usu_cre = ValidarDBNull(row.Item("out_usu_cre_r"), "entero")
                        TipoAnexoContrato.usu_mod = ValidarDBNull(row.Item("out_usu_mod_r"), "entero")
                        TipoAnexoContrato.fec_cre = ValidarDBNull(row.Item("out_fec_cre_r"), "fecha")
                        TipoAnexoContrato.fec_mod = ValidarDBNull(row.Item("out_fec_mod_r"), "fecha")
                        TipoAnexoContrato.cactivo = ValidarDBNull(row.Item("out_cactivo_r"), "entero")
                        TiposAnexoContrato.Add(TipoAnexoContrato)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseTipoAnexoContrato = New JQGridJsonResponseTipoAnexoContrato
                objeto.JQGridJsonResponseTipoAnexoContrato(pagecount, currentpage, recordcount, TiposAnexoContrato)
                Return objeto
            End Using
        End Using
    End Function

    <WebMethod(Description:="Extrae los roles de usuario para enlistarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetTipoAnexoContrato(idTipoAnexoContrato As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_tipo_anexo_contrato_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idtipo_anexo_contrato_in", idTipoAnexoContrato)
                adapt.Fill(ds, "tipo_anexo_contrato")
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
    Public Function GuardarTipoAnexoContrato(objTipoAnexoContrato As clsTipoAnexoContrato) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idtipo_anexo_contrato_r As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_tipo_anexo_contrato", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idtipo_anexo_cont_in", objTipoAnexoContrato.idtipo_anexo_cont)
                cmd.Parameters.AddWithValue("@etiqueta_anexo_in", objTipoAnexoContrato.etiqueta_anexo)
                cmd.Parameters.AddWithValue("@observaciones_in", objTipoAnexoContrato.observaciones)
                cmd.Parameters.AddWithValue("@usu_cre_in", objTipoAnexoContrato.usu_cre)
                cmd.Parameters.AddWithValue("@usu_mod_in", objTipoAnexoContrato.usu_mod)
                cmd.Parameters.AddWithValue("@fec_cre_in", objTipoAnexoContrato.fec_cre)
                cmd.Parameters.AddWithValue("@fec_mod_in", objTipoAnexoContrato.fec_mod)
                cmd.Parameters.AddWithValue("@cactivo_in", objTipoAnexoContrato.cactivo)
                cmd.Parameters.AddWithValue("@accionx", objTipoAnexoContrato.accion)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim pTipoAnexoContrato As NpgsqlParameter = New NpgsqlParameter("@idtipo_anexo_contrato_r", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                pTipoAnexoContrato.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(pTipoAnexoContrato)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idtipo_anexo_contrato_r = cmd.Parameters("@idtipo_anexo_contrato_r").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente:" & idtipo_anexo_contrato_r.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function

    <WebMethod(Description:="Extrae los roles de usuario para enlistarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ConsultaTipoAnexoContrato(idusu As Integer, idtarea As Integer, idaccion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_tipo_anexo_contrato_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idtipo_anexo_contrato_in", idusu)

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