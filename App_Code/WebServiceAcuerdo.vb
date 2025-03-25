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
Public Class WebServiceAcuerdo

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAcuerdo_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseAcuerdo

        Return GetAcuerdos(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetAcuerdos(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseAcuerdo
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
            Using cmd As New NpgsqlCommand("public2.sp_acuerdo_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pPageNumber)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim acuerdos = New List(Of clsAcuerdo)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim acuerdo As clsAcuerdo = New clsAcuerdo()
                        acuerdo.idcomite = ValidarDBNull(row.Item("out_idcomiter"), "entero")
                        acuerdo.idacuerdo = ValidarDBNull(row.Item("out_idacuerdor"), "entero")
                        acuerdo.num_acuerdo = ValidarDBNull(row.Item("out_num_acuerdor"), "cadena")
                        acuerdo.folio_acuerdo = ValidarDBNull(row.Item("out_folio_acuerdor"), "cadena")
                        acuerdo.num_acuerdo_romano = ValidarDBNull(row.Item("out_num_acuerdo_romanor"), "cadena")
                        acuerdo.descrip_acuerdo = ValidarDBNull(row.Item("out_descrip_acuerdor"), "cadena")
                        acuerdo.acuerdo_terminado_txt = ValidarDBNull(row.Item("out_acuerdo_terminador"), "cadena")
                        acuerdo.fec_cre = ValidarDBNull(row.Item("out_fec_crer"), "fecha")
                        acuerdo.fec_mod = ValidarDBNull(row.Item("out_fec_modr"), "fecha")
                        acuerdo.usu_cre = ValidarDBNull(row.Item("out_usu_crer"), "entero")
                        acuerdo.usu_mod = ValidarDBNull(row.Item("out_usu_modr"), "entero")
                        acuerdo.cestatus = ValidarDBNull(row.Item("out_cestatusr"), "entero")
                        acuerdos.Add(acuerdo)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseAcuerdo = New JQGridJsonResponseAcuerdo
                objeto.JQGridJsonResponseAcuerdo(pagecount, currentpage, recordcount, acuerdos)
                Return objeto
            End Using
        End Using
    End Function

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetComiteAcuerdos_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseComiteAcuerdo

        Return GetComiteAcuerdo(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetComiteAcuerdo(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseComiteAcuerdo
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
            Using cmd As New NpgsqlCommand("public2.sp_comite_acuerdo_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pPageNumber)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim comite_acuerdos = New List(Of clsComiteAcuerdo)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim comite_acuerdo As clsComiteAcuerdo = New clsComiteAcuerdo()
                        comite_acuerdo.idcomite = ValidarDBNull(row.Item("out_idcomiter"), "entero")
                        comite_acuerdo.acta_comite = ValidarDBNull(row.Item("out_acta_comiter"), "cadena")
                        comite_acuerdo.num_sesion = ValidarDBNull(row.Item("out_num_sesionr"), "entero")
                        comite_acuerdo.fec_comite = ValidarDBNull(row.Item("out_fec_comiter"), "fecha")
                        comite_acuerdo.leyenda_comite = ValidarDBNull(row.Item("out_leyenda_comiter"), "cadena")
                        comite_acuerdo.idacuerdo = ValidarDBNull(row.Item("out_idacuerdor"), "entero")
                        comite_acuerdo.num_acuerdo = ValidarDBNull(row.Item("out_num_acuerdor"), "entero")
                        comite_acuerdo.folio_acuerdo = ValidarDBNull(row.Item("out_folio_acuerdor"), "cadena")
                        comite_acuerdo.leyenda_acuerdo = ValidarDBNull(row.Item("out_leyenda_acuerdor"), "cadena")
                        comite_acuerdo.estatus_acuerdo = ValidarDBNull(row.Item("out_estatus_acuerdor"), "cadena")
                        comite_acuerdos.Add(comite_acuerdo)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseComiteAcuerdo = New JQGridJsonResponseComiteAcuerdo
                objeto.JQGridJsonResponseComiteAcuerdo(pagecount, currentpage, recordcount, comite_acuerdos)
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
    Public Function GuardarAcuerdo(objAcuerdo As clsAcuerdo) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idAcuerdor As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_acuerdo", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idcomite_in", objAcuerdo.idcomite)
                cmd.Parameters.AddWithValue("@idacuerdo_in", objAcuerdo.idacuerdo)
                cmd.Parameters.AddWithValue("@num_acuerdo_in", objAcuerdo.num_acuerdo)
                cmd.Parameters.AddWithValue("@folio_acuerdo_in", objAcuerdo.folio_acuerdo)
                cmd.Parameters.AddWithValue("@num_acuerdo_romano_in", objAcuerdo.num_acuerdo_romano)
                cmd.Parameters.AddWithValue("@descrip_acuerdo_in", objAcuerdo.descrip_acuerdo)
                cmd.Parameters.AddWithValue("@acuerdo_terminado_in", objAcuerdo.acuerdo_terminado)
                cmd.Parameters.AddWithValue("@fec_cre_in", objAcuerdo.fec_cre)
                cmd.Parameters.AddWithValue("@fec_mod_in", objAcuerdo.fec_mod)
                cmd.Parameters.AddWithValue("@usu_cre_in", objAcuerdo.usu_cre)
                cmd.Parameters.AddWithValue("@usu_mod_in", objAcuerdo.usu_mod)
                cmd.Parameters.AddWithValue("@cestatus_in", objAcuerdo.cestatus)
                cmd.Parameters.AddWithValue("@accionx", objAcuerdo.accion)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridacuerdo As NpgsqlParameter = New NpgsqlParameter("@idacuerdor", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridacuerdo.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridacuerdo)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idAcuerdor = cmd.Parameters("@idacuerdor").Value()
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
    Public Function GetAcuerdo(idacuerdo As Integer, idcomite As Integer, accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_acuerdo_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idacuerdo_in", idacuerdo)
                cmd.Parameters.AddWithValue("@idcomite_in", idcomite)
                cmd.Parameters.AddWithValue("@accion_in", accion)
                adapt.Fill(ds, "acuerdo")
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