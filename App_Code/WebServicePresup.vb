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
Public Class WebServicePresup
    Inherits System.Web.Services.WebService


    <WebMethod(Description:="Retorna datos de un predio seleccionado")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function RegPresup(objPresup As clsPresup) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idpresup As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_presup", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@costomtolinealx", objPresup.CostoMtoLineal)
                cmd.Parameters.AddWithValue("@ctototalobrax", objPresup.CostoTotalObra)
                cmd.Parameters.AddWithValue("@dctox", objPresup.Dcto)
                cmd.Parameters.AddWithValue("@progidx", objPresup.ProgId)
                cmd.Parameters.AddWithValue("@mtsseccionx", objPresup.MtsSeccion)
                cmd.Parameters.AddWithValue("@mtsbanquetax", objPresup.MtsBanqueta)
                cmd.Parameters.AddWithValue("@mtsarroyox", objPresup.MtsArroyo)
                cmd.Parameters.AddWithValue("@gastosadmvosx", objPresup.GastosAdmvos)
                cmd.Parameters.AddWithValue("@foliox", objPresup.Folio)
                cmd.Parameters.AddWithValue("@mts2banquetax", objPresup.Mts2Banqueta)
                cmd.Parameters.AddWithValue("@mts2arroyox", objPresup.Mts2Arroyo)
                cmd.Parameters.AddWithValue("@derramavecinosx", objPresup.DerramaVecinos)
                cmd.Parameters.AddWithValue("@derramaeux", objPresup.DerramaEU)
                cmd.Parameters.AddWithValue("@estatuspresupx", objPresup.EstatusPresup)
                cmd.Parameters.AddWithValue("@oidx", objPresup.oid)
                cmd.Parameters.AddWithValue("@solidx", objPresup.solid)
                cmd.Parameters.AddWithValue("@pridx", objPresup.IdPresup)
                cmd.Parameters.AddWithValue("@usucrex", objPresup.UsuCre)
                cmd.Parameters.AddWithValue("@feccrex", objPresup.FecCre)
                cmd.Parameters.AddWithValue("@usumodx", objPresup.UsuMod)
                cmd.Parameters.AddWithValue("@fecmodx", objPresup.FecMod)
                cmd.Parameters.AddWithValue("@accionx", objPresup.Accion)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output
                Dim parpresupx As NpgsqlParameter = New NpgsqlParameter("@idpresupy", NpgsqlTypes.NpgsqlDbType.Integer, 36) ' .Value = Space(1000)
                parpresupx.Direction = ParameterDirection.Output


                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(parpresupx)

                '  If objPresup.Accion > 2 Then
                'Dim ds As DataSet = New DataSet()
                'adapt.Fill(ds, "Presup")
                'Try
                ' Dim sb = New StringBuilder()
                ' Using writer = New StringWriter(sb)
                ' ds.WriteXml(writer)
                ' Dim xml As String = sb.ToString()
                ' Return xml
                ' End Using
                ' Catch ex As Exception
                ' Return "Error " & ex.Message
                ' End Try
                ' Else
                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()
                idpresup = cmd.Parameters("@idpresupy").Value()
                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()

                'End If
                con.Close()
            End Using
        End Using
        Try
            If numerror > 0 Then
                Return messerror & ":0"
            Else
                Return "Accion ejecutada correctamente:" & idpresup.ToString
            End If
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function


    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPresupuestos(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, idsol As Integer) As JQGridJsonResponsePresup
        Return GetPresupJSon(pPageSize, pCurrentPage, pSortColumn, pSortOrder, idsol)

    End Function

    Private Function GetPresupJSon(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, idsol As Integer) As JQGridJsonResponsePresup
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer



        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_presupgrid2", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pPageNumber)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSorterOrder)
                cmd.Parameters.AddWithValue("@idsol", idsol)
                adapt.Fill(dt)
                Dim presupuestos = New List(Of clsPresup)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim presup As clsPresup = New clsPresup()
                        presup.CostoMtoLineal = row.Item("costomtolinealr")
                        presup.Dcto = row.Item("dctor")
                        presup.ProgId = row.Item("progidr")
                        presup.MtsSeccion = row.Item("mtsseccionr")
                        presup.MtsBanqueta = row.Item("mtsbanquetar")
                        presup.MtsArroyo = row.Item("mtsarroyor")
                        presup.GastosAdmvos = row.Item("gastosadmvosr")
                        presup.Folio = ValidarDBNull(row.Item("folior"))
                        presup.Mts2Arroyo = row.Item("mts2arroyor")
                        presup.Mts2Banqueta = row.Item("mts2banquetar")
                        presup.DerramaVecinos = row.Item("derramavecinosr")
                        presup.DerramaEU = row.Item("derramaeur")
                        presup.EstatusPresup = row.Item("estatuspresupr")
                        presup.IdPresup = row.Item("idpresupr")
                        presup.UsuCre = ValidarDBNull(row.Item("usucrer"))
                        presup.FecCre = ValidarDBNull(row.Item("feccrer"))
                        presup.UsuMod = ValidarDBNull(row.Item("usumodr"))
                        presup.FecMod = ValidarDBNull(row.Item("fecmodr"))
                        presup.oid = ValidarDBNull(row.Item("oidr"))
                        presup.solid = row.Item("solidr")
                        presupuestos.Add(presup)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponsePresup = New JQGridJsonResponsePresup
                objeto.JQGridJsonResponsePresup(pagecount, currentpage, recordcount, presupuestos)
                Return objeto

            End Using
        End Using
    End Function


    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetPresup(idsol As String, idpresup As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("select a.*,b.mnomarchivo from presupuesto as a inner join mdcto as b on a.prid = b.midref where a.prid=" + idpresup.ToString + "and midsol=" + idsol.ToString, con)

                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)

                adapt.MissingSchemaAction = MissingSchemaAction.AddWithKey
                adapt.Fill(dt, "Presup")
            End Using
        End Using

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


    End Function
    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetPresupObra(oid As Integer, prid As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("select a.*,b.mnomarchivo from presupuesto as a inner join mdcto as b on a.prid = b.midref where estatus_presup in (1,2,3) and a.prid=" + prid.ToString + " and oid=" + oid.ToString, con)

                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)

                adapt.MissingSchemaAction = MissingSchemaAction.AddWithKey
                adapt.Fill(dt, "Presup")
            End Using
        End Using

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


    End Function


    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetPresupprog(oid As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("select a.costo_mto_lineal,a.costo_total_obra,a.idprog,a.prid,a.oid,b.nomprog,b.progdescrip from presupuesto as a inner join programa as b on a.idprog = b.idprog  where estatus_presup in (1,2,3) and oid =" + oid.ToString + " and b.activo = 1", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.MissingSchemaAction = MissingSchemaAction.AddWithKey
                adapt.Fill(dt, "presupprog")
            End Using
        End Using

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
    End Function



    Private Function ValidarDBNull(objParametro As Object) As Object
        If IsDBNull(objParametro.ToString) Then
            ValidarDBNull = ""
        Else
            If objParametro.ToString = "" Then
                ValidarDBNull = 0
            Else
                ValidarDBNull = objParametro.ToString
            End If
        End If
    End Function


End Class