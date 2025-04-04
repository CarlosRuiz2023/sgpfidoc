﻿Imports System.Data
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
Public Class WebServiceTipoRecursoObra
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTipoRecursoObra_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseTipoRecursoObra

        Return GetTiposRecursoObra(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetTiposRecursoObra(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseTipoRecursoObra

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
            Using cmd As New NpgsqlCommand("public2.sp_tipo_recurso_obra_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim tipos_recurso_obra = New List(Of clsTipoRecursoObra)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim tipo_recurso_obra As clsTipoRecursoObra = New clsTipoRecursoObra()
                        tipo_recurso_obra.idtipo_recurso = ValidarDBNull(row.Item("out_idtipo_recursor"), "entero")
                        tipo_recurso_obra.descrip = ValidarDBNull(row.Item("out_descripr"), "cadena")
                        tipo_recurso_obra.observ = ValidarDBNull(row.Item("out_observr"), "cadena")
                        tipo_recurso_obra.usu_cre = ValidarDBNull(row.Item("out_usu_crer"), "entero")
                        tipo_recurso_obra.usu_mod = ValidarDBNull(row.Item("out_usu_modr"), "entero")
                        tipo_recurso_obra.fec_cre = ValidarDBNull(row.Item("out_fec_crer"), "fecha")
                        tipo_recurso_obra.fec_mod = ValidarDBNull(row.Item("out_fec_modr"), "fecha")
                        tipo_recurso_obra.cestatus = ValidarDBNull(row.Item("out_cestatusr"), "entero")
                        tipos_recurso_obra.Add(tipo_recurso_obra)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseTipoRecursoObra = New JQGridJsonResponseTipoRecursoObra
                objeto.JQGridJsonResponseTipoRecursoObra(pagecount, currentpage, recordcount, tipos_recurso_obra)
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
    Public Function GuardarTipoRecursoObra(objTipoRecursoObra As clsTipoRecursoObra) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idTipoRecursoObrar As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_tipo_recurso", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idtipo_recurso_in", objTipoRecursoObra.idtipo_recurso)
                cmd.Parameters.AddWithValue("@descrip_tipo_recurso_in", objTipoRecursoObra.descrip)
                cmd.Parameters.AddWithValue("@observ_tipo_recurso_in", objTipoRecursoObra.observ)
                cmd.Parameters.AddWithValue("@fec_cre_tipo_recurso_in", objTipoRecursoObra.fec_cre)
                cmd.Parameters.AddWithValue("@fec_mod_tipo_recurso_in", objTipoRecursoObra.fec_mod)
                cmd.Parameters.AddWithValue("@usu_cre_tipo_recurso_in", objTipoRecursoObra.usu_cre)
                cmd.Parameters.AddWithValue("@usu_mod_tipo_recurso_in", objTipoRecursoObra.usu_mod)
                cmd.Parameters.AddWithValue("@cestatus_in", objTipoRecursoObra.cestatus)
                cmd.Parameters.AddWithValue("@accionx", objTipoRecursoObra.accion)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridtiporecurso As NpgsqlParameter = New NpgsqlParameter("@idtiporecursor", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridtiporecurso.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridtiporecurso)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idTipoRecursoObrar = cmd.Parameters("@idtiporecursor").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Transaccion ejecutada correctamente:" & idTipoRecursoObrar.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function



    <WebMethod(Description:="Extrae los tipos de asamble para insertarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetTipoRecurso(idtiporecurso As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_tipo_recurso_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idtiporecurso_in", idtiporecurso)
                adapt.Fill(ds, "tipo_recurso")
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