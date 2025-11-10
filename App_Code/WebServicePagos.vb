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
        Dim mensaje As String = Nothing
        Dim odbc_dbLector As OdbcDataReader
        Dim command As New OdbcCommand
        Dim pagos_json As String

        Try
            Dim conn As New OdbcConnection("DSN=QDSN_LEON;UID=CFUENTES;PWD=Fidoc_9;LONGDATACOMPAT=1;")
            conn.Open()

            command = conn.CreateCommand()
            command.CommandText = "SELECT CLOB(LCSFIDOC.FNC_PAGOS_FIDOC(" + fec_inicial + "," + fec_final + "))  AS PAGOS  FROM sysibm.sysdummy1"
            command.Prepare()
            command.CommandTimeout = 0
            odbc_dbLector = command.ExecuteReader()

            If (odbc_dbLector.Read) Then
                pagos_json = odbc_dbLector.GetValue(0)
                pagos_json = pagos_json.Replace("\u0000", "")
                pagos_json = pagos_json.Replace("Ã\u001", "Ñ")
                pagos_json = pagos_json.Replace("Ã\u0081", "")
                pagos_json = pagos_json.Trim()
            Else
                pagos_json = ""
            End If

            Using con As New NpgsqlConnection(constr_psql)
                Using cmd As New NpgsqlCommand()
                    cmd.Connection = con
                    con.Open()

                    ' *** LOCK A NIVEL DE BASE DE DATOS - CRÍTICO ***
                    ' Este número debe ser único para esta función
                    cmd.CommandText = "SELECT pg_advisory_lock(987654321)"
                    cmd.ExecuteNonQuery()

                    Try
                        ' Limpieza de tabla temporal
                        cmd.CommandText = "DELETE FROM public2.pagos_temp"
                        cmd.ExecuteNonQuery()

                        Dim pagosT = JsonConvert.DeserializeObject(Of clsPagosTesoreria)(pagos_json)
                        Dim num_pagos = pagosT.Pagos.Count
                        Dim pagos_insertados As Integer = 0
                        Dim pagos_duplicados As Integer = 0

                        If (num_pagos > 0) Then
                            For Each item As clsPagoTesoreria In pagosT.Pagos
                                Dim coop_s As String = item.Cooperador.Substring(10, 3)
                                Dim obra_s As String = item.Cooperador.Substring(0, 10)
                                Dim year_fec_as400_txt As String = (item.Fecha.ToString).Substring(0, 4)
                                Dim mes_fec_as400_txt As String = (item.Fecha.ToString).Substring(4, 2)
                                Dim dia_fec_as400_txt As String = (item.Fecha.ToString).Substring(6, 2)
                                Dim fec_as400 As String = year_fec_as400_txt + "-" + mes_fec_as400_txt + "-" + dia_fec_as400_txt
                                Dim fecha_datetime As DateTime = DateTime.ParseExact(fec_as400, "yyyy-MM-dd", Nothing)
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
                                Dim elemento = fec_as400 + recibo

                                ' VALIDACIÓN dentro del lock
                                cmd.CommandText = "SELECT COUNT(*) FROM public2.movtos_financ WHERE folio_cajas = @folio_pago"
                                cmd.Parameters.Clear()
                                cmd.Parameters.AddWithValue("@folio_pago", recibo)
                                Dim existe_pago As Integer = Convert.ToInt32(cmd.ExecuteScalar())

                                If existe_pago = 0 Then
                                    cmd.CommandText = "INSERT INTO public2.pagos_temp (elemento,mov_obra_sifidoc,mov_coop_sifidoc,fec_mov_as400,usu_fidoc,monto_abono_sifidoc,tipo_mov_sifidoc,fec_aplic_mov,clave_sifidoc,fid,usucre,folio_pago,coo_clv2,obr_clv_int,mov_activo) VALUES (@elemento,@obra_s,@coop_s,@fec_as400,@usu_fidoc,@importe,@tipo_mov,@fec_aplic_mov,@obra_coop_s,@fid,@usucre,@recibo,@coop_s2,@obr_clv_int,@mov_activo)"
                                    cmd.Parameters.Clear()
                                    cmd.Parameters.AddWithValue("@elemento", elemento)
                                    cmd.Parameters.AddWithValue("@obra_s", obra_s)
                                    cmd.Parameters.AddWithValue("@coop_s", coop_s)
                                    cmd.Parameters.AddWithValue("@fec_as400", fecha_datetime)
                                    cmd.Parameters.AddWithValue("@usu_fidoc", usu_fidoc)
                                    cmd.Parameters.AddWithValue("@importe", Convert.ToDecimal(importe))
                                    cmd.Parameters.AddWithValue("@tipo_mov", Convert.ToInt32(tipo_mov))
                                    cmd.Parameters.AddWithValue("@fec_aplic_mov", fecha_datetime)
                                    cmd.Parameters.AddWithValue("@obra_coop_s", obra_coop_s)
                                    cmd.Parameters.AddWithValue("@fid", Convert.ToInt32(fid))
                                    cmd.Parameters.AddWithValue("@usucre", usucre)
                                    cmd.Parameters.AddWithValue("@recibo", recibo)
                                    cmd.Parameters.AddWithValue("@coop_s2", Convert.ToInt64(coop_s))
                                    cmd.Parameters.AddWithValue("@obr_clv_int", Convert.ToInt32(obr_clv_int))
                                    cmd.Parameters.AddWithValue("@mov_activo", Convert.ToInt32(mov_activo))
                                    cmd.ExecuteNonQuery()
                                    pagos_insertados += 1
                                Else
                                    pagos_duplicados += 1
                                End If
                            Next

                            cmd.CommandText = "DELETE FROM public2.pagos_temp a USING public2.pagos_temp b WHERE a.ctid < b.ctid AND a.folio_pago = b.folio_pago"
                            cmd.ExecuteNonQuery()

                            cmd.CommandText = "SELECT COUNT(*) FROM public2.pagos_temp"
                            cmd.Parameters.Clear()
                            Dim registros_temp As Integer = Convert.ToInt32(cmd.ExecuteScalar())

                            If registros_temp > 0 Then
                                cmd.CommandText = "UPDATE pagos_temp AS a SET fid = b.fid FROM public2.frentes AS b WHERE a.clave_sifidoc = (b.obra_sifidoc || b.coopid)"
                                cmd.Parameters.Clear()
                                cmd.ExecuteNonQuery()

                                cmd.CommandText = "INSERT INTO public2.movtos_financ (mov_obra_sifidoc,mov_coop_sifidoc,fec_mov_as400,usu_sifidoc,monto_abono_sifidoc,tipo_mov_sifidoc,fec_aplic_mov,clave_sifidoc,fid,usucre,folio_cajas,monto_mov,tipo_mov,cactivo) SELECT a.mov_obra_sifidoc,a.mov_coop_sifidoc,a.fec_mov_as400,a.usu_fidoc,a.monto_abono_sifidoc,a.tipo_mov_sifidoc,a.fec_aplic_mov,a.clave_sifidoc,a.fid,a.usucre,a.folio_pago,a.monto_abono_sifidoc,a.tipo_mov_sifidoc,1 FROM pagos_temp AS a WHERE NOT EXISTS (SELECT 1 FROM public2.movtos_financ WHERE folio_cajas = a.folio_pago)"
                                cmd.Parameters.Clear()
                                cmd.ExecuteNonQuery()

                                cmd.CommandText = "INSERT INTO public3.movimientos (mov_obr,mov_coop,mov_fecha,mov_usu,mov_cap,mov_nor,mov_mora,mov_tipo,mov_fecha_cap,mov_ndep,mov_clv1,mov_greq,mov_gejec,mov_recargos,mov_capital,mov_devolver,fid,cactivo) SELECT a.mov_obra_sifidoc,a.mov_coop_sifidoc,a.fec_mov_as400,a.usu_fidoc,a.monto_abono_sifidoc,0,0,a.tipo_mov_sifidoc,a.fec_aplic_mov,a.folio_pago,a.mov_obra_sifidoc || a.mov_coop_sifidoc,0,0,0,0,0,a.fid,1 FROM pagos_temp AS a LEFT JOIN public3.movimientos AS b ON a.folio_pago = b.mov_ndep WHERE b.mov_ndep IS NULL"
                                cmd.Parameters.Clear()
                                cmd.ExecuteNonQuery()

                                mensaje = "PAGOS ACTUALIZADOS. Insertados: " & pagos_insertados & ", Duplicados: " & pagos_duplicados
                            Else
                                mensaje = "NO HAY PAGOS NUEVOS. Duplicados: " & pagos_duplicados
                            End If
                        Else
                            mensaje = "NO SE ENCONTRARON PAGOS"
                        End If

                    Finally
                        ' *** SIEMPRE LIBERAR EL LOCK ***
                        cmd.CommandText = "SELECT pg_advisory_unlock(987654321)"
                        cmd.Parameters.Clear()
                        cmd.ExecuteNonQuery()
                    End Try

                    cmd.Dispose()
                    con.Close()
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
        Dim conn As New OdbcConnection("DSN=QDSN_LEON;UID=CFUENTES;PWD=Fidoc_9;LONGDATACOMPAT=1;")
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