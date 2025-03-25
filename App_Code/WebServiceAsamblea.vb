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
Public Class WebServiceAsamblea
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAsamblea_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseAsamblea

        Return GetAsambleas(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetAsambleas(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseAsamblea
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
            Using cmd As New NpgsqlCommand("public2.sp_asamblea_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim asambleas = New List(Of clsAsamblea)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim asamblea As clsAsamblea = New clsAsamblea()
                        asamblea.idasamblea = ValidarDBNull(row.Item("out_idasamblea_r"), "entero")
                        asamblea.lugar = ValidarDBNull(row.Item("out_lugar_r"), "cadena")
                        asamblea.idpromotor = ValidarDBNull(row.Item("out_idpromotor_r"), "entero")
                        asamblea.nom_promotor = ValidarDBNull(row.Item("out_nom_promotor_r"), "cadena")
                        asamblea.idtasamblea = ValidarDBNull(row.Item("out_idtasamblea_r"), "entero")
                        asamblea.nom_tasamblea = ValidarDBNull(row.Item("out_nom_tasamblea_r"), "cadena")
                        asamblea.fecha_asamblea = ValidarDBNull(row.Item("out_fecha_asamblea_r"), "fecha")
                        asamblea.num_asistentes = ValidarDBNull(row.Item("out_num_asistentes_r"), "entero")
                        asamblea.num_asistentes_m = ValidarDBNull(row.Item("out_num_asistentes_m_r"), "entero")
                        asamblea.fecha_programa = ValidarDBNull(row.Item("out_fecha_programa_r"), "fecha")
                        asamblea.docto_evidencia = ValidarDBNull(row.Item("out_docto_evidencia_r"), "cadena")
                        asamblea.oid = ValidarDBNull(row.Item("out_oid_r"), "entero")
                        asamblea.estatus_asamblea = ValidarDBNull(row.Item("out_estatus_asamblea_r"), "entero")
                        asamblea.cestatus = ValidarDBNull(row.Item("out_cestatus_r"), "cadena")
                        asamblea.usu_cre = ValidarDBNull(row.Item("out_usu_cre_r"), "entero")
                        asamblea.usu_cre = ValidarDBNull(row.Item("out_usu_mod_r"), "entero")
                        asamblea.fec_cre = ValidarDBNull(row.Item("out_fec_cre_r"), "fecha")
                        asamblea.fec_mod = ValidarDBNull(row.Item("out_fec_mod_r"), "fecha")
                        asamblea.calle = ValidarDBNull(row.Item("out_calle_r"), "cadena")
                        asamblea.colonia = ValidarDBNull(row.Item("out_colonia_r"), "cadena")
                        asamblea.tramo = ValidarDBNull(row.Item("out_tramo_r"), "cadena")
                        asambleas.Add(asamblea)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseAsamblea = New JQGridJsonResponseAsamblea
                objeto.JQGridJsonResponseAsamblea(pagecount, currentpage, recordcount, asambleas)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Extrae los tipos de asamble para insertarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetRevisionAsambleas_X_oid(oid As Integer, accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString

        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_asamblea_costo_x_oid", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@oid_in", oid)
                cmd.Parameters.AddWithValue("@accion_in", accion)

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
            Return numerror.ToString() & ":" & messerror.ToString
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

    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GuardarAsamblea(objAsamblea As clsAsamblea) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idAsamblear As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_asamblea", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idasamblea_in", objAsamblea.idasamblea)
                cmd.Parameters.AddWithValue("@lugar_in", objAsamblea.lugar)
                cmd.Parameters.AddWithValue("@idtasamblea_in", objAsamblea.idtasamblea)
                cmd.Parameters.AddWithValue("@fecha_asamblea_in", objAsamblea.fecha_asamblea)
                cmd.Parameters.AddWithValue("@num_asistentes_in", objAsamblea.num_asistentes)
                cmd.Parameters.AddWithValue("@num_asistentes_m_in", objAsamblea.num_asistentes_m)
                cmd.Parameters.AddWithValue("@fecha_programa_in", objAsamblea.fecha_programa)
                cmd.Parameters.AddWithValue("@docto_evidencia_in", objAsamblea.docto_evidencia)
                cmd.Parameters.AddWithValue("@oid_in", objAsamblea.oid)
                cmd.Parameters.AddWithValue("@usu_cre_in", objAsamblea.usu_cre)
                cmd.Parameters.AddWithValue("@usu_mod_in", objAsamblea.usu_mod)
                cmd.Parameters.AddWithValue("@fec_cre_in", objAsamblea.fec_cre)
                cmd.Parameters.AddWithValue("@fec_mod_in", objAsamblea.fec_mod)
                cmd.Parameters.AddWithValue("@estatus_asamblea_in", objAsamblea.estatus_asamblea)
                cmd.Parameters.AddWithValue("@idpromotor_in", objAsamblea.idpromotor)
                cmd.Parameters.AddWithValue("@idpresup_in", objAsamblea.idpresup)
                cmd.Parameters.AddWithValue("@accionx", objAsamblea.accion)
                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridasamblea As NpgsqlParameter = New NpgsqlParameter("@idasamblear", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridasamblea.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridasamblea)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idAsamblear = cmd.Parameters("@idasamblear").Value()
                con.Close()
            End Using
        End Using

        Return messerror.ToString()

    End Function


End Class