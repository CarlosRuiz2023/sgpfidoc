Imports System.Data
Imports System.Data.Odbc
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Newtonsoft.Json
Imports Npgsql


<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServicePagos
    Inherits System.Web.Services.WebService



    <WebMethod(Description:="ACTUALIZAR PAGOS")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetActPagos(objfiletxt As clsfiletxt, idusu As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString


        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_actualiza_pagos_v2", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@contenidotxt", objfiletxt.contenido)
                cmd.Parameters.AddWithValue("@accionr", objfiletxt.accion)
                cmd.Parameters.AddWithValue("@idusu", idusu)



                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output


                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)


                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = ValidarDBNull(cmd.Parameters("@noerror").Value())
                messerror = ValidarDBNull(cmd.Parameters("@descerror").Value())

                con.Close()
            End Using
        End Using
        Try
            Return "PAGOS ACTUALIZADOS CORRECTAMENTE"
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function


    <WebMethod(Description:="ACTUALIZAR PAGOS")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetActPagosAS400(fec_inicial As String, fec_final As String) As String

        Dim constr_psql As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString

        Dim numerror As Integer = 0
        Dim messerror As String = Nothing
        Dim mensaje As String = Nothing

        Dim odbc_dbLector As OdbcDataReader
        Dim command As New OdbcCommand
        Dim pagos_json As String

        Dim conn As New OdbcConnection("DSN=QDSN_LEON;UID=CFUENTES;PWD=Fidoc_7;LONGDATACOMPAT=1;")
        conn.Open()

        'Dim myDB2Command As iDB2Command = New iDB2Command("SELECT '{""Pagos"":[{""Cooperador"":""3203024001035  "",""Nombre"":""TORRES JAIME  MA. DE LA LUZ"",""Fecha"":20170117,""Importe"":100.00,""LetraRecibo"":""AA"",""Recibo"":2911},{""Cooperador"":""3203024001035  "",""Nombre"":""TORRES JAIME  MA. DE LA LUZ"",""Fecha"":20170117,""Importe"":1000.00,""LetraRecibo"":""AA"",""Recibo"":2912},{""Cooperador"":""3203024001035  "",""Nombre"":""TORRES JAIME  MA. DE LA LUZ"",""Fecha"":20170117,""Importe"":400.00,""LetraRecibo"":""AA"",""Recibo"":2913}],""Error"":{""Id:"":""0"",""Descripcion"":""""}}' AS PAGOS FROM sysibm.sysdummy1", db2Conexion)
        'Dim myDB2Command As iDB2Command = New iDB2Command("SELECT LCSFIDOC.FNC_PAGOS_FIDOC(20231006, 20231106) AS PAGOS  FROM sysibm.sysdummy1", db2Conexion)
        'Dim _strSql = "SELECT trim(LCSFIDOC.FNC_PAGOS_FIDOC(20231103, 20231103)) AS PAGOS  FROM sysibm.sysdummy1"
        'Dim _strSql = "SELECT CLOB(LCSFIDOC.FNC_PAGOS_FIDOC(20231006,20231106))  AS PAGOS  FROM sysibm.sysdummy1"

        command = conn.CreateCommand()
        command.CommandText = "SELECT CLOB(LCSFIDOC.FNC_PAGOS_FIDOC(" + fec_inicial + "," + fec_final + "))  AS PAGOS  FROM sysibm.sysdummy1"
        command.Prepare()
        command.CommandTimeout = 0
        odbc_dbLector = command.ExecuteReader()

        Try

            If (odbc_dbLector.Read) Then
                pagos_json = odbc_dbLector.GetValue(0)
                pagos_json = pagos_json.Replace("\u0000", "")
                pagos_json = pagos_json.Replace("Ã\u001", "Ñ")
                pagos_json = pagos_json.Replace("Ã\u0081", "")
                pagos_json = pagos_json.Trim()

                ' Agrega esto para ver el JSON en la ventana de salida
                System.Diagnostics.Debug.WriteLine("JSON Retornado: " & pagos_json)
            Else
                pagos_json = ""
            End If

            Using con As New NpgsqlConnection(constr_psql)
                Using cmd As New NpgsqlCommand()

                    Dim pagosT = JsonConvert.DeserializeObject(Of clsPagosTesoreria)(pagos_json)
                    cmd.Connection = con
                    con.Open()

                    'cmd.CommandText = "delete from public2.pagos_tesoreria"
                    cmd.CommandText = "delete from public2.pagos_temp"
                    cmd.ExecuteNonQuery()

                    Dim num_pagos = pagosT.Pagos.Count

                    If (num_pagos) Then

                        For Each item As clsPagoTesoreria In pagosT.Pagos
                            Dim coop_s As String = item.Cooperador.Substring(10, 3)
                            Dim obra_s As String = item.Cooperador.Substring(0, 10)
                            Dim year_fec_as400_txt As String = (item.Fecha.ToString).Substring(0, 4)
                            Dim mes_fec_as400_txt As String = (item.Fecha.ToString).Substring(4, 2)
                            Dim dia_fec_as400_txt As String = (item.Fecha.ToString).Substring(6, 2)
                            Dim fec_as400 As String = dia_fec_as400_txt + "/" + mes_fec_as400_txt + "/" + year_fec_as400_txt
                            Dim usu_fidoc As String = "admin"
                            Dim importe = item.Importe.ToString()
                            Dim tipo_mov As String = "1"
                            Dim obra_coop_s As String = item.Cooperador.ToString()
                            Dim fid As String = "0"
                            Dim usucre As String = "admin"
                            Dim p2_recibo As String = item.Recibo.ToString
                            Dim recibo = item.LetraRecibo.ToString() + p2_recibo.PadLeft(8, "0"c)
                            Dim obr_clv_int = "0"
                            Dim mov_activo As String = "1"
                            Dim nombre = item.Nombre.ToString()
                            Dim elemento = fec_as400 + recibo

                            'Dim a = "insert into public2.pagos_tesoreria (cooperador,nombre,fecha,importe,letrarecibo) values ('" + coop_s + "','" + nombre + "','" + fec_as400 + "'," + importe + ",'" + recibo + "');"
                            'cmd.CommandText = "insert into public2.pagos_tesoreria (cooperador,nombre,fecha,importe,letrarecibo) values ('" + coop_s + "','" + nombre + "','" + fec_as400 + "'," + importe + ",'" + recibo + "');"

                            System.Diagnostics.Debug.WriteLine("coop_s: " & coop_s)
                            System.Diagnostics.Debug.WriteLine("obra_s: " & obra_s)
                            System.Diagnostics.Debug.WriteLine("year_fec_as400_txt: " & year_fec_as400_txt)
                            System.Diagnostics.Debug.WriteLine("mes_fec_as400_txt: " & mes_fec_as400_txt)
                            System.Diagnostics.Debug.WriteLine("dia_fec_as400_txt: " & dia_fec_as400_txt)
                            System.Diagnostics.Debug.WriteLine("fec_as400: " & fec_as400)
                            System.Diagnostics.Debug.WriteLine("usu_fidoc: " & usu_fidoc)
                            System.Diagnostics.Debug.WriteLine("importe: " & importe)
                            System.Diagnostics.Debug.WriteLine("tipo_mov: " & tipo_mov)
                            System.Diagnostics.Debug.WriteLine("obra_coop_s: " & obra_coop_s)
                            System.Diagnostics.Debug.WriteLine("fid: " & fid)
                            System.Diagnostics.Debug.WriteLine("usucre: " & usucre)
                            System.Diagnostics.Debug.WriteLine("p2_recibo: " & p2_recibo)
                            System.Diagnostics.Debug.WriteLine("recibo: " & recibo)
                            System.Diagnostics.Debug.WriteLine("obr_clv_int: " & obr_clv_int)
                            System.Diagnostics.Debug.WriteLine("mov_activo: " & mov_activo)
                            System.Diagnostics.Debug.WriteLine("nombre: " & nombre)
                            System.Diagnostics.Debug.WriteLine("elemento: " & elemento)

                            cmd.CommandText = "insert into public2.pagos_temp (elemento,mov_obra_sifidoc,mov_coop_sifidoc,fec_mov_as400,usu_fidoc,monto_abono_sifidoc,tipo_mov_sifidoc,fec_aplic_mov,clave_sifidoc,fid,usucre,folio_pago,coo_clv2,obr_clv_int,mov_activo) values ('" + elemento + "','" + obra_s + "','" + coop_s + "','" + fec_as400 + "','" + usu_fidoc + "'," + importe + "," + tipo_mov + ",'" + fec_as400 + "','" + obra_coop_s + "'," + fid + ",'" + usucre + "','" + recibo + "'," + coop_s + "," + obr_clv_int + "," + mov_activo + ");"
                            cmd.ExecuteNonQuery()
                        Next
                        cmd.CommandText = "update pagos_temp as a set fid = b.fid from public2.frentes as b  WHERE a.clave_sifidoc = (b.obra_sifidoc || b.coopid);"
                        cmd.ExecuteNonQuery()

                        cmd.CommandText = "insert into public2.movtos_financ (mov_obra_sifidoc,mov_coop_sifidoc,fec_mov_as400,usu_sifidoc,monto_abono_sifidoc,tipo_mov_sifidoc,fec_aplic_mov,clave_sifidoc,fid,usucre,folio_cajas,monto_mov,tipo_mov,cactivo) select a.mov_obra_sifidoc,a.mov_coop_sifidoc,a.fec_mov_as400,a.usu_fidoc,a.monto_abono_sifidoc,a.tipo_mov_sifidoc,a.fec_aplic_mov,a.clave_sifidoc,a.fid,a.usucre,a.folio_pago,a.monto_abono_sifidoc,a.tipo_mov_sifidoc,1 as cactivo from pagos_temp as a left join movtos_financ as b on a.folio_pago = b.folio_cajas where b.folio_cajas is null;"
                        cmd.ExecuteNonQuery()

                        cmd.CommandText = "insert into public3.movimientos (mov_obr,mov_coop,mov_fecha,mov_usu,mov_cap,mov_nor,mov_mora,mov_tipo,mov_fecha_cap,mov_ndep,mov_clv1,mov_greq,mov_gejec,mov_recargos,mov_capital,mov_devolver,fid,cactivo) select a.mov_obra_sifidoc,a.mov_coop_sifidoc,a.fec_mov_as400,a.usu_fidoc,a.monto_abono_sifidoc,0 as mov_nor,0 as mov_mora,a.tipo_mov_sifidoc,a.fec_aplic_mov,a.folio_pago,a.mov_obra_sifidoc || a.mov_coop_sifidoc as mov_clv1,0 as mov_greq,0 as mov_gejec,0 as mov_recargos,0 as mov_capital,0 as mov_devolver,a.fid, 1 as cactivo from pagos_temp as a left join public3.movimientos as b on a.folio_pago = b.mov_ndep where b.mov_ndep is null;"
                        cmd.ExecuteNonQuery()

                        cmd.Dispose()
                        con.Close()

                        mensaje = "PAGOS ACTUALIZADOS CORRECTAMENTE"
                    Else

                        mensaje = "NO SE ENCONTRARON PAGOS PARA ACTUALIZAR"

                    End If


                End Using
            End Using


            odbc_dbLector.Close()
            command.Dispose()
            conn.Close()

            Return mensaje

        Catch ex As Exception

            Return "Error " & ex.Message

        End Try

    End Function

    <WebMethod(Description:="OBTENER PAGOS")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetPagosAS400(fec_inicial As String, fec_final As String) As String
        Dim pagos_json As String = ""
        Dim conn As New OdbcConnection("DSN=QDSN_LEON;UID=CFUENTES;PWD=Fidoc_7;LONGDATACOMPAT=1;")
        Try
            conn.Open()
            Dim command As New OdbcCommand("SELECT CLOB(LCSFIDOC.FNC_PAGOS_FIDOC(" & fec_inicial & "," & fec_final & ")) AS PAGOS FROM sysibm.sysdummy1", conn)
            command.Prepare()
            command.CommandTimeout = 0
            Dim odbc_dbLector As OdbcDataReader = command.ExecuteReader()

            If odbc_dbLector.Read() Then
                pagos_json = odbc_dbLector.GetValue(0).ToString()
                pagos_json = pagos_json.Replace("\u0000", "").Replace("Ã\u001", "Ñ").Replace("Ã\u0081", "").Trim()
            End If

            odbc_dbLector.Close()
            command.Dispose()
            conn.Close()
        Catch ex As Exception
            Return JsonConvert.SerializeObject(New With {.Error = New With {.Id = 1, .Descripcion = ex.Message}})
        End Try

        If String.IsNullOrEmpty(pagos_json) Then
            Return JsonConvert.SerializeObject(New With {.Error = New With {.Id = 0, .Descripcion = "No se encontraron pagos"}})
        End If

        'Dim objeto As JQGridJsonResponsePagos = New JQGridJsonResponsePagos
        'objeto.JQGridJsonResponsePagos(pagos_json)
        'Return objeto
        Return pagos_json
    End Function




    <WebMethod(Description:="Inserta pagos en PSQL")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetActPagos2(cv As String, idusu As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString

        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_inserta_pagos_psql", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagostxtx", cv)
                cmd.Parameters.AddWithValue("@idusux", idusu)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output


                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)


                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = ValidarDBNull(cmd.Parameters("@noerror").Value())
                messerror = ValidarDBNull(cmd.Parameters("@descerror").Value())

                con.Close()
            End Using
        End Using
        Try
            Return "Registro de pagos guardados"
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function



    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetRep3(obr_clv_int As Integer, fecha_ini As String, fecha_fin As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_pagos_x_obra", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@obr_clv_int_in", obr_clv_int)
                cmd.Parameters.AddWithValue("@fecha_inicial", fecha_ini)
                cmd.Parameters.AddWithValue("@fecha_final", fecha_fin)
                adapt.Fill(dt, "obras_rep3")
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


    Private Function ValidarDBNull(objParametro As Object) As Object
        Dim tipo_objeto = objParametro.GetType
        If IsDBNull(objParametro.ToString) Then
            ValidarDBNull = ""
        Else
            If objParametro.ToString = "" Then
                If tipo_objeto.Name = "Date" Then
                    ValidarDBNull = "01/01/1900"
                End If
                If tipo_objeto.Name = "Integer" Or tipo_objeto.Name = "Double" Then
                    ValidarDBNull = 0
                End If
                If tipo_objeto.Name = "String" Then
                    ValidarDBNull = ""
                End If
            Else
                ValidarDBNull = objParametro.ToString
            End If
        End If

    End Function

    Private Function json() As Object
        Throw New NotImplementedException
    End Function




End Class