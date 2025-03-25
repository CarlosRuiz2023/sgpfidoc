Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceAnexoContrato
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAnexoContrato_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonAnexoContrato
        Return GetAnexoContrato(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetAnexoContrato(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonAnexoContrato
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
            Using cmd As New NpgsqlCommand("public2.sp_anexos_contrato_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim anexos_contrato = New List(Of clsAnexoContrato)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim AnexoContrato As clsAnexoContrato = New clsAnexoContrato()
                        AnexoContrato.idcontrato = ValidarDBNull(row.Item("out_idcontrato"), "entero")
                        AnexoContrato.idanexo_contrato = ValidarDBNull(row.Item("out_idanexo_contrato"), "cadena")
                        AnexoContrato.idtipo_anexo_contrato = ValidarDBNull(row.Item("out_idtipo_anexo_contrato"), "cadena")
                        AnexoContrato.etiqueta_anexo_contrato = ValidarDBNull(row.Item("out_etiqueta_anexo"), "entero")
                        AnexoContrato.docto_param1 = ValidarDBNull(row.Item("out_docto_param1"), "entero")
                        AnexoContrato.fecha_param2 = ValidarDBNull(row.Item("out_fecha_param2"), "fecha")
                        AnexoContrato.valor_param3 = ValidarDBNull(row.Item("out_valor_param3"), "fecha")
                        AnexoContrato.valor_param4 = ValidarDBNull(row.Item("out_valor_param4"), "fecha")
                        AnexoContrato.usu_cre = ValidarDBNull(row.Item("out_usu_cre"), "fecha")
                        AnexoContrato.usu_mod = ValidarDBNull(row.Item("out_usu_mod"), "fecha")
                        AnexoContrato.fec_cre = ValidarDBNull(row.Item("out_fec_cre"), "fecha")
                        AnexoContrato.fec_mod = ValidarDBNull(row.Item("out_fec_mod"), "fecha")
                        AnexoContrato.cactivo = ValidarDBNull(row.Item("out_cactivo"), "entero")
                        anexos_contrato.Add(AnexoContrato)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonAnexoContrato = New JQGridJsonAnexoContrato
                objeto.JQGridJsonAnexoContrato(pagecount, currentpage, recordcount, anexos_contrato)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Retorna datos de un predio seleccionado")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GuardarAnexoContrato_BD(objAnexoContrato As clsAnexoContrato) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idanexo_contrato As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_anexo_contrato", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure



                cmd.Parameters.AddWithValue("@obr_idcontrato_in", objAnexoContrato.idcontrato)
                cmd.Parameters.AddWithValue("@obr_docto_param1_in", objAnexoContrato.docto_param1)
                cmd.Parameters.AddWithValue("@obr_fecha_param2_in", objAnexoContrato.fecha_param2)
                cmd.Parameters.AddWithValue("@obr_usu_cre_in", objAnexoContrato.usu_cre)
                cmd.Parameters.AddWithValue("@obr_usu_mod_in", objAnexoContrato.usu_mod)
                cmd.Parameters.AddWithValue("@obr_fec_cre_in", objAnexoContrato.fec_cre)
                cmd.Parameters.AddWithValue("@obr_fec_mod_in", objAnexoContrato.fec_mod)
                cmd.Parameters.AddWithValue("@obr_valor_param3_in", objAnexoContrato.valor_param3)
                cmd.Parameters.AddWithValue("@obr_valor_param4_in", objAnexoContrato.valor_param4)
                cmd.Parameters.AddWithValue("@obr_cactivo_in", objAnexoContrato.cactivo)
                cmd.Parameters.AddWithValue("@obr_idanexo_contrato_in", objAnexoContrato.idanexo_contrato)
                cmd.Parameters.AddWithValue("@obr_idtipo_anexo_contrato_in", objAnexoContrato.idtipo_anexo_contrato)
                cmd.Parameters.AddWithValue("@obr_accion_in", objAnexoContrato.accion)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output
                Dim par_idanexo_contrato As NpgsqlParameter = New NpgsqlParameter("@out_idanexo_contrato", NpgsqlTypes.NpgsqlDbType.Integer, 36) ' .Value = Space(1000)
                par_idanexo_contrato.Direction = ParameterDirection.Output


                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(par_idanexo_contrato)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()
                idanexo_contrato = cmd.Parameters("@out_idanexo_contrato").Value()
                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                con.Close()


            End Using
        End Using
        Try
            If numerror > 0 Then
                Return messerror & ":0"
            Else
                Return "Accion ejecutada correctamente:" & numerror.ToString
            End If
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