Imports System.Data
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql


' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceFrente
    Inherits System.Web.Services.WebService



    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ActFrente(objFrente As clsFrente) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim fidx As Integer = 0
        Dim pidx As Integer = 0
        Dim coopidx As String = Nothing
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_frente", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fidr", objFrente.fid)
                cmd.Parameters.AddWithValue("@latitudr", objFrente.latitud)
                cmd.Parameters.AddWithValue("@longitudr", objFrente.longitud)
                cmd.Parameters.AddWithValue("@mtsr", objFrente.mts)
                cmd.Parameters.AddWithValue("@cidr", objFrente.cid)
                cmd.Parameters.AddWithValue("@coopidr", objFrente.coopid)
                cmd.Parameters.AddWithValue("@pidr", objFrente.pid)
                cmd.Parameters.AddWithValue("@oidr", objFrente.oid)
                cmd.Parameters.AddWithValue("@obs_gralesr", objFrente.obs_grales)
                cmd.Parameters.AddWithValue("@obrafidocr", objFrente.obrafidoc)
                cmd.Parameters.AddWithValue("@gidr", objFrente.gid)
                cmd.Parameters.AddWithValue("@feccrer", objFrente.feccre)
                cmd.Parameters.AddWithValue("@fecmodr", objFrente.fecmod)
                cmd.Parameters.AddWithValue("@usucrer", objFrente.usucre)
                cmd.Parameters.AddWithValue("@usrmodr", objFrente.usrmod)
                cmd.Parameters.AddWithValue("@pridr", objFrente.prid)
                cmd.Parameters.AddWithValue("@incr", objFrente.inc)
                cmd.Parameters.AddWithValue("@didr", objFrente.did)
                cmd.Parameters.AddWithValue("@factor_act_pagor", objFrente.factor_act_pago)
                cmd.Parameters.AddWithValue("@obr_clv_intr", objFrente.obr_clv_int)
                cmd.Parameters.AddWithValue("@coo_clv2r", objFrente.coo_clv2)
                cmd.Parameters.AddWithValue("@accionr", objFrente.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output
                Dim parfidx As NpgsqlParameter = New NpgsqlParameter("@fidx", NpgsqlTypes.NpgsqlDbType.Integer, 36) ' .Value = Space(1000)
                parfidx.Direction = ParameterDirection.Output
                Dim parcoopidx As NpgsqlParameter = New NpgsqlParameter("@coopidx", NpgsqlTypes.NpgsqlDbType.Varchar, 10) ' .Value = Space(1000)
                parcoopidx.Direction = ParameterDirection.Output


                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(parfidx)
                cmd.Parameters.Add(parcoopidx)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                fidx = cmd.Parameters("@fidx").Value()
                coopidx = cmd.Parameters("@coopidx").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Registro de frente guardado:" + fidx.ToString() + ":" + coopidx.ToString() + ":" + pidx.ToString()
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function


    <WebMethod(Description:="Insertar descto por aplicar")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ActDesctoAplicar(objFrenteFinanc As clsFrenteFinanc) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_frente_financ", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fidr", objFrenteFinanc.fid)
                cmd.Parameters.AddWithValue("@porcentajer", objFrenteFinanc.porcentaje)
                cmd.Parameters.AddWithValue("@monto_desctor", objFrenteFinanc.monto_descto)
                cmd.Parameters.AddWithValue("@fec_ofrecer", objFrenteFinanc.fec_ofrece)
                cmd.Parameters.AddWithValue("@fec_aplicr", objFrenteFinanc.fec_aplic)
                cmd.Parameters.AddWithValue("@usrcrer", objFrenteFinanc.usrcre)
                cmd.Parameters.AddWithValue("@cactivor", objFrenteFinanc.cactivo)
                cmd.Parameters.AddWithValue("@accion", objFrenteFinanc.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
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
            Return numerror.ToString + ":" + messerror
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function

    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetFrente(objFrente As clsFrente) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_frenteq", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fidx", objFrente.fid)
                cmd.Parameters.AddWithValue("@accionx", objFrente.Accion)
                adapt.Fill(ds, "Frente")
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


    <WebMethod(Description:="Analiza si el descuento procede")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ConsultaParametros_Descto(fid As Integer, idusu As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim fid_r As Integer
        Dim saldo_actual As Double
        Dim saldo_con_descto As Double
        Dim fec_ult_pag As Date
        Dim monto_descto As Double
        Dim porcent_descto As Double
        Dim descto_aplicado As Integer



        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_aplicar_descto_pp", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fidx", fid)
                cmd.Parameters.AddWithValue("@idusux", idusu)

                Dim p_fid As NpgsqlParameter = New NpgsqlParameter("@out_fid", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                p_fid.Direction = ParameterDirection.Output
                Dim p_saldo_actual As NpgsqlParameter = New NpgsqlParameter("@out_saldo_actual", NpgsqlTypes.NpgsqlDbType.Double) ' .Value = Space(1000)
                p_saldo_actual.Direction = ParameterDirection.Output
                Dim p_saldo_con_descto As NpgsqlParameter = New NpgsqlParameter("@out_saldo_con_descto", NpgsqlTypes.NpgsqlDbType.Double) ' .Value = Space(1000)
                p_saldo_con_descto.Direction = ParameterDirection.Output
                Dim p_fec_ult_pag As NpgsqlParameter = New NpgsqlParameter("@out_fec_ult_pag", NpgsqlTypes.NpgsqlDbType.Date) ' .Value = Space(1000)
                p_fec_ult_pag.Direction = ParameterDirection.Output
                Dim p_monto_descto As NpgsqlParameter = New NpgsqlParameter("@out_monto_descto", NpgsqlTypes.NpgsqlDbType.Double) ' .Value = Space(1000)
                p_monto_descto.Direction = ParameterDirection.Output
                Dim p_porcent_descto As NpgsqlParameter = New NpgsqlParameter("@out_porcent_descto", NpgsqlTypes.NpgsqlDbType.Double) ' .Value = Space(1000)
                p_porcent_descto.Direction = ParameterDirection.Output
                Dim p_descto_aplicado As NpgsqlParameter = New NpgsqlParameter("@out_descto_aplicado", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = Space(1000)
                p_descto_aplicado.Direction = ParameterDirection.Output

                cmd.Parameters.Add(p_fid)
                cmd.Parameters.Add(p_saldo_actual)
                cmd.Parameters.Add(p_saldo_con_descto)
                cmd.Parameters.Add(p_fec_ult_pag)
                cmd.Parameters.Add(p_monto_descto)
                cmd.Parameters.Add(p_porcent_descto)
                cmd.Parameters.Add(p_descto_aplicado)


                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                fid_r = cmd.Parameters("@out_fid").Value()
                saldo_actual = cmd.Parameters("@out_saldo_actual").Value()
                saldo_con_descto = cmd.Parameters("@out_saldo_con_descto").Value()
                fec_ult_pag = cmd.Parameters("@out_fec_ult_pag").Value()
                monto_descto = cmd.Parameters("@out_monto_descto").Value()
                porcent_descto = cmd.Parameters("@out_porcent_descto").Value()
                descto_aplicado = cmd.Parameters("@out_descto_aplicado").Value()


                con.Close()

                Try
                    Return fid_r.ToString + "," + saldo_actual.ToString + "," + saldo_con_descto.ToString + "," + fec_ult_pag.ToString + "," + monto_descto.ToString + "," + porcent_descto.ToString + "," + descto_aplicado.ToString
                Catch ex As Exception
                    Return "Error " & ex.Message
                End Try


            End Using
        End Using

    End Function




    <WebMethod(Description:="Analiza si el descuento procede")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function AplicarDescto_Especial(fid As Integer, idusu As Integer, monto_descto_esp As Double) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim fid_r As Integer
        Dim saldo_actual As Double
        Dim saldo_con_descto As Double
        Dim fec_ult_pag As Date
        Dim monto_descto As Double
        Dim porcent_descto As Double
        Dim descto_aplicado As Integer


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_aplicar_descto_esp", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fidx", fid)
                cmd.Parameters.AddWithValue("@idusux", idusu)
                cmd.Parameters.AddWithValue("@monto_descto_esp", monto_descto_esp)

                Dim p_fid As NpgsqlParameter = New NpgsqlParameter("@out_fid", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                p_fid.Direction = ParameterDirection.Output
                Dim p_saldo_actual As NpgsqlParameter = New NpgsqlParameter("@out_saldo_actual", NpgsqlTypes.NpgsqlDbType.Double) ' .Value = Space(1000)
                p_saldo_actual.Direction = ParameterDirection.Output
                Dim p_saldo_con_descto As NpgsqlParameter = New NpgsqlParameter("@out_saldo_con_descto", NpgsqlTypes.NpgsqlDbType.Double) ' .Value = Space(1000)
                p_saldo_con_descto.Direction = ParameterDirection.Output
                Dim p_fec_ult_pag As NpgsqlParameter = New NpgsqlParameter("@out_fec_ult_pag", NpgsqlTypes.NpgsqlDbType.Date) ' .Value = Space(1000)
                p_fec_ult_pag.Direction = ParameterDirection.Output
                Dim p_monto_descto As NpgsqlParameter = New NpgsqlParameter("@out_monto_descto", NpgsqlTypes.NpgsqlDbType.Double) ' .Value = Space(1000)
                p_monto_descto.Direction = ParameterDirection.Output
                Dim p_porcent_descto As NpgsqlParameter = New NpgsqlParameter("@out_porcent_descto", NpgsqlTypes.NpgsqlDbType.Double) ' .Value = Space(1000)
                p_porcent_descto.Direction = ParameterDirection.Output
                Dim p_descto_aplicado As NpgsqlParameter = New NpgsqlParameter("@out_descto_aplicado", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = Space(1000)
                p_descto_aplicado.Direction = ParameterDirection.Output

                cmd.Parameters.Add(p_fid)
                cmd.Parameters.Add(p_saldo_actual)
                cmd.Parameters.Add(p_saldo_con_descto)
                cmd.Parameters.Add(p_fec_ult_pag)
                cmd.Parameters.Add(p_monto_descto)
                cmd.Parameters.Add(p_porcent_descto)
                cmd.Parameters.Add(p_descto_aplicado)


                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                fid_r = cmd.Parameters("@out_fid").Value()
                saldo_actual = cmd.Parameters("@out_saldo_actual").Value()
                saldo_con_descto = cmd.Parameters("@out_saldo_con_descto").Value()
                fec_ult_pag = cmd.Parameters("@out_fec_ult_pag").Value()
                monto_descto = cmd.Parameters("@out_monto_descto").Value()
                porcent_descto = cmd.Parameters("@out_porcent_descto").Value()
                descto_aplicado = cmd.Parameters("@out_descto_aplicado").Value()


                con.Close()

                Try
                    Return fid_r.ToString + "," + saldo_actual.ToString + "," + saldo_con_descto.ToString + "," + fec_ult_pag.ToString + "," + monto_descto.ToString + "," + porcent_descto.ToString + "," + descto_aplicado.ToString
                Catch ex As Exception
                    Return "Error " & ex.Message
                End Try


            End Using
        End Using

    End Function

    <WebMethod(Description:="Analiza si el descuento procede")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function AplicarDescto_Art24(fid As Integer, idusu As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim fid_r As Integer
        Dim saldo_actual As Double
        Dim saldo_con_descto As Double
        Dim fec_ult_pag As Date
        Dim monto_descto As Double
        Dim descto_aplicado As Integer



        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_aplicar_descto_art24", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fidx", fid)
                cmd.Parameters.AddWithValue("@idusux", idusu)

                Dim p_fid As NpgsqlParameter = New NpgsqlParameter("@out_fid", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                p_fid.Direction = ParameterDirection.Output
                Dim p_saldo_actual As NpgsqlParameter = New NpgsqlParameter("@out_saldo_actual", NpgsqlTypes.NpgsqlDbType.Double) ' .Value = Space(1000)
                p_saldo_actual.Direction = ParameterDirection.Output
                Dim p_saldo_con_descto As NpgsqlParameter = New NpgsqlParameter("@out_saldo_con_descto", NpgsqlTypes.NpgsqlDbType.Double) ' .Value = Space(1000)
                p_saldo_con_descto.Direction = ParameterDirection.Output
                Dim p_fec_ult_pag As NpgsqlParameter = New NpgsqlParameter("@out_fec_ult_pag", NpgsqlTypes.NpgsqlDbType.Date) ' .Value = Space(1000)
                p_fec_ult_pag.Direction = ParameterDirection.Output
                Dim p_monto_descto As NpgsqlParameter = New NpgsqlParameter("@out_monto_descto", NpgsqlTypes.NpgsqlDbType.Double) ' .Value = Space(1000)
                p_monto_descto.Direction = ParameterDirection.Output
                Dim p_descto_aplicado As NpgsqlParameter = New NpgsqlParameter("@out_descto_aplicado", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = Space(1000)
                p_descto_aplicado.Direction = ParameterDirection.Output

                cmd.Parameters.Add(p_fid)
                cmd.Parameters.Add(p_saldo_actual)
                cmd.Parameters.Add(p_saldo_con_descto)
                cmd.Parameters.Add(p_fec_ult_pag)
                cmd.Parameters.Add(p_monto_descto)
                cmd.Parameters.Add(p_descto_aplicado)


                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                fid_r = cmd.Parameters("@out_fid").Value()
                saldo_actual = cmd.Parameters("@out_saldo_actual").Value()
                saldo_con_descto = cmd.Parameters("@out_saldo_con_descto").Value()
                fec_ult_pag = cmd.Parameters("@out_fec_ult_pag").Value()
                monto_descto = cmd.Parameters("@out_monto_descto").Value()
                descto_aplicado = cmd.Parameters("@out_descto_aplicado").Value()


                con.Close()

                Try
                    Return fid_r.ToString + "," + saldo_actual.ToString + "," + saldo_con_descto.ToString + "," + fec_ult_pag.ToString + "," + monto_descto.ToString + "," + descto_aplicado.ToString
                Catch ex As Exception
                    Return "Error " & ex.Message
                End Try


            End Using
        End Using

    End Function



    <WebMethod(Description:="Retorna listado de usuarios que son ministros ejecutores")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetFrenteFinanc(accion As String, fid As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_frente_financ_q", con)
                Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.Parameters.AddWithValue("@accionx", accion)
                cmd.Parameters.AddWithValue("@fidx", fid)
                cmd.CommandType = CommandType.StoredProcedure
                custDA.Fill(ds, "frentefinanc")

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



    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetObraAnalitico(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponseRepAnaliticoObra
        Return GetRepAnaliticoObra(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro)

    End Function

    Private Function GetRepAnaliticoObra(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String) As JQGridJsonResponseRepAnaliticoObra
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer




        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_rep_analitico_obra_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pPageNumber)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", pFiltro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim obras_analitico = New List(Of clsObraAnalitico)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim obra_analitico As clsObraAnalitico = New clsObraAnalitico()
                        obra_analitico.fid = ValidarDBNull(row.Item("fid_r"), "entero")
                        obra_analitico.coopid = ValidarDBNull(row.Item("coopid_r"), "cadena")
                        obra_analitico.mts_frente = ValidarDBNull(row.Item("mts_frente_r"), "real")
                        obra_analitico.obr_cost = ValidarDBNull(row.Item("obr_cost_r"), "real")
                        obra_analitico.oid = ValidarDBNull(row.Item("oid_r"), "entero")
                        obra_analitico.calle = ValidarDBNull(row.Item("calle_r"), "cadena")
                        obra_analitico.colonia = ValidarDBNull(row.Item("colonia_r"), "cadena")
                        obra_analitico.tramo = ValidarDBNull(row.Item("tramo_r"), "cadena")
                        obra_analitico.obr_clv_int = ValidarDBNull(row.Item("obr_clv_int_r"), "entero")
                        obra_analitico.obr_clv = ValidarDBNull(row.Item("obr_clv_r"), "entero")
                        obra_analitico.obr_opergob = ValidarDBNull(row.Item("obr_opergob_r"), "cadena")
                        obra_analitico.obr_prog2 = ValidarDBNull(row.Item("obr_prog2_r"), "entero")
                        obra_analitico.nomprog = ValidarDBNull(row.Item("nomprog_r"), "cadena")
                        obra_analitico.descrip_tipo_obr = ValidarDBNull(row.Item("descrip_tipo_obr_r"), "cadena")
                        obra_analitico.obr_status = ValidarDBNull(row.Item("obr_status_r"), "fecha")
                        obra_analitico.estatus_obra = ValidarDBNull(row.Item("estatus_obra_r"), "fecha")
                        obra_analitico.fec_ini_pag = ValidarDBNull(row.Item("fec_ini_pag_r"), "fecha")
                        obra_analitico.fec_fin_pag = ValidarDBNull(row.Item("fec_fin_pag_r"), "fecha")
                        obra_analitico.fec_ini_proc = ValidarDBNull(row.Item("fec_ini_proc_r"), "fecha")
                        obra_analitico.fec_ini_cob = ValidarDBNull(row.Item("fec_ini_cob_r"), "fecha")
                        obra_analitico.plazo_rec = ValidarDBNull(row.Item("plazo_rec_r"), "entero")
                        obra_analitico.num_meses_a_fecact = ValidarDBNull(row.Item("num_meses_a_fecact_r"), "entero")
                        obra_analitico.capital_inicial_frente_sin_inc = ValidarDBNull(row.Item("capital_inicial_frente_sin_inc_r"), "real")
                        obra_analitico.incremento_frente = ValidarDBNull(row.Item("incremento_frente_r"), "entero")
                        obra_analitico.capital_inicial_frente_con_inc = ValidarDBNull(row.Item("capital_inicial_frente_con_inc_r"), "real")
                        obra_analitico.descto_capital_frente = ValidarDBNull(row.Item("descto_capital_frente_r"), "real")
                        obra_analitico.ayudas_sociales_frente = ValidarDBNull(row.Item("ayudas_sociales_frente_r"), "real")
                        obra_analitico.capital_pagado_frente = ValidarDBNull(row.Item("capital_pagado_frente_r"), "real")
                        obra_analitico.total_recargos_frente = ValidarDBNull(row.Item("total_recargos_frente_r"), "real")
                        obra_analitico.descto_recargos_frente = ValidarDBNull(row.Item("descto_recargos_frente_r"), "real")
                        obra_analitico.cargos_pagados_frente = ValidarDBNull(row.Item("cargos_pagados_frente_r"), "real")
                        obra_analitico.saldo_capital_frente = ValidarDBNull(row.Item("saldo_capital_frente_r"), "real")
                        obra_analitico.saldo_recargos_frente = ValidarDBNull(row.Item("saldo_recargos_frente_r"), "real")
                        obra_analitico.saldo_gral_frente = ValidarDBNull(row.Item("saldo_gral_frente_r"), "real")
                        obra_analitico.saldo_sin = ValidarDBNull(row.Item("saldo_sin_r"), "real")
                        obra_analitico.saldo_con = ValidarDBNull(row.Item("saldo_con_r"), "real")
                        obra_analitico.avance_pago_con_inc_x_frente = ValidarDBNull(row.Item("avance_pago_con_inc_x_frente_r"), "real")
                        obra_analitico.avance_pago_sin_inc_x_frente = ValidarDBNull(row.Item("avance_pago_sin_inc_x_frente_r"), "real")
                        obras_analitico.Add(obra_analitico)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))

                Dim objeto As JQGridJsonResponseRepAnaliticoObra = New JQGridJsonResponseRepAnaliticoObra
                objeto.JQGridJsonResponseRepAnaliticoObra(pagecount, currentpage, recordcount, obras_analitico)
                Return objeto
            End Using
        End Using
    End Function





    <WebMethod(Description:="Recaba los frentes de una obra")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetFrentexO(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponseFrentexO
        Return GetFrentexO_Json(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro)
    End Function

    Private Function GetFrentexO_Json(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponseFrentexO
        Dim constr2 As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim dt2 As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr2)
            Using cmd As New NpgsqlCommand("public2.sp_frentexo_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pCurrentPage)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSortOrder)
                cmd.Parameters.AddWithValue("@filtro", pFiltro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim frentesxo = New List(Of clsFrentexO)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim frentexo As clsFrentexO = New clsFrentexO()
                        frentexo.oid = ValidarDBNull(row.Item("oid_r"), "entero")
                        frentexo.obr_clv_int = ValidarDBNull(row.Item("obr_clv_int_r"), "cadena")
                        frentexo.obr_clv = ValidarDBNull(row.Item("obr_clv_r"), "cadena")
                        frentexo.calle = ValidarDBNull(row.Item("calle_r"), "cadena")
                        frentexo.colonia = ValidarDBNull(row.Item("colonia_r"), "cadena")
                        frentexo.tramo = ValidarDBNull(row.Item("tramo_r"), "cadena")
                        frentexo.costo_mto = ValidarDBNull(row.Item("costo_mto_r"), "real")
                        frentexo.obr_fecinip = ValidarDBNull(row.Item("obr_fecinip_r"), "fecha")
                        frentexo.obr_fecvenp = ValidarDBNull(row.Item("obr_fecvenp_r"), "fecha")
                        frentexo.obr_npago = ValidarDBNull(row.Item("obr_npago_r"), "entero")
                        frentexo.descrip_tipo_obr = ValidarDBNull(row.Item("descrip_tipo_obr_r"), "cadena")
                        frentexo.estatus_obra = ValidarDBNull(row.Item("estatus_obra_r"), "entero")
                        frentexo.nomprog = ValidarDBNull(row.Item("nomprog_r"), "cadena")
                        frentexo.progdescrip = ValidarDBNull(row.Item("progdescrip_r"), "cadena")
                        frentexo.pid = ValidarDBNull(row.Item("pid_r"), "entero")
                        frentexo.nooficial = ValidarDBNull(row.Item("nooficial_r"), "cadena")
                        frentexo.ctapredial = ValidarDBNull(row.Item("ctapredial_r"), "cadena")
                        frentexo.fid = ValidarDBNull(row.Item("fid_r"), "entero")
                        frentexo.coopid = ValidarDBNull(row.Item("coopid_r"), "cadena")
                        frentexo.coo_clv2 = ValidarDBNull(row.Item("coo_clv2_r"), "entero")
                        frentexo.mnomficha = ValidarDBNull(row.Item("mnomficha_r"), "cadena")
                        frentexo.mts_frente = ValidarDBNull(row.Item("mts_frente_r"), "real")
                        frentexo.inc = ValidarDBNull(row.Item("inc_r"), "real")
                        frentexo.capital_sin_inc = ValidarDBNull(row.Item("capital_sin_inc_r"), "real")
                        frentexo.capital = ValidarDBNull(row.Item("capital_r"), "real")
                        frentexo.capital_pagado = ValidarDBNull(row.Item("capital_pagado_r"), "real")
                        frentexo.cargos_pagados = ValidarDBNull(row.Item("cargos_pagados_r"), "real")
                        frentexo.desctos_aplicados = ValidarDBNull(row.Item("desctos_aplicados_r"), "real")
                        frentexo.recargos_netos = ValidarDBNull(row.Item("recargos_netos_r"), "real")
                        frentexo.total_pagar = ValidarDBNull(row.Item("total_pagar_r"), "real")
                        frentexo.mapellidom = ValidarDBNull(row.Item("mapellidom_r"), "cadena")
                        frentexo.mapellidop = ValidarDBNull(row.Item("mapellidop_r"), "cadena")
                        frentexo.mnombres = ValidarDBNull(row.Item("mnombres_r"), "cadena")
                        frentexo.costo_obra = ValidarDBNull(row.Item("costo_obrar"), "real")
                        frentexo.abono = ValidarDBNull(row.Item("abonor"), "real")
                        frentexo.avance_obra = ValidarDBNull(row.Item("avance_obrar"), "real")

                        frentesxo.Add(frentexo)
                    Next row

                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseFrentexO = New JQGridJsonResponseFrentexO
                objeto.JQGridJsonResponseFrentexO(pagecount, currentpage, recordcount, frentesxo)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetRep2(obr_clv_int As Integer, fecha_lim As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_obra_frentes_lim", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@obr_clv_int_in", obr_clv_int)
                cmd.Parameters.AddWithValue("@fecha", fecha_lim)
                adapt.Fill(dt, "obras_rep2")
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








