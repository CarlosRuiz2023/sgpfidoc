Imports System.Data
Imports System.Data.OleDb
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
Public Class WebServiceCoop
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Retorna los datos exclusivos del nombre seleccionado")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function Getcoop(objCoop As clsCoop) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_coopq", con)
                Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idcoopx", objCoop.idcoop)
                cmd.Parameters.AddWithValue("@accionx", objCoop.accion)
                custDA.Fill(ds, "coops")

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




    <WebMethod(Description:="Retorna los datos exclusivos del nombre seleccionado")> _
    <ScriptMethod(XmlSerializeString:=True)>
    Public Function GetPagosCoopSIFIDOC(coo_clv As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf6").ConnectionString
        Dim ds As DataSet = New DataSet()

        Dim strSQL As String = "select * from movimientos where mov_clv1='" & coo_clv & "'"

        Using con As New OleDbConnection(constr)
            Using cmd As New OleDbCommand(strSQL, con)
                Dim adapt As OleDbDataAdapter = New OleDbDataAdapter(cmd)
                adapt.Fill(ds, "pagos_coops_sifidoc")

            End Using
        End Using
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

    End Function


    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ActPagosCoop(pagos As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idcoopx As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_act_pagos", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@sqlpagos", pagos)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@NoError", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@DescError", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output


                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)


                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()

                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente"
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function



    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GuardarCoop(objCoop As clsCoop) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idcoopx As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_coop", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idcoop", objCoop.idcoop)
                cmd.Parameters.AddWithValue("@apellidop", objCoop.apellidoP)
                cmd.Parameters.AddWithValue("@apellidom", objCoop.apellidoM)
                cmd.Parameters.AddWithValue("@nombres", objCoop.nombres)
                cmd.Parameters.AddWithValue("@callecoop", objCoop.callecoop)
                cmd.Parameters.AddWithValue("@colcoop", objCoop.colcoop)
                cmd.Parameters.AddWithValue("@nooficialext", objCoop.nooficialext)
                cmd.Parameters.AddWithValue("@nooficialint", objCoop.nooficialint)
                cmd.Parameters.AddWithValue("@telcoop", objCoop.telcoop)
                cmd.Parameters.AddWithValue("@nomficha", objCoop.nomficha)
                cmd.Parameters.AddWithValue("@estado", objCoop.estado)
                cmd.Parameters.AddWithValue("@pais", objCoop.pais)
                cmd.Parameters.AddWithValue("@correo", objCoop.correo)
                cmd.Parameters.AddWithValue("@musrcre", objCoop.usrcre)
                cmd.Parameters.AddWithValue("@mfeccre", objCoop.feccre)
                cmd.Parameters.AddWithValue("@musrmod", objCoop.usrmod)
                cmd.Parameters.AddWithValue("@fecmod", objCoop.fecmod)
                cmd.Parameters.AddWithValue("@curp", objCoop.curp)
                cmd.Parameters.AddWithValue("@relpred", objCoop.relpred)
                cmd.Parameters.AddWithValue("@mine", objCoop.ine)
                cmd.Parameters.AddWithValue("@mdoc", objCoop.doc)
                cmd.Parameters.AddWithValue("@accion", objCoop.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@NoError", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@DescError", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridcoop As NpgsqlParameter = New NpgsqlParameter("@idcoopx", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridcoop.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridcoop)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()
                idcoopx = cmd.Parameters("@idcoopx").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente:" & idcoopx.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function

    'Webservice utilizado para relacionar toda la situación financiera por frente
    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCoopsV(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String, oid As Integer) As JQGridJsonResponseFrentePredioCoopV
        Return GetCoopsfpcVJson(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro, oid)

    End Function

    Private Function GetCoopsfpcVJson(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String, oid As Integer) As JQGridJsonResponseFrentePredioCoopV
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
            Using cmd As New NpgsqlCommand("sp_coopv_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@oid", oid)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim coopsfpc = New List(Of clsFrentePredioCoopV)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim coopfpc As clsFrentePredioCoopV = New clsFrentePredioCoopV()
                        coopfpc.fid = ValidarDBNull(row.Item("fidr"), "entero")
                        coopfpc.pid = ValidarDBNull(row.Item("pidr"), "entero")
                        coopfpc.oid = ValidarDBNull(row.Item("oidr"), "entero")
                        coopfpc.cid = ValidarDBNull(row.Item("cidr"), "entero")
                        coopfpc.prid = ValidarDBNull(row.Item("pridr"), "entero")
                        coopfpc.programa = ValidarDBNull(row.Item("programar"), "cadena")
                        coopfpc.obrasifidoc = ValidarDBNull(row.Item("obra_sifidocr"), "cadena")
                        coopfpc.coopid = ValidarDBNull(row.Item("coopidr"), "cadena")
                        coopfpc.mtsfrente = ValidarDBNull(row.Item("mts_frenter"), "real")
                        coopfpc.costomtolineal = ValidarDBNull(row.Item("costo_mto_linealr"), "real")
                        coopfpc.capital = ValidarDBNull(row.Item("capitalr"), "real")
                        coopfpc.incremento = ValidarDBNull(row.Item("incrementor"), "real")
                        coopfpc.sum_pagos_antes_fec_notif_det = ValidarDBNull(row.Item("sum_pagos_antes_fec_notif_detr"), "real")
                        coopfpc.sum_pagos_antes_fec_act = ValidarDBNull(row.Item("sum_pagos_antes_fec_actr"), "real")
                        coopfpc.acces_falta_antes_fec_act = ValidarDBNull(row.Item("acces_falta_antes_fec_actr"), "real")
                        coopfpc.sum_acces_desp_fec_act_6 = ValidarDBNull(row.Item("sum_acces_desp_fec_act_6r"), "real")
                        coopfpc.sum_acces_desp_fec_act_7 = ValidarDBNull(row.Item("sum_acces_desp_fec_act_7r"), "real")
                        coopfpc.sum_pagos_desp_fec_act = ValidarDBNull(row.Item("sum_pagos_desp_fec_actr"), "real")
                        coopfpc.saldo_parcial = ValidarDBNull(row.Item("saldo_parcialr"), "real")
                        coopfpc.saldo_act = ValidarDBNull(row.Item("saldo_actr"), "real")
                        coopfpc.saldo_total = ValidarDBNull(row.Item("saldo_totalr"), "real")
                        coopfpc.saldo_pagar = ValidarDBNull(row.Item("saldo_pagarr"), "real")
                        coopfpc.recargos = ValidarDBNull(row.Item("recargosr"), "real")
                        coopfpc.periodorecargos = ValidarDBNull(row.Item("periodo_recargosr"), "cadena")
                        coopfpc.calle = ValidarDBNull(row.Item("caller"), "cadena")
                        coopfpc.colonia = ValidarDBNull(row.Item("coloniar"), "cadena")
                        coopfpc.tramo = ValidarDBNull(row.Item("tramor"), "cadena")
                        coopfpc.noobra = ValidarDBNull(row.Item("noobrar"), "cadena")
                        coopfpc.noobra2 = ValidarDBNull(row.Item("noobra2r"), "cadena")
                        coopfpc.noobra3 = ValidarDBNull(row.Item("noobra3r"), "cadena")
                        coopfpc.fecrec = ValidarDBNull(row.Item("fec_recr"), "fecha")
                        coopfpc.fecinipag = ValidarDBNull(row.Item("fec_ini_pagr"), "fecha")
                        coopfpc.fecvenc = ValidarDBNull(row.Item("fec_vencr"), "fecha")
                        coopfpc.fecproceso = ValidarDBNull(row.Item("fec_procesor"), "fecha")
                        coopfpc.feccob = ValidarDBNull(row.Item("fec_cobr"), "fecha")
                        coopfpc.fecpav = ValidarDBNull(row.Item("fec_pavr"), "fecha")
                        coopfpc.fecnotifdet = ValidarDBNull(row.Item("fec_notif_detr"), "fecha")
                        coopfpc.fecact = ValidarDBNull(row.Item("fec_actr"), "fecha")
                        coopfpc.statussifidoc = ValidarDBNull(row.Item("status_sifidocr"), "cadena")
                        coopfpc.ctapredial = ValidarDBNull(row.Item("ctapredialr"), "cadena")
                        coopfpc.nooficial = ValidarDBNull(row.Item("nooficialr"), "cadena")
                        coopfpc.mapellidop = ValidarDBNull(row.Item("mapellidopr"), "cadena")
                        coopfpc.mapellidom = ValidarDBNull(row.Item("mapellidomr"), "cadena")
                        coopfpc.mnombres = ValidarDBNull(row.Item("mnombresr"), "cadena")
                        coopfpc.nomcoop = ValidarDBNull(row.Item("nom_coopr"), "cadena")
                        coopfpc.usosuelo = ValidarDBNull(row.Item("uso_suelor"), "cadena")
                        coopfpc.factoract = ValidarDBNull(row.Item("factor_actr"), "real")
                        coopfpc.periodoact = ValidarDBNull(row.Item("periodo_actr"), "real")
                        coopfpc.feccre = ValidarDBNull(row.Item("feccrer"), "fecha")
                        coopfpc.fecmod = ValidarDBNull(row.Item("fecmodr"), "fecha")
                        coopfpc.usucre = ValidarDBNull(row.Item("usucrer"), "entero")
                        coopfpc.usumod = ValidarDBNull(row.Item("usrmodr"), "entero")
                        coopfpc.geomfrente = ValidarDBNull(row.Item("geom_frenter"), "cadena")
                        coopfpc.geomobra = ValidarDBNull(row.Item("geom_obrar"), "cadena")
                        coopfpc.geompredio = ValidarDBNull(row.Item("geom_predior"), "cadena")
                        coopsfpc.Add(coopfpc)
                    Next row

                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseFrentePredioCoopV = New JQGridJsonResponseFrentePredioCoopV
                objeto.JQGridJsonResponseFrentePredioCoopV(pagecount, currentpage, recordcount, coopsfpc)
                Return objeto
            End Using
        End Using
    End Function



    'Webservice utilizado para relacionar toda la situación financiera por frente
    <WebMethod(Description:="Recaba el cooperador de la cartera vencida")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCoop_allC(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponseCoopAllCV
        Return GetCoop_allCartera(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro)

    End Function

    Private Function GetCoop_allCartera(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String) As JQGridJsonResponseCoopAllCV
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
            Using cmd As New NpgsqlCommand("public3.sp_coop_cv_all_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", pFiltro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim coops_allc = New List(Of clsCoopAllCartera)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim coop_allc As clsCoopAllCartera = New clsCoopAllCartera()
                        coop_allc.coo_clv = ValidarDBNull(row.Item("coo_clv_r"), "cadena")
                        coop_allc.coo_pat = ValidarDBNull(row.Item("coo_pat_r"), "cadena")
                        coop_allc.coo_mat = ValidarDBNull(row.Item("coo_mat_r"), "cadena")
                        coop_allc.coo_nom = ValidarDBNull(row.Item("coo_nom_r"), "cadena")
                        coop_allc.coo_nombre = ValidarDBNull(row.Item("coo_nombre_r"), "cadena")
                        coop_allc.coo_nof = ValidarDBNull(row.Item("coo_nof_r"), "cadena")
                        coop_allc.coo_call = ValidarDBNull(row.Item("coo_call_r"), "cadena")
                        coop_allc.coo_num = ValidarDBNull(row.Item("coo_num_r"), "cadena")
                        coop_allc.coo_col = ValidarDBNull(row.Item("coo_col_r"), "cadena")
                        coop_allc.coo_npag = ValidarDBNull(row.Item("coo_npag_r"), "entero")
                        coop_allc.coo_obr = ValidarDBNull(row.Item("coo_obr_r"), "cadena")
                        coop_allc.coo_mts = ValidarDBNull(row.Item("coo_mts_r"), "real")
                        coop_allc.coo_inc = ValidarDBNull(row.Item("coo_inc_r"), "real")
                        coop_allc.capital = ValidarDBNull(row.Item("capital_r"), "real")
                        coop_allc.coo_clv1 = ValidarDBNull(row.Item("coo_clv1_r"), "cadena")
                        coop_allc.coo_pred = ValidarDBNull(row.Item("coo_pred_r"), "cadena")
                        coop_allc.obr_call = ValidarDBNull(row.Item("obr_call_r"), "cadena")
                        coop_allc.obr_col = ValidarDBNull(row.Item("obr_col_r"), "cadena")
                        coop_allc.col_nom = ValidarDBNull(row.Item("col_nom_r"), "cadena")
                        coop_allc.obr_tramo = ValidarDBNull(row.Item("obr_tramo_r"), "cadena")
                        coop_allc.obr_opergob = ValidarDBNull(row.Item("obr_opergob_r"), "cadena")
                        coop_allc.obr_npago = ValidarDBNull(row.Item("obr_npago_r"), "entero")
                        coop_allc.obr_fec_proc = ValidarDBNull(row.Item("obr_fec_proc_r"), "fecha")
                        coop_allc.obr_fec_cob = ValidarDBNull(row.Item("obr_fec_cob_r"), "fecha")
                        coop_allc.obr_fec_rec = ValidarDBNull(row.Item("obr_fec_rec_r"), "fecha")
                        coop_allc.midcoop = ValidarDBNull(row.Item("midcoop_r"), "entero")
                        coop_allc.mcallecoop = ValidarDBNull(row.Item("mcallecoop_r"), "cadena")
                        coop_allc.mcolcoop = ValidarDBNull(row.Item("mcolcoop_r"), "cadena")
                        coop_allc.mnooficial_ext = ValidarDBNull(row.Item("mnooficial_ext_r"), "cadena")
                        coop_allc.mtelcoop = ValidarDBNull(row.Item("mtelcoop_r"), "cadena")
                        coop_allc.mnomficha = ValidarDBNull(row.Item("mnomficha_r"), "cadena")
                        coop_allc.mcurp = ValidarDBNull(row.Item("mcurp_r"), "cadena")
                        coop_allc.mcorreo = ValidarDBNull(row.Item("mcorreo_r"), "cadena")
                        coop_allc.mrelacionpredio = ValidarDBNull(row.Item("mrelacionpredio_r"), "entero")
                        coop_allc.crelacionpredio = ValidarDBNull(row.Item("crelacionpredio_r"), "cadena")
                        coop_allc.fid = ValidarDBNull(row.Item("fid_r"), "entero")
                        coop_allc.obra_coop_s = ValidarDBNull(row.Item("obra_coop_s_r"), "cadena")
                        coop_allc.mts_frente = ValidarDBNull(row.Item("mts_frente_r"), "real")
                        coop_allc.cid = ValidarDBNull(row.Item("cid_r"), "entero")
                        coop_allc.pid = ValidarDBNull(row.Item("pid_r"), "entero")
                        coop_allc.ctapredial = ValidarDBNull(row.Item("ctapredial_r"), "cadena")
                        coop_allc.nooficial = ValidarDBNull(row.Item("nooficial_r"), "cadena")
                        coop_allc.lote = ValidarDBNull(row.Item("lote_r"), "cadena")
                        coop_allc.mzna = ValidarDBNull(row.Item("mzna_r"), "cadena")
                        coop_allc.obr_clv_int = ValidarDBNull(row.Item("obr_clv_int_r"), "entero")
                        coop_allc.obr_clv2 = ValidarDBNull(row.Item("obr_clv2_r"), "cadena")
                        coop_allc.calle = ValidarDBNull(row.Item("calle_r"), "cadena")
                        coop_allc.colonia = ValidarDBNull(row.Item("colonia_r"), "cadena")
                        coop_allc.tramo = ValidarDBNull(row.Item("tramo_r"), "cadena")
                        coop_allc.obr_fecinip = ValidarDBNull(row.Item("obr_fecinip_r"), "fecha")
                        coop_allc.obr_fecvenp = ValidarDBNull(row.Item("obr_fecvenp_r"), "fecha")
                        coop_allc.obr_fec_ini_proc = ValidarDBNull(row.Item("obr_fec_ini_proc_r"), "fecha")
                        coop_allc.obr_fec_ini_cob = ValidarDBNull(row.Item("obr_fec_ini_cob_r"), "fecha")
                        coop_allc.obr_cost = ValidarDBNull(row.Item("obr_cost_r"), "real")
                        coop_allc.obr_prog2 = ValidarDBNull(row.Item("obr_prog2_r"), "entero")
                        coop_allc.nomprog = ValidarDBNull(row.Item("nomprog_r"), "cadena")
                        coop_allc.obr_opergob_sgp = ValidarDBNull(row.Item("obr_opergob_sgp_r"), "cadena")
                        coop_allc.inc_sgp = ValidarDBNull(row.Item("inc_sgp_r"), "real")
                        coop_allc.capital_sgp = ValidarDBNull(row.Item("capital_sgp_r"), "real")
                        coop_allc.total_capital_pagado = ValidarDBNull(row.Item("total_capital_pagado_r"), "real")
                        coop_allc.total_cargos_t5 = ValidarDBNull(row.Item("total_cargos_t5_r"), "real")
                        coop_allc.total_cargos_t6 = ValidarDBNull(row.Item("total_cargos_t6_r"), "real")
                        coop_allc.total_cargos_t7 = ValidarDBNull(row.Item("total_cargos_t7_r"), "real")
                        coop_allc.total_cargos_t16 = ValidarDBNull(row.Item("total_cargos_t16_r"), "real")
                        coop_allc.total_cargos_pagados_t5 = ValidarDBNull(row.Item("total_cargos_pagados_t5_r"), "real")
                        coop_allc.total_cargos_pagados_t6 = ValidarDBNull(row.Item("total_cargos_pagados_t6_r"), "real")
                        coop_allc.total_cargos_pagados_t7 = ValidarDBNull(row.Item("total_cargos_pagados_t7_r"), "real")
                        coop_allc.total_cargos_pagados_t16 = ValidarDBNull(row.Item("total_cargos_pagados_t16_r"), "real")
                        coop_allc.total_cargos_x_pagar_t5 = ValidarDBNull(row.Item("total_cargos_x_pagar_t5_r"), "real")
                        coop_allc.total_cargos_x_pagar_t6 = ValidarDBNull(row.Item("total_cargos_x_pagar_t6_r"), "real")
                        coop_allc.total_cargos_x_pagar_t7 = ValidarDBNull(row.Item("total_cargos_x_pagar_t7_r"), "real")
                        coop_allc.total_cargos_x_pagar_t16 = ValidarDBNull(row.Item("total_cargos_x_pagar_t16_r"), "real")
                        coop_allc.total_cargos = ValidarDBNull(row.Item("total_cargos_r"), "real")
                        coop_allc.total_cargos_pagados = ValidarDBNull(row.Item("total_cargos_pagados_r"), "real")
                        coop_allc.total_cargos_no_pagados = ValidarDBNull(row.Item("total_cargos_no_pagados_r"), "real")
                        coop_allc.total_pagos_x_coop = ValidarDBNull(row.Item("total_pagos_x_coop_r"), "real")
                        coop_allc.total_bonific_x_coop = ValidarDBNull(row.Item("total_bonific_x_coop_r"), "real")
                        coop_allc.total_descto_cargo_t3 = ValidarDBNull(row.Item("total_descto_cargo_t3_r"), "real")
                        coop_allc.saldo_rapido = ValidarDBNull(row.Item("saldo_rapido_r"), "real")
                        coop_allc.saldo_sin = ValidarDBNull(row.Item("saldo_sin_r"), "real")
                        coop_allc.saldo_con = ValidarDBNull(row.Item("saldo_con_r"), "real")
                        coop_allc.fec_notif_det = ValidarDBNull(row.Item("fec_notif_det_r"), "fechalarga")
                        coop_allc.notif_det = ValidarDBNull(row.Item("notif_det_r"), "entero")
                        coop_allc.nom_notif_det = ValidarDBNull(row.Item("nom_notif_det_r"), "cadena")
                        coop_allc.fec_notif_req = ValidarDBNull(row.Item("fec_notif_req_r"), "fechalarga")
                        coop_allc.notif_req = ValidarDBNull(row.Item("notif_req_r"), "entero")
                        coop_allc.nom_notif_req = ValidarDBNull(row.Item("nom_notif_req_r"), "cadena")
                        coop_allc.fec_notif_ejec = ValidarDBNull(row.Item("fec_notif_ejec_r"), "fechalarga")
                        coop_allc.notif_ejec = ValidarDBNull(row.Item("notif_ejec_r"), "entero")
                        coop_allc.nom_notif_ejec = ValidarDBNull(row.Item("nom_notif_ejec_r"), "cadena")
                        coop_allc.num_pagos = ValidarDBNull(row.Item("num_pagos_r"), "real")
                        coop_allc.costo_mto_old = ValidarDBNull(row.Item("costo_mto_old_r"), "real")
                        coops_allc.Add(coop_allc)
                    Next row

                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseCoopAllCV = New JQGridJsonResponseCoopAllCV
                objeto.JQGridJsonResponseCoopAllCV(pagecount, currentpage, recordcount, coops_allc)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Retorna los datos exclusivos del nombre seleccionado")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetCoopCV_all(accion As String, obra_coop_s As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public3.sp_coop_cartera_all_q", con)
                Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@accion_in", accion)
                cmd.Parameters.AddWithValue("@obra_coop_s", obra_coop_s)
                custDA.Fill(ds, "coop_cv_all")

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


    <WebMethod(Description:="Retorna datos de un predio seleccionado")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function RegCoop_Access(objCoopS As clsCoopWriteAccess) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf6").ConnectionString
        Dim ds As DataSet = New DataSet()
        Dim strSQL, strSQL2 As String

        strSQL = ""
        strSQL2 = ""
        Dim transaction As OleDbTransaction = Nothing

        If objCoopS.accion = 1 Then 'Alta de un cooperador en access

            'strSQL = "insert into cooperador (coo_clv,coo_pat,coo_mat,coo_nom,coo_nof,coo_call,coo_num,coo_col,coo_ciu,coo_est,coo_cp,coo_tel,coo_lote,coo_ant,coo_npag,coo_venc1,coo_obr,coo_mts,coo_inc,coo_clv1,coo_pred,coo_nombre,coo_pagos,coo_cargos,coo__gto_req,coo_gto_ejec,coo_notificado,coo_requerido,coo_ejecutado,coo_ultimoaviso,coo_propx,coo_rfc,coo_fiscal,coo_razonsoc,coo_grupo,coo_fecgrupo,coo_dec,coo_transferida)  values('"
            'strSQL = strSQL & objCoopS.coo_clv & "','" & objCoopS.coo_pat & "','" & objCoopS.coo_mat & "','" & objCoopS.coo_nom & "','" & objCoopS.coo_nof & "','" & objCoopS.coo_call & "','" & objCoopS.coo_num & "','" & objCoopS.coo_col & "','" & objCoopS.coo_ciu & "','" & objCoopS.coo_est & "','" & objCoopS.coo_cp & "','" & objCoopS.coo_tel & "','" & objCoopS.coo_lote & "'," & objCoopS.coo_ant & "," & objCoopS.coo_npag & ",'" & objCoopS.coo_venc1 & "','" & objCoopS.coo_obr & "'," & objCoopS.coo_mts & "," & objCoopS.coo_inc & ",'"
            'strSQL = strSQL & objCoopS.coo_clv1 & "','" & objCoopS.coo_pred & "','" & objCoopS.coo_nombre & "'," & objCoopS.coo_pagos & "," & objCoopS.coo_cargos & "," & objCoopS.coo_gto_req & "," & objCoopS.coo_gto_ejec & ",'" & objCoopS.coo_notificado & "','" & objCoopS.coo_requerido & "','" & objCoopS.coo_ejecutado & "','" & objCoopS.coo_ultimoaviso & "'," & objCoopS.coo_propx & ",'" & objCoopS.coo_rfc & "','" & objCoopS.coo_fiscal & "','" & objCoopS.coo_razonsoc & "','" & objCoopS.coo_grupo & "','" & objCoopS.coo_fecgrupo & "'," & objCoopS.coo_dec & "," & objCoopS.coo_transferida & ");"

            strSQL = "insert into cooperador (coo_clv,coo_pat,coo_mat,coo_nom,coo_nof,coo_npag,coo_venc1,coo_obr,coo_mts,coo_clv1,coo_pred,coo_nombre,coo_dec,coo_rfc,coo_fiscal,coo_razonsoc) "
            strSQL = strSQL & " values ('" & objCoopS.coo_clv & "','" & objCoopS.coo_pat & "','" & objCoopS.coo_mat & "','" & objCoopS.coo_nom & "','" & objCoopS.coo_nof & "'," & objCoopS.coo_npag & ",'" & objCoopS.coo_venc1 & "','" & objCoopS.coo_obr & "'," & objCoopS.coo_mts & ",'" & objCoopS.coo_clv1 & "','" & objCoopS.coo_pred & "','" & objCoopS.coo_nombre & "','" & objCoopS.coo_dec & "','                ','                                                                                                                                                      ','                                                                                                    '" & ");"

        End If

        If objCoopS.accion = 2 Then 'Actualización de un cooperador en acces

            strSQL = "update cooperador set coo_pat='" & objCoopS.coo_pat & "', coo_mat='" & objCoopS.coo_mat & "', coo_nom='" & objCoopS.coo_nom & "', coo_nof='" & objCoopS.coo_nof & "'," & "coo_mts=" & objCoopS.coo_mts & ",coo_pred='" & objCoopS.coo_pred & "', coo_nombre='" & objCoopS.coo_nombre & "', coo_dec=" & objCoopS.coo_dec & " where coo_clv ='" & objCoopS.coo_clv & "' and coo_obr='" & objCoopS.coo_obr & "';"


        End If

        Using con As New OleDbConnection(constr)
            ''Dim cmd As OleDbCommand = con.CreateCommand()
            ''Dim adapt As New OleDbDataAdapter(cmd)
            Try
                con.Open()

                transaction = con.BeginTransaction(IsolationLevel.ReadCommitted)
                '' cmd.Transaction = transaction
                Dim cmd = New OleDb.OleDbCommand(strSQL, con, transaction)
                cmd.ExecuteNonQuery()

                transaction.Commit()
            Catch ex As Exception
                Return "Error: No fue posible guardar el registro de cooperador"
            End Try
            con.Close()
        End Using


    End Function


    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetCoopSIFIDOC(obr_clv As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf6").ConnectionString
        Dim ds As DataSet = New DataSet()

        Dim strSQL As String = "select coo_clv1,coo_nombre,coo_nof from cooperador where coo_obr='" & obr_clv & "'"

        Using con As New OleDbConnection(constr)
            Using cmd As New OleDbCommand(strSQL, con)
                Dim adapt As OleDbDataAdapter = New OleDbDataAdapter(cmd)
                adapt.Fill(ds, "coops_sifidoc")

            End Using
        End Using
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

    End Function


    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCoopsfpc(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String, oid As Integer) As JQGridJsonResponseFrentePredioCoop
        Return GetCoopsfpcJSon(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro, oid)

    End Function

    Private Function GetCoopsfpcJSon(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String, oid As Integer) As JQGridJsonResponseFrentePredioCoop
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
            Using cmd As New NpgsqlCommand("sp_coop_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@oid", oid)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim coopsfpc = New List(Of clsFrentePredioCoop)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim coopfpc As clsFrentePredioCoop = New clsFrentePredioCoop()
                        coopfpc.oid = ValidarDBNull(row.Item("oidr"), "entero")
                        coopfpc.fid = ValidarDBNull(row.Item("fidr"), "entero")
                        coopfpc.pid = ValidarDBNull(row.Item("pidr"), "entero")
                        coopfpc.cid = ValidarDBNull(row.Item("cidr"), "entero")
                        coopfpc.cooperador = ValidarDBNull(row.Item("cooperadorr"), "cadena")
                        coopfpc.nomcoop = ValidarDBNull(row.Item("mnomfichar"), "cadena")
                        coopfpc.mts = ValidarDBNull(row.Item("mtsfrenter"), "real")
                        coopfpc.prid = ValidarDBNull(row.Item("pridr"), "entero")
                        coopfpc.costomtolineal = ValidarDBNull(row.Item("costomtolinealr"), "real")
                        coopfpc.costototalobra = ValidarDBNull(row.Item("costototalobrar"), "real")
                        coopfpc.nomprog = ValidarDBNull(row.Item("nomprogr"), "cadena")
                        coopfpc.progmun = ValidarDBNull(row.Item("progmunr"), "entero")
                        coopfpc.progcoop = ValidarDBNull(row.Item("progcoopr"), "entero")
                        coopfpc.progdescrip = ValidarDBNull(row.Item("progdescripr"), "cadena")
                        coopfpc.nooficial = ValidarDBNull(row.Item("nooficialr"), "cadena")
                        coopfpc.ctapredial = ValidarDBNull(row.Item("ctapredialr"), "cadena")
                        coopfpc.cup = ValidarDBNull(row.Item("cupr"), "cadena")
                        coopfpc.ctaimuvi = ValidarDBNull(row.Item("ctaimuvir"), "cadena")
                        coopfpc.sapal = ValidarDBNull(row.Item("sapalr"), "cadena")
                        coopfpc.tipopredionum = ValidarDBNull(row.Item("tipopredionumr"), "entero")
                        coopfpc.tipopredio = ValidarDBNull(row.Item("tipopredior"), "cadena")
                        coopfpc.adeudo = ValidarDBNull(row.Item("adeudor"), "real")
                        coopfpc.sumpagos = ValidarDBNull(row.Item("sumpagosr"), "real")
                        coopfpc.saldoact2 = ValidarDBNull(row.Item("saldoact2r"), "real")
                        coopfpc.saldoparcial = ValidarDBNull(row.Item("saldoparcialr"), "real")
                        coopfpc.fecpav = ValidarDBNull(row.Item("fecpavr"), "fecha")
                        coopfpc.factoract = ValidarDBNull(row.Item("factoractr"), "real")
                        coopfpc.periodoact = ValidarDBNull(row.Item("periodoactr"), "cadena")
                        coopfpc.saldopagar = ValidarDBNull(row.Item("saldopagarr"), "real")
                        coopfpc.recargos = ValidarDBNull(row.Item("recargosr"), "real")
                        coopfpc.estatusconv = ValidarDBNull(row.Item("estatusconvr"), "entero")
                        coopfpc.idconv = ValidarDBNull(row.Item("idconvr"), "entero")
                        coopfpc.pagosconv = ValidarDBNull(row.Item("pagosconvr"), "real")
                        coopfpc.UsuCre = ValidarDBNull(row.Item("usucrer"), "entero")
                        coopfpc.FecCre = ValidarDBNull(row.Item("feccrer"), "fecha")
                        coopfpc.UsuMod = ValidarDBNull(row.Item("usumodr"), "entero")
                        coopfpc.FecMod = ValidarDBNull(row.Item("fecmodr"), "fecha")
                        coopsfpc.Add(coopfpc)
                    Next row

                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseFrentePredioCoop = New JQGridJsonResponseFrentePredioCoop
                objeto.JQGridJsonResponseFrentePredioCoop(pagecount, currentpage, recordcount, coopsfpc)
                Return objeto
            End Using
        End Using
    End Function

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCoop_S2_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponseCoop_S2
        Return GetCoop_S2Json_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro)
    End Function

    Private Function GetCoop_S2Json_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponseCoop_S2
        Dim constr2 As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim dt2 As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr2)
            Using cmd As New NpgsqlCommand("public3.sp_coop_grid3", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pCurrentPage)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSortOrder)
                cmd.Parameters.AddWithValue("@filtro", pFiltro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim coops_S2 = New List(Of clsCoopS_2)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim coop_S2 As clsCoopS_2 = New clsCoopS_2()
                        coop_S2.obr_clv_int = ValidarDBNull(row.Item("obr_clv_int_r"), "entero")
                        coop_S2.obr_clv2 = ValidarDBNull(row.Item("obr_clv2_r"), "cadena")
                        coop_S2.obr_call = ValidarDBNull(row.Item("obr_call_r"), "cadena")
                        coop_S2.col_nom = ValidarDBNull(row.Item("col_nom_r"), "cadena")
                        coop_S2.obr_tramo = ValidarDBNull(row.Item("obr_tramo_r"), "cadena")
                        coop_S2.obr_mts = ValidarDBNull(row.Item("obr_mts_r"), "real")
                        coop_S2.obr_cost = ValidarDBNull(row.Item("obr_cost_r"), "real")
                        coop_S2.obr_fecha = ValidarDBNull(row.Item("obr_fecha_r"), "fecha")
                        coop_S2.obr_cost_total = ValidarDBNull(row.Item("obr_cost_total_r"), "real")
                        coop_S2.obr_inc = ValidarDBNull(row.Item("obr_inc_r"), "real")
                        coop_S2.obr_int = ValidarDBNull(row.Item("obr_int_r"), "entero")
                        coop_S2.descrip_tipo_obr = ValidarDBNull(row.Item("descrip_tipo_obr_r"), "cadena")
                        coop_S2.obr_fecinip = ValidarDBNull(row.Item("obr_fecinip_r"), "fecha")
                        coop_S2.obr_fecvenp = ValidarDBNull(row.Item("obr_fecvenp_r"), "fecha")
                        coop_S2.obr_npago = ValidarDBNull(row.Item("obr_npago_r"), "entero")
                        coop_S2.obr_opergob = ValidarDBNull(row.Item("obr_opergob_r"), "cadena")
                        coop_S2.obr_ubic = ValidarDBNull(row.Item("obr_ubic_r"), "entero")
                        coop_S2.obr_fec_ini_proc = ValidarDBNull(row.Item("obr_fec_ini_proc_r"), "fecha")
                        coop_S2.obr_fec_ini_cob = ValidarDBNull(row.Item("obr_fec_ini_cob_r"), "fecha")
                        coop_S2.obr_fec_pub1 = ValidarDBNull(row.Item("obr_fec_pub1_r"), "fecha")
                        coop_S2.obr_fec_pub2 = ValidarDBNull(row.Item("obr_fec_pub2_r"), "fecha")
                        coop_S2.evid_pub1 = ValidarDBNull(row.Item("evid_pub1_r"), "cadena")
                        coop_S2.evid_pub2 = ValidarDBNull(row.Item("evid_pub2_r"), "cadena")
                        coop_S2.col_clv2 = ValidarDBNull(row.Item("col_clv2_r"), "cadena")
                        coop_S2.obr_prog2 = ValidarDBNull(row.Item("obr_prog2_r"), "cadena")
                        coop_S2.nomprog = ValidarDBNull(row.Item("nomprog_r"), "cadena")
                        coop_S2.obr_status = ValidarDBNull(row.Item("obr_status_r"), "entero")
                        coop_S2.cestatus = ValidarDBNull(row.Item("cestatus_r"), "cadena")
                        coop_S2.coo_clv1 = ValidarDBNull(row.Item("coo_clv1_r"), "cadena")
                        coop_S2.coo_clv2 = ValidarDBNull(row.Item("coo_clv2_r"), "entero")
                        coop_S2.coo_pat = ValidarDBNull(row.Item("coo_pat_r"), "cadena")
                        coop_S2.coo_mat = ValidarDBNull(row.Item("coo_mat_r"), "cadena")
                        coop_S2.coo_nom = ValidarDBNull(row.Item("coo_nom_r"), "cadena")
                        coop_S2.coo_nombre = ValidarDBNull(row.Item("coo_nombre_r"), "cadena")
                        coop_S2.coo_nof = ValidarDBNull(row.Item("coo_nof_r"), "cadena")
                        coop_S2.coo_mts = ValidarDBNull(row.Item("coo_mts_r"), "real")
                        coop_S2.coo_pred = ValidarDBNull(row.Item("coo_pred_r"), "cadena")
                        coop_S2.coo_inc = ValidarDBNull(row.Item("coo_inc_r"), "real")
                        coop_S2.coo_tel = ValidarDBNull(row.Item("coo_tel_r"), "cadena")
                        coop_S2.suma_acces_6 = ValidarDBNull(row.Item("suma_acces_6_r"), "real")
                        coop_S2.mov_fec_acces_6 = ValidarDBNull(row.Item("mov_fec_acces_6_r"), "fecha")
                        coop_S2.suma_acces_7 = ValidarDBNull(row.Item("suma_acces_7_r"), "real")
                        coop_S2.mov_fec_acces_7 = ValidarDBNull(row.Item("mov_fec_acces_7_r"), "fecha")
                        coop_S2.fec_act = ValidarDBNull(row.Item("fec_act_r"), "fecha")
                        coop_S2.sum_pag_antes_221119 = ValidarDBNull(row.Item("sum_pag_antes_221119_r"), "real")
                        coop_S2.sum_pag_desp_221119 = ValidarDBNull(row.Item("sum_pag_desp_221119_r"), "real")
                        coop_S2.sum_pag_antes_fec_ent = ValidarDBNull(row.Item("sum_pag_antes_fec_ent_r"), "real")
                        coop_S2.sum_pag_desp_fec_ent = ValidarDBNull(row.Item("sum_pag_desp_fec_ent_r"), "real")
                        coop_S2.suerte_princ = ValidarDBNull(row.Item("suerte_princ_r"), "real")
                        coop_S2.saldo_act1 = ValidarDBNull(row.Item("saldo_act1_r"), "real")
                        coop_S2.clv_inpc_ant = ValidarDBNull(row.Item("clv_inpc_ant_r"), "cadena")
                        coop_S2.clv_inpc_actual = ValidarDBNull(row.Item("clv_inpc_actual_r"), "cadena")
                        coop_S2.clv_inpc_actual_2 = ValidarDBNull(row.Item("clv_inpc_actual_2_r"), "cadena")
                        coop_S2.factor1 = ValidarDBNull(row.Item("factor1_r"), "real")
                        coop_S2.factor2 = ValidarDBNull(row.Item("factor2_r"), "real")
                        coop_S2.factor3 = ValidarDBNull(row.Item("factor3_r"), "real")
                        coop_S2.factor_act = ValidarDBNull(row.Item("factor_act_r"), "real")
                        coop_S2.saldo_act2 = ValidarDBNull(row.Item("saldo_act2_r"), "real")
                        coop_S2.monto_act = ValidarDBNull(row.Item("monto_act_r"), "real")
                        coop_S2.saldo_act3 = ValidarDBNull(row.Item("saldo_act3_r"), "real")
                        coop_S2.sum_recargos = ValidarDBNull(row.Item("sum_recargos_r"), "real")
                        coop_S2.sum_recargos_tipo_8 = ValidarDBNull(row.Item("sum_recargos_tipo_8_r"), "real")
                        coop_S2.sum_recargos_tipo_10 = ValidarDBNull(row.Item("sum_recargos_tipo_10_r"), "real")
                        coop_S2.sum_desctos = ValidarDBNull(row.Item("sum_desctos_r"), "real")
                        coop_S2.sum_desctos_xap = ValidarDBNull(row.Item("sum_desctos_xap_r"), "real")
                        coop_S2.sum_pagos = ValidarDBNull(row.Item("sum_pagos_r"), "real")
                        coop_S2.sum_bonific = ValidarDBNull(row.Item("sum_bonific_r"), "real")
                        coop_S2.sum_bonific_xap = ValidarDBNull(row.Item("sum_bonific_xap_r"), "real")
                        coop_S2.saldo_act4 = ValidarDBNull(row.Item("saldo_act4_r"), "real")
                        coop_S2.saldo_depurar = ValidarDBNull(row.Item("saldo_depurar_r"), "real")
                        coop_S2.saldo_act5 = ValidarDBNull(row.Item("saldo_act5_r"), "real")
                        coop_S2.sum_rec_act_saldo = ValidarDBNull(row.Item("sum_rec_act_saldo_r"), "real")
                        coop_S2.fec_ult_rec_act_saldo = ValidarDBNull(row.Item("fec_rec_act_saldo_r"), "fecha")
                        coop_S2.fact_act_ant = ValidarDBNull(row.Item("fact_act_ant_r"), "real")
                        coop_S2.fec_notif_det = ValidarDBNull(row.Item("fec_notif_det_r"), "real")
                        coop_S2.fec_notif_req = ValidarDBNull(row.Item("fec_notif_req_r"), "real")
                        coop_S2.fec_notif_ejec = ValidarDBNull(row.Item("fec_notif_ejec_r"), "real")
                        coops_S2.Add(coop_S2)
                    Next row

                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseCoop_S2 = New JQGridJsonResponseCoop_S2
                objeto.JQGridJsonResponseCoop_S2(pagecount, currentpage, recordcount, coops_S2)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCoops2_psql(pPageSize As Integer,
                                   pCurrentPage As Integer,
                                   pSortColumn As String,
                                   pSortOrder As String,
                                   fid As Integer,
                                   obr_clv_int As Integer,
                                   coo_clv_txt As String,
                                   amaterno As String,
                                   apaterno As String,
                                   nombre As String,
                                   nom_ficha As String,
                                   nom_calle As String,
                                   nom_col As String,
                                   ctapredial As String,
                                   accion As Integer) As JQGridJsonResponseCoopS
        Return GetCoops2Json_psql(pPageSize,
                                  pCurrentPage,
                                  pSortColumn,
                                  pSortOrder,
                                  fid,
                                  obr_clv_int,
                                  coo_clv_txt,
                                  amaterno,
                                  apaterno,
                                  nombre,
                                  nom_ficha,
                                  nom_calle,
                                  nom_col,
                                  ctapredial,
                                  accion)
    End Function

    Private Function GetCoops2Json_psql(pPageSize As Integer,
                                   pCurrentPage As Integer,
                                   pSortColumn As String,
                                   pSortOrder As String,
                                   fid As Integer,
                                   obr_clv_int As Integer,
                                   coo_clv_txt As String,
                                   amaterno As String,
                                   apaterno As String,
                                   nombre As String,
                                   nom_ficha As String,
                                   nom_calle As String,
                                   nom_col As String,
                                   ctapredial As String,
                                   accion As Integer) As JQGridJsonResponseCoopS
        Dim constr2 As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim dt2 As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr2)
            Using cmd As New NpgsqlCommand("public3.sp_coop_grid2", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pCurrentPage)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSortOrder)
                cmd.Parameters.AddWithValue("@fid_in", fid)
                cmd.Parameters.AddWithValue("@obr_clv_int_in", obr_clv_int)
                cmd.Parameters.AddWithValue("@coo_clv_txt_in", coo_clv_txt)
                cmd.Parameters.AddWithValue("@amaterno_in", amaterno)
                cmd.Parameters.AddWithValue("@apaterno_in", apaterno)
                cmd.Parameters.AddWithValue("@nombre_in", nombre)
                cmd.Parameters.AddWithValue("@nomficha_in", nom_ficha)
                cmd.Parameters.AddWithValue("@nom_calle_in", nom_calle)
                cmd.Parameters.AddWithValue("@nom_col_in", nom_col)
                cmd.Parameters.AddWithValue("@ctapredial_in", ctapredial)
                cmd.Parameters.AddWithValue("@accion_in", accion)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim coops = New List(Of clsCoopS)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim coop As clsCoopS = New clsCoopS()
                        coop.fid = ValidarDBNull(row.Item("out_fid"), "entero")
                        coop.geom_frente = ValidarDBNull(row.Item("out_geom_frente"), "cadena")
                        coop.mts_frente = ValidarDBNull(row.Item("out_mts_frente"), "real")
                        coop.cid = ValidarDBNull(row.Item("out_cid"), "entero")
                        coop.coopid = ValidarDBNull(row.Item("out_coopid"), "cadena")
                        coop.pid = ValidarDBNull(row.Item("out_pid"), "entero")
                        coop.oid = ValidarDBNull(row.Item("out_oid"), "entero")
                        coop.obs_grales = ValidarDBNull(row.Item("out_obs_grales"), "cadena")
                        coop.obra_sifidoc = ValidarDBNull(row.Item("out_obra_sifidoc"), "cadena")
                        coop.gid = ValidarDBNull(row.Item("out_gid"), "entero")
                        coop.feccre_frente = ValidarDBNull(row.Item("out_feccre_frente"), "fecha")
                        coop.fecmod_frente = ValidarDBNull(row.Item("out_fecmod_frente"), "fecha")
                        coop.usucre_frente = ValidarDBNull(row.Item("out_usucre_frente"), "cadena")
                        coop.usumod_frente = ValidarDBNull(row.Item("out_usumod_frente"), "cadena")
                        coop.prid = ValidarDBNull(row.Item("out_prid"), "entero")
                        coop.inc = ValidarDBNull(row.Item("out_inc"), "real")
                        coop.did = ValidarDBNull(row.Item("out_did"), "entero")
                        coop.factor_act_pago = ValidarDBNull(row.Item("out_factor_act_pago"), "real")
                        coop.obr_clv_int = ValidarDBNull(row.Item("out_obr_clv_int"), "entero")
                        coop.coo_clv2 = ValidarDBNull(row.Item("out_coo_clv2"), "entero")
                        coop.activo = ValidarDBNull(row.Item("out_activo"), "entero")
                        coop.capital = ValidarDBNull(row.Item("out_capital"), "real")
                        coop.midcoop = ValidarDBNull(row.Item("out_midcoop"), "entero")
                        coop.mapellidop = ValidarDBNull(row.Item("out_mapellidop"), "cadena")
                        coop.mapellidom = ValidarDBNull(row.Item("out_mapellidom"), "cadena")
                        coop.mnombres = ValidarDBNull(row.Item("out_mnombres"), "cadena")
                        coop.mcallecoop = ValidarDBNull(row.Item("out_mcallecoop"), "cadena")
                        coop.mcolcoop = ValidarDBNull(row.Item("out_mcolcoop"), "cadena")
                        coop.mnooficial_ext = ValidarDBNull(row.Item("out_mnooficial_ext"), "cadena")
                        coop.mnooficial_int = ValidarDBNull(row.Item("out_mnooficial_int"), "cadena")
                        coop.mtelcoop = ValidarDBNull(row.Item("out_mtelcoop"), "cadena")
                        coop.mnomficha = ValidarDBNull(row.Item("out_mnomficha"), "cadena")
                        coop.mestado = ValidarDBNull(row.Item("out_mestado"), "cadena")
                        coop.mpais = ValidarDBNull(row.Item("out_mpais"), "cadena")
                        coop.mcorreo = ValidarDBNull(row.Item("out_mcorreo"), "cadena")
                        coop.usrcre_coop = ValidarDBNull(row.Item("out_usrcre_coop"), "cadena")
                        coop.feccre_coop = ValidarDBNull(row.Item("out_feccre_coop"), "fecha")
                        coop.usrmod_coop = ValidarDBNull(row.Item("out_usrmod_coop"), "cadena")
                        coop.fecmod_coop = ValidarDBNull(row.Item("out_fecmod_coop"), "fecha")
                        coop.mcurp = ValidarDBNull(row.Item("out_mcurp"), "cadena")
                        coop.mrelacionpredio = ValidarDBNull(row.Item("out_mrelacionpredio"), "entero")
                        coop.ine = ValidarDBNull(row.Item("out_ine"), "cadena")
                        coop.doc_identific = ValidarDBNull(row.Item("out_doc_identific"), "cadena")
                        coop.obr_clv = ValidarDBNull(row.Item("out_obr_clv"), "cadena")
                        coop.obr_mts = ValidarDBNull(row.Item("out_obr_mts"), "cadena")
                        coop.obr_cost = ValidarDBNull(row.Item("out_obr_cost"), "real")
                        coop.obr_int = ValidarDBNull(row.Item("out_obr_int"), "entero")
                        coop.obr_fecha = ValidarDBNull(row.Item("out_obr_fecha"), "fecha")
                        coop.obr_cost_total = ValidarDBNull(row.Item("out_obr_cost_total"), "real")
                        coop.obr_inc = ValidarDBNull(row.Item("out_obr_inc"), "real")
                        coop.obr_fecinip = ValidarDBNull(row.Item("out_obr_fecinip"), "fecha")
                        coop.obr_fecvenp = ValidarDBNull(row.Item("out_obr_fecvenp"), "fecha")
                        coop.obr_npago = ValidarDBNull(row.Item("out_obr_npago"), "entero")
                        coop.obr_opergob = ValidarDBNull(row.Item("out_obr_opergob"), "cadena")
                        coop.obr_fec_ini_proc = ValidarDBNull(row.Item("out_obr_fec_ini_proc"), "fecha")
                        coop.obr_fec_ini_cob = ValidarDBNull(row.Item("out_obr_fec_ini_cob"), "fecha")
                        coop.obr_clv_int_obra = ValidarDBNull(row.Item("out_obr_clv_int_obra"), "entero")
                        coop.obr_prog2 = ValidarDBNull(row.Item("out_obr_prog2"), "entero")
                        coop.nomprog = ValidarDBNull(row.Item("out_nomprog"), "cadena")
                        coop.progdescrip = ValidarDBNull(row.Item("out_progdescrip"), "cadena")
                        coop.obr_clv2 = ValidarDBNull(row.Item("out_obr_clv2"), "cadena")
                        coop.obr_status = ValidarDBNull(row.Item("out_obr_status"), "entero")
                        coop.cestatus = ValidarDBNull(row.Item("out_cestatus"), "cadena")
                        coop.oid_obra = ValidarDBNull(row.Item("out_oid_obra"), "entero")
                        coop.obr_fec_canc = ValidarDBNull(row.Item("out_obr_fec_canc"), "fecha")
                        coop.obr_sis = ValidarDBNull(row.Item("out_obr_sis"), "cadena")
                        coop.col_clv2 = ValidarDBNull(row.Item("out_col_clv2"), "cadena")
                        coop.no_contrato = ValidarDBNull(row.Item("out_no_contrato"), "cadena")
                        coop.gastos_admvos = ValidarDBNull(row.Item("out_gastos_admvos"), "real")
                        coop.obr_fec_pub1 = ValidarDBNull(row.Item("out_obr_fec_pub1"), "fecha")
                        coop.obr_fec_pub2 = ValidarDBNull(row.Item("out_obr_fec_pub2"), "fecha")
                        coop.evid_pub1 = ValidarDBNull(row.Item("out_evid_pub1"), "cadena")
                        coop.evid_pub2 = ValidarDBNull(row.Item("out_evid_pub2"), "cadena")
                        coop.evid_obra_proc = ValidarDBNull(row.Item("out_evid_obra_proc"), "cadena")
                        coop.evid_termino_obra = ValidarDBNull(row.Item("out_evid_termino_obra"), "cadena")
                        coop.obr_nat = ValidarDBNull(row.Item("out_obr_nat"), "cadena")
                        coop.pid_predio = ValidarDBNull(row.Item("out_pid_predio"), "entero")
                        coop.objectid = ValidarDBNull(row.Item("out_objectid"), "cadena")
                        coop.gid_server = ValidarDBNull(row.Item("out_gid_server"), "real")
                        coop.cup = ValidarDBNull(row.Item("out_cup"), "cadena")
                        coop.feccre_pred = ValidarDBNull(row.Item("out_feccre_pred"), "fecha")
                        coop.fecmod_pred = ValidarDBNull(row.Item("out_fecmod_pred"), "fecha")
                        coop.tipo = ValidarDBNull(row.Item("out_tipo"), "cadena")
                        coop.tipopredio = ValidarDBNull(row.Item("out_tipopredio"), "real")
                        coop.ctapredial = ValidarDBNull(row.Item("out_ctapredial"), "cadena")
                        coop.ctaimuvi = ValidarDBNull(row.Item("out_ctaimuvi"), "cadena")
                        coop.observacio = ValidarDBNull(row.Item("out_observacio"), "cadena")
                        coop.shape_area = ValidarDBNull(row.Item("out_shape_area"), "real")
                        coop.shape_len = ValidarDBNull(row.Item("out_shape_len"), "real")
                        coop.geom_predio = ValidarDBNull(row.Item("out_geom_predio"), "cadena")
                        coop.uso_predio = ValidarDBNull(row.Item("out_uso_predio"), "entero")
                        coop.uso_suelo = ValidarDBNull(row.Item("out_uso_suelo"), "cadena")
                        coop.r20 = ValidarDBNull(row.Item("out_r20"), "cadena")
                        coop.nooficial = ValidarDBNull(row.Item("out_nooficial"), "cadena")
                        coop.sapal = ValidarDBNull(row.Item("out_sapal"), "cadena")
                        coop.usrcre_pred = ValidarDBNull(row.Item("out_usrcre_pred"), "entero")
                        coop.usrmod_pred = ValidarDBNull(row.Item("out_usrmod_pred"), "entero")
                        coop.num_escritura = ValidarDBNull(row.Item("out_num_escritura"), "cadena")
                        coop.reg_escritura = ValidarDBNull(row.Item("out_reg_escritura"), "cadena")
                        coop.folio_escritura = ValidarDBNull(row.Item("out_folio_escritura"), "cadena")
                        coop.tomo_escritura = ValidarDBNull(row.Item("out_tomo_escritura"), "cadena")
                        coop.doc_escritura = ValidarDBNull(row.Item("out_doc_escritura"), "cadena")
                        coop.lote = ValidarDBNull(row.Item("out_lote"), "cadena")
                        coop.mzna = ValidarDBNull(row.Item("out_mzna"), "cadena")
                        coop.saldo_sin = ValidarDBNull(row.Item("out_saldo_sin"), "real")
                        coop.saldo_sin_act = ValidarDBNull(row.Item("out_saldo_sin_act"), "real")
                        coop.clv_inpc_ant = ValidarDBNull(row.Item("out_clv_inpc_ant"), "cadena")
                        coop.clv_inpc_actual = ValidarDBNull(row.Item("out_clv_inpc_actual"), "cadena")
                        coop.clv_inpc_actual_2 = ValidarDBNull(row.Item("out_clv_inpc_actual_2"), "cadena")
                        coop.factor_act = ValidarDBNull(row.Item("out_factor_act"), "real")
                        coop.monto_act = ValidarDBNull(row.Item("out_monto_act"), "real")
                        coop.saldo = ValidarDBNull(row.Item("out_saldo"), "real")
                        coop.calle = ValidarDBNull(row.Item("out_calle"), "cadena")
                        coop.colonia = ValidarDBNull(row.Item("out_colonia"), "cadena")
                        coop.limite1 = ValidarDBNull(row.Item("out_limite1"), "cadena")
                        coop.limite2 = ValidarDBNull(row.Item("out_limite2"), "cadena")
                        coop.tramo = ValidarDBNull(row.Item("out_tramo"), "cadena")
                        coop.pae = ValidarDBNull(row.Item("out_pae"), "entero")
                        coop.iddet = ValidarDBNull(row.Item("out_iddet"), "entero")
                        coop.det_estatus = ValidarDBNull(row.Item("out_det_estatus"), "entero")
                        coop.fec_imp_det = ValidarDBNull(row.Item("out_fec_imp_det"), "fecha")
                        coop.fec_ent_det = ValidarDBNull(row.Item("out_fec_ent_det"), "fecha")
                        coop.fec_notif_det = ValidarDBNull(row.Item("out_fec_notif_det"), "fecha")
                        coop.hora_notif_det = ValidarDBNull(row.Item("out_hora_notif_det"), "fecha")
                        coop.idministro = ValidarDBNull(row.Item("out_idministro"), "entero")
                        coop.musunombre = ValidarDBNull(row.Item("out_musunombre"), "cadena")
                        coop.tipo_doc = ValidarDBNull(row.Item("out_tipo_doc"), "entero")
                        coops.Add(coop)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseCoopS = New JQGridJsonResponseCoopS
                objeto.JQGridJsonResponseCoopS(pagecount, currentpage, recordcount, coops)
                Return objeto
            End Using
        End Using
    End Function

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCoops3_psql(pPageSize As Integer,
                                   pCurrentPage As Integer,
                                   pSortColumn As String,
                                   pSortOrder As String,
                                   accion As Integer) As JQGridJsonResponseCoopS
        Return GetCoops3Json_psql(pPageSize,
                                  pCurrentPage,
                                  pSortColumn,
                                  pSortOrder,
                                  accion)
    End Function

    Private Function GetCoops3Json_psql(pPageSize As Integer,
                                   pCurrentPage As Integer,
                                   pSortColumn As String,
                                   pSortOrder As String,
                                   accion As Integer) As JQGridJsonResponseCoopS
        Dim constr2 As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim dt2 As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr2)
            Using cmd As New NpgsqlCommand("public3.sp_coop_grid5", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pCurrentPage)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSortOrder)
                cmd.Parameters.AddWithValue("@accion_in", accion)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim coops = New List(Of clsCoopS)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim coop As clsCoopS = New clsCoopS()
                        coop.fid = ValidarDBNull(row.Item("out_fid"), "entero")
                        coop.geom_frente = ValidarDBNull(row.Item("out_geom_frente"), "cadena")
                        coop.mts_frente = ValidarDBNull(row.Item("out_mts_frente"), "real")
                        coop.cid = ValidarDBNull(row.Item("out_cid"), "entero")
                        coop.coopid = ValidarDBNull(row.Item("out_coopid"), "cadena")
                        coop.pid = ValidarDBNull(row.Item("out_pid"), "entero")
                        coop.oid = ValidarDBNull(row.Item("out_oid"), "entero")
                        coop.obs_grales = ValidarDBNull(row.Item("out_obs_grales"), "cadena")
                        coop.obra_sifidoc = ValidarDBNull(row.Item("out_obra_sifidoc"), "cadena")
                        coop.gid = ValidarDBNull(row.Item("out_gid"), "entero")
                        coop.feccre_frente = ValidarDBNull(row.Item("out_feccre_frente"), "fecha")
                        coop.fecmod_frente = ValidarDBNull(row.Item("out_fecmod_frente"), "fecha")
                        coop.usucre_frente = ValidarDBNull(row.Item("out_usucre_frente"), "cadena")
                        coop.usumod_frente = ValidarDBNull(row.Item("out_usumod_frente"), "cadena")
                        coop.prid = ValidarDBNull(row.Item("out_prid"), "entero")
                        coop.inc = ValidarDBNull(row.Item("out_inc"), "real")
                        coop.did = ValidarDBNull(row.Item("out_did"), "entero")
                        coop.factor_act_pago = ValidarDBNull(row.Item("out_factor_act_pago"), "real")
                        coop.obr_clv_int = ValidarDBNull(row.Item("out_obr_clv_int"), "entero")
                        coop.coo_clv2 = ValidarDBNull(row.Item("out_coo_clv2"), "entero")
                        coop.activo = ValidarDBNull(row.Item("out_activo"), "entero")
                        coop.capital = ValidarDBNull(row.Item("out_capital"), "real")
                        coop.midcoop = ValidarDBNull(row.Item("out_midcoop"), "entero")
                        coop.mapellidop = ValidarDBNull(row.Item("out_mapellidop"), "cadena")
                        coop.mapellidom = ValidarDBNull(row.Item("out_mapellidom"), "cadena")
                        coop.mnombres = ValidarDBNull(row.Item("out_mnombres"), "cadena")
                        coop.mcallecoop = ValidarDBNull(row.Item("out_mcallecoop"), "cadena")
                        coop.mcolcoop = ValidarDBNull(row.Item("out_mcolcoop"), "cadena")
                        coop.mnooficial_ext = ValidarDBNull(row.Item("out_mnooficial_ext"), "cadena")
                        coop.mnooficial_int = ValidarDBNull(row.Item("out_mnooficial_int"), "cadena")
                        coop.mtelcoop = ValidarDBNull(row.Item("out_mtelcoop"), "cadena")
                        coop.mnomficha = ValidarDBNull(row.Item("out_mnomficha"), "cadena")
                        coop.mestado = ValidarDBNull(row.Item("out_mestado"), "cadena")
                        coop.mpais = ValidarDBNull(row.Item("out_mpais"), "cadena")
                        coop.mcorreo = ValidarDBNull(row.Item("out_mcorreo"), "cadena")
                        coop.usrcre_coop = ValidarDBNull(row.Item("out_usrcre_coop"), "cadena")
                        coop.feccre_coop = ValidarDBNull(row.Item("out_feccre_coop"), "fecha")
                        coop.usrmod_coop = ValidarDBNull(row.Item("out_usrmod_coop"), "cadena")
                        coop.fecmod_coop = ValidarDBNull(row.Item("out_fecmod_coop"), "fecha")
                        coop.mcurp = ValidarDBNull(row.Item("out_mcurp"), "cadena")
                        coop.mrelacionpredio = ValidarDBNull(row.Item("out_mrelacionpredio"), "entero")
                        coop.ine = ValidarDBNull(row.Item("out_ine"), "cadena")
                        coop.doc_identific = ValidarDBNull(row.Item("out_doc_identific"), "cadena")
                        coop.obr_clv = ValidarDBNull(row.Item("out_obr_clv"), "cadena")
                        coop.obr_mts = ValidarDBNull(row.Item("out_obr_mts"), "cadena")
                        coop.obr_cost = ValidarDBNull(row.Item("out_obr_cost"), "real")
                        coop.obr_int = ValidarDBNull(row.Item("out_obr_int"), "entero")
                        coop.obr_fecha = ValidarDBNull(row.Item("out_obr_fecha"), "fecha")
                        coop.obr_cost_total = ValidarDBNull(row.Item("out_obr_cost_total"), "real")
                        coop.obr_inc = ValidarDBNull(row.Item("out_obr_inc"), "real")
                        coop.obr_fecinip = ValidarDBNull(row.Item("out_obr_fecinip"), "fecha")
                        coop.obr_fecvenp = ValidarDBNull(row.Item("out_obr_fecvenp"), "fecha")
                        coop.obr_npago = ValidarDBNull(row.Item("out_obr_npago"), "entero")
                        coop.obr_opergob = ValidarDBNull(row.Item("out_obr_opergob"), "cadena")
                        coop.obr_fec_ini_proc = ValidarDBNull(row.Item("out_obr_fec_ini_proc"), "fecha")
                        coop.obr_fec_ini_cob = ValidarDBNull(row.Item("out_obr_fec_ini_cob"), "fecha")
                        coop.obr_clv_int_obra = ValidarDBNull(row.Item("out_obr_clv_int_obra"), "entero")
                        coop.obr_prog2 = ValidarDBNull(row.Item("out_obr_prog2"), "entero")
                        coop.nomprog = ValidarDBNull(row.Item("out_nomprog"), "cadena")
                        coop.progdescrip = ValidarDBNull(row.Item("out_progdescrip"), "cadena")
                        coop.obr_clv2 = ValidarDBNull(row.Item("out_obr_clv2"), "cadena")
                        coop.obr_status = ValidarDBNull(row.Item("out_obr_status"), "entero")
                        coop.cestatus = ValidarDBNull(row.Item("out_cestatus"), "cadena")
                        coop.oid_obra = ValidarDBNull(row.Item("out_oid_obra"), "entero")
                        coop.obr_fec_canc = ValidarDBNull(row.Item("out_obr_fec_canc"), "fecha")
                        coop.obr_sis = ValidarDBNull(row.Item("out_obr_sis"), "cadena")
                        coop.col_clv2 = ValidarDBNull(row.Item("out_col_clv2"), "cadena")
                        coop.no_contrato = ValidarDBNull(row.Item("out_no_contrato"), "cadena")
                        coop.gastos_admvos = ValidarDBNull(row.Item("out_gastos_admvos"), "real")
                        coop.obr_fec_pub1 = ValidarDBNull(row.Item("out_obr_fec_pub1"), "fecha")
                        coop.obr_fec_pub2 = ValidarDBNull(row.Item("out_obr_fec_pub2"), "fecha")
                        coop.evid_pub1 = ValidarDBNull(row.Item("out_evid_pub1"), "cadena")
                        coop.evid_pub2 = ValidarDBNull(row.Item("out_evid_pub2"), "cadena")
                        coop.evid_obra_proc = ValidarDBNull(row.Item("out_evid_obra_proc"), "cadena")
                        coop.evid_termino_obra = ValidarDBNull(row.Item("out_evid_termino_obra"), "cadena")
                        coop.obr_nat = ValidarDBNull(row.Item("out_obr_nat"), "cadena")
                        coop.pid_predio = ValidarDBNull(row.Item("out_pid_predio"), "entero")
                        coop.objectid = ValidarDBNull(row.Item("out_objectid"), "cadena")
                        coop.gid_server = ValidarDBNull(row.Item("out_gid_server"), "real")
                        coop.cup = ValidarDBNull(row.Item("out_cup"), "cadena")
                        coop.feccre_pred = ValidarDBNull(row.Item("out_feccre_pred"), "fecha")
                        coop.fecmod_pred = ValidarDBNull(row.Item("out_fecmod_pred"), "fecha")
                        coop.tipo = ValidarDBNull(row.Item("out_tipo"), "cadena")
                        coop.tipopredio = ValidarDBNull(row.Item("out_tipopredio"), "real")
                        coop.ctapredial = ValidarDBNull(row.Item("out_ctapredial"), "cadena")
                        coop.ctaimuvi = ValidarDBNull(row.Item("out_ctaimuvi"), "cadena")
                        coop.observacio = ValidarDBNull(row.Item("out_observacio"), "cadena")
                        coop.shape_area = ValidarDBNull(row.Item("out_shape_area"), "real")
                        coop.shape_len = ValidarDBNull(row.Item("out_shape_len"), "real")
                        coop.geom_predio = ValidarDBNull(row.Item("out_geom_predio"), "cadena")
                        coop.uso_predio = ValidarDBNull(row.Item("out_uso_predio"), "entero")
                        coop.uso_suelo = ValidarDBNull(row.Item("out_uso_suelo"), "cadena")
                        coop.r20 = ValidarDBNull(row.Item("out_r20"), "cadena")
                        coop.nooficial = ValidarDBNull(row.Item("out_nooficial"), "cadena")
                        coop.sapal = ValidarDBNull(row.Item("out_sapal"), "cadena")
                        coop.usrcre_pred = ValidarDBNull(row.Item("out_usrcre_pred"), "entero")
                        coop.usrmod_pred = ValidarDBNull(row.Item("out_usrmod_pred"), "entero")
                        coop.num_escritura = ValidarDBNull(row.Item("out_num_escritura"), "cadena")
                        coop.reg_escritura = ValidarDBNull(row.Item("out_reg_escritura"), "cadena")
                        coop.folio_escritura = ValidarDBNull(row.Item("out_folio_escritura"), "cadena")
                        coop.tomo_escritura = ValidarDBNull(row.Item("out_tomo_escritura"), "cadena")
                        coop.doc_escritura = ValidarDBNull(row.Item("out_doc_escritura"), "cadena")
                        coop.lote = ValidarDBNull(row.Item("out_lote"), "cadena")
                        coop.mzna = ValidarDBNull(row.Item("out_mzna"), "cadena")
                        coop.saldo_sin = ValidarDBNull(row.Item("out_saldo_sin"), "real")
                        coop.saldo_sin_act = ValidarDBNull(row.Item("out_saldo_sin_act"), "real")
                        coop.pagos = ValidarDBNull(row.Item("out_pagos"), "real")
                        coop.recargos = ValidarDBNull(row.Item("out_recargos"), "real")
                        coop.clv_inpc_ant = ValidarDBNull(row.Item("out_clv_inpc_ant"), "cadena")
                        coop.clv_inpc_actual = ValidarDBNull(row.Item("out_clv_inpc_actual"), "cadena")
                        coop.clv_inpc_actual_2 = ValidarDBNull(row.Item("out_clv_inpc_actual_2"), "cadena")
                        coop.factor_act = ValidarDBNull(row.Item("out_factor_act"), "real")
                        coop.monto_act = ValidarDBNull(row.Item("out_monto_act"), "real")
                        coop.saldo = ValidarDBNull(row.Item("out_saldo"), "real")
                        coop.calle = ValidarDBNull(row.Item("out_calle"), "cadena")
                        coop.colonia = ValidarDBNull(row.Item("out_colonia"), "cadena")
                        coop.limite1 = ValidarDBNull(row.Item("out_limite1"), "cadena")
                        coop.limite2 = ValidarDBNull(row.Item("out_limite2"), "cadena")
                        coop.tramo = ValidarDBNull(row.Item("out_tramo"), "cadena")
                        coop.pae = ValidarDBNull(row.Item("out_pae"), "entero")
                        coop.iddet = ValidarDBNull(row.Item("out_iddet"), "entero")
                        coop.det_estatus = ValidarDBNull(row.Item("out_det_estatus"), "entero")
                        coop.fec_imp_det = ValidarDBNull(row.Item("out_fec_imp_det"), "fecha")
                        coop.fec_ent_det = ValidarDBNull(row.Item("out_fec_ent_det"), "fecha")
                        coop.fec_notif_det = ValidarDBNull(row.Item("out_fec_notif_det"), "fecha")
                        coop.hora_notif_det = ValidarDBNull(row.Item("out_hora_notif_det"), "fecha")
                        coop.idministro = ValidarDBNull(row.Item("out_idministro"), "entero")
                        coop.musunombre = ValidarDBNull(row.Item("out_musunombre"), "cadena")
                        coop.tipo_doc = ValidarDBNull(row.Item("out_tipo_doc"), "entero")
                        coop.nom_doc = ValidarDBNull(row.Item("out_nom_doc"), "cadena")
                        coops.Add(coop)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseCoopS = New JQGridJsonResponseCoopS
                objeto.JQGridJsonResponseCoopS(pagecount, currentpage, recordcount, coops)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCoopsfpc_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String, oid As Integer) As JQGridJsonResponseFrentePredioCoop
        Return GetCoopsfpcJSon_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro, oid)
    End Function

    Private Function GetCoopsfpcJSon_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String, oid As Integer) As JQGridJsonResponseFrentePredioCoop
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim constr2 As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim dt2 As DataSet = New DataSet()

        Dim fidx As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("sp_oid_coop_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                cmd.Parameters.AddWithValue("@oid", oid)
                cmd.Parameters.AddWithValue("@NoError", 1)
                cmd.Parameters.AddWithValue("@DescError", "ERROR")
                Dim adapt As SqlDataAdapter = New SqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim coopsfpc = New List(Of clsFrentePredioCoop)
                If Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")) > 0 Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim coopfpc As clsFrentePredioCoop = New clsFrentePredioCoop()
                        coopfpc.oid = ValidarDBNull(row.Item("oid"), "entero")
                        coopfpc.fid = ValidarDBNull(row.Item("fid"), "entero")
                        coopfpc.pid = ValidarDBNull(row.Item("pid"), "entero")
                        coopfpc.cid = ValidarDBNull(row.Item("cid"), "entero")
                        coopfpc.cooperador = ValidarDBNull(row.Item("cooperador"), "cadena")
                        coopfpc.mts = ValidarDBNull(row.Item("mts_frente"), "entero")
                        coopfpc.nomcoop = ValidarDBNull(row.Item("mNomficha"), "cadena")
                        coopfpc.ctapredial = ValidarDBNull(row.Item("ctapredial"), "cadena")
                        coopfpc.UsuCre = ValidarDBNull(row.Item("usrcre"), "entero")
                        coopfpc.FecCre = ValidarDBNull(row.Item("feccre"), "entero")
                        coopfpc.UsuMod = ValidarDBNull(row.Item("usrmod"), "entero")
                        coopfpc.FecMod = ValidarDBNull(row.Item("fecmod"), "entero")
                        coopsfpc.Add(coopfpc)
                    Next row

                End If
                Dim objeto As JQGridJsonResponseFrentePredioCoop = New JQGridJsonResponseFrentePredioCoop
                objeto.JQGridJsonResponseFrentePredioCoop(Convert.ToInt32(dt.Tables(0).Rows(0)("PageCount")), Convert.ToInt32(dt.Tables(0).Rows(0)("CurrentPage")), Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")), coopsfpc)
                Return objeto

            End Using
        End Using
    End Function

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCoopsRecProc(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pasocob As String, pfidx As Integer, pnomcoop As String, pnomcalle As String, accionx As String) As JQGridJsonResponseCoopsRec
        Return GetCoopsRecProcJson(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pasocob, pfidx, pnomcoop, pnomcalle, accionx)
    End Function

    Private Function GetCoopsRecProcJson(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pasocob As String, pfidx As Integer, pnomcoop As String, pnomcalle As String, accionx As String) As JQGridJsonResponseCoopsRec
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
            Using cmd As New NpgsqlCommand("sp_coops_gral", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pCurrentPage)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSortOrder)
                cmd.Parameters.AddWithValue("@pasocob", pasocob)
                cmd.Parameters.AddWithValue("@pfidx", pfidx)
                cmd.Parameters.AddWithValue("@pnomcoop", pnomcoop)
                cmd.Parameters.AddWithValue("@pnomcalle", pnomcalle)
                cmd.Parameters.AddWithValue("@accionx", accionx)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim coopfpocs = New List(Of clsFrentePredioObraCoop)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim coopfpoc As clsFrentePredioObraCoop = New clsFrentePredioObraCoop()
                        coopfpoc.fid = ValidarDBNull(row.Item("fidr"), "entero")
                        coopfpoc.pid = ValidarDBNull(row.Item("pidr"), "entero")
                        coopfpoc.oid = ValidarDBNull(row.Item("oidr"), "entero")
                        coopfpoc.cid = ValidarDBNull(row.Item("cidr"), "entero")
                        coopfpoc.cooperador = ValidarDBNull(row.Item("cooperadorr"), "cadena")
                        coopfpoc.nomficha = ValidarDBNull(row.Item("mnomfichar"), "cadena")
                        coopfpoc.mtsfrente = ValidarDBNull(row.Item("mts_frenter"), "real")
                        coopfpoc.prid = ValidarDBNull(row.Item("pridr"), "entero")
                        coopfpoc.costomtolineal = ValidarDBNull(row.Item("costo_mto_linealr"), "real")
                        coopfpoc.costototalobra = ValidarDBNull(row.Item("costo_total_obrar"), "real")
                        coopfpoc.nomprog = ValidarDBNull(row.Item("nomprogr"), "cadena")
                        coopfpoc.progmun = ValidarDBNull(row.Item("progmunr"), "entero")
                        coopfpoc.progcoop = ValidarDBNull(row.Item("progcoopr"), "entero")
                        coopfpoc.progdescrip = ValidarDBNull(row.Item("progdescripr"), "cadena")
                        coopfpoc.nooficial = ValidarDBNull(row.Item("nooficialr"), "cadena")
                        coopfpoc.ctapredial = ValidarDBNull(row.Item("ctapredialr"), "cadena")
                        coopfpoc.r20 = ValidarDBNull(row.Item("r20r"), "cadena")
                        coopfpoc.cup = ValidarDBNull(row.Item("cupr"), "cadena")
                        coopfpoc.ctaimuvi = ValidarDBNull(row.Item("ctaimuvir"), "cadena")
                        coopfpoc.sapal = ValidarDBNull(row.Item("sapalr"), "cadena")
                        coopfpoc.tipopredio = ValidarDBNull(row.Item("tipopredior"), "entero")
                        coopfpoc.usosuelo = ValidarDBNull(row.Item("uso_suelor"), "cadena")
                        coopfpoc.adeudo = ValidarDBNull(row.Item("adeudor"), "real")
                        coopfpoc.sumpagos = ValidarDBNull(row.Item("sum_pagosr"), "real")
                        coopfpoc.saldoparcial = ValidarDBNull(row.Item("saldo_parcialr"), "real")
                        coopfpoc.fecrec = ValidarDBNull(row.Item("fec_recr"), "fecha")
                        coopfpoc.fecinipag = ValidarDBNull(row.Item("fec_ini_pagr"), "fecha")
                        coopfpoc.nopagos = ValidarDBNull(row.Item("nopagosr"), "entero")
                        coopfpoc.fecproc = ValidarDBNull(row.Item("fec_procesor"), "fecha")
                        coopfpoc.feccob = ValidarDBNull(row.Item("fec_cobr"), "fecha")
                        coopfpoc.fecpav = ValidarDBNull(row.Item("fec_pavr"), "fecha")
                        coopfpoc.fecpub1 = ValidarDBNull(row.Item("fec_pub_1r"), "fecha")
                        coopfpoc.fecpub2 = ValidarDBNull(row.Item("fec_pub_2r"), "fecha")
                        coopfpoc.fecavisocong = ValidarDBNull(row.Item("fec_aviso_congr"), "fecha")
                        coopfpoc.statusobra = ValidarDBNull(row.Item("status_obrar"), "cadena")
                        coopfpoc.factoract = ValidarDBNull(row.Item("factor_actr"), "real")
                        coopfpoc.periodoact = ValidarDBNull(row.Item("periodo_actr"), "cadena")
                        coopfpoc.saldopagar = ValidarDBNull(row.Item("saldo_pagarr"), "real")
                        coopfpoc.calle = ValidarDBNull(row.Item("caller"), "cadena")
                        coopfpoc.colonia = ValidarDBNull(row.Item("coloniar"), "cadena")
                        coopfpoc.tramo = ValidarDBNull(row.Item("tramor"), "cadena")
                        coopfpocs.Add(coopfpoc)
                    Next row

                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseCoopsRec = New JQGridJsonResponseCoopsRec
                objeto.JQGridJsonResponseCoopsRec(pagecount, currentpage, recordcount, coopfpocs)
                Return objeto
            End Using
        End Using
    End Function

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCoopsCob(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pasocob As String, pfidx As Integer, pnomcoop As String, pnomcalle As String, accionx As String) As JQGridJsonResponseCoopsRec
        Return GetCoopsCobJson(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pasocob, pfidx, pnomcoop, pnomcalle, accionx)
    End Function

    Private Function GetCoopsCobJson(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pasocob As String, pfidx As Integer, pnomcoop As String, pnomcalle As String, accionx As String) As JQGridJsonResponseCoopsRec
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
            Using cmd As New NpgsqlCommand("sp_coops_gral2", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pCurrentPage)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSortOrder)
                cmd.Parameters.AddWithValue("@pasocob", pasocob)
                cmd.Parameters.AddWithValue("@pfidx", pfidx)
                cmd.Parameters.AddWithValue("@pnomcoop", pnomcoop)
                cmd.Parameters.AddWithValue("@pnomcalle", pnomcalle)
                cmd.Parameters.AddWithValue("@accionx", accionx)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim coopfpocs = New List(Of clsFrentePredioObraCoop)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim coopfpoc As clsFrentePredioObraCoop = New clsFrentePredioObraCoop()
                        coopfpoc.fid = ValidarDBNull(row.Item("fidr"), "entero")
                        coopfpoc.pid = ValidarDBNull(row.Item("pidr"), "entero")
                        coopfpoc.oid = ValidarDBNull(row.Item("oidr"), "entero")
                        coopfpoc.cid = ValidarDBNull(row.Item("cidr"), "entero")
                        coopfpoc.cooperador = ValidarDBNull(row.Item("cooperadorr"), "cadena")
                        coopfpoc.nomficha = ValidarDBNull(row.Item("mnomfichar"), "cadena")
                        coopfpoc.mtsfrente = ValidarDBNull(row.Item("mts_frenter"), "real")
                        coopfpoc.prid = ValidarDBNull(row.Item("pridr"), "entero")
                        coopfpoc.costomtolineal = ValidarDBNull(row.Item("costo_mto_linealr"), "real")
                        coopfpoc.costototalobra = ValidarDBNull(row.Item("costo_total_obrar"), "real")
                        coopfpoc.nomprog = ValidarDBNull(row.Item("nomprogr"), "cadena")
                        coopfpoc.progmun = ValidarDBNull(row.Item("progmunr"), "entero")
                        coopfpoc.progcoop = ValidarDBNull(row.Item("progcoopr"), "entero")
                        coopfpoc.progdescrip = ValidarDBNull(row.Item("progdescripr"), "cadena")
                        coopfpoc.nooficial = ValidarDBNull(row.Item("nooficialr"), "cadena")
                        coopfpoc.ctapredial = ValidarDBNull(row.Item("ctapredialr"), "cadena")
                        coopfpoc.r20 = ValidarDBNull(row.Item("r20r"), "cadena")
                        coopfpoc.cup = ValidarDBNull(row.Item("cupr"), "cadena")
                        coopfpoc.ctaimuvi = ValidarDBNull(row.Item("ctaimuvir"), "cadena")
                        coopfpoc.sapal = ValidarDBNull(row.Item("sapalr"), "cadena")
                        coopfpoc.tipopredio = ValidarDBNull(row.Item("tipopredior"), "entero")
                        coopfpoc.usosuelo = ValidarDBNull(row.Item("uso_suelor"), "cadena")
                        coopfpoc.adeudo = ValidarDBNull(row.Item("adeudor"), "real")
                        coopfpoc.sumpagos = ValidarDBNull(row.Item("sum_pagosr"), "real")
                        coopfpoc.saldoparcial = ValidarDBNull(row.Item("saldo_parcialr"), "real")
                        coopfpoc.fecrec = ValidarDBNull(row.Item("fec_recr"), "fecha")
                        coopfpoc.fecinipag = ValidarDBNull(row.Item("fec_ini_pagr"), "fecha")
                        coopfpoc.nopagos = ValidarDBNull(row.Item("nopagosr"), "entero")
                        coopfpoc.fecproc = ValidarDBNull(row.Item("fec_procesor"), "fecha")
                        coopfpoc.feccob = ValidarDBNull(row.Item("fec_cobr"), "fecha")
                        coopfpoc.fecpav = ValidarDBNull(row.Item("fec_pavr"), "fecha")
                        coopfpoc.fecpub1 = ValidarDBNull(row.Item("fec_pub_1r"), "fecha")
                        coopfpoc.fecpub2 = ValidarDBNull(row.Item("fec_pub_2r"), "fecha")
                        coopfpoc.fecavisocong = ValidarDBNull(row.Item("fec_aviso_congr"), "fecha")
                        coopfpoc.statusobra = ValidarDBNull(row.Item("status_obrar"), "cadena")
                        coopfpoc.factoract = ValidarDBNull(row.Item("factor_actr"), "real")
                        coopfpoc.periodoact = ValidarDBNull(row.Item("periodo_actr"), "cadena")
                        coopfpoc.saldopagar = ValidarDBNull(row.Item("saldo_pagarr"), "real")
                        coopfpoc.calle = ValidarDBNull(row.Item("caller"), "cadena")
                        coopfpoc.colonia = ValidarDBNull(row.Item("coloniar"), "cadena")
                        coopfpoc.tramo = ValidarDBNull(row.Item("tramor"), "cadena")
                        coopfpoc.callenotif = ValidarDBNull(row.Item("callenotifr"), "cadena")
                        coopfpoc.colnotif = ValidarDBNull(row.Item("colnotifr"), "cadena")
                        coopfpoc.nooficnotif = ValidarDBNull(row.Item("nooficnotifr"), "cadena")
                        coopfpocs.Add(coopfpoc)
                    Next row

                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseCoopsRec = New JQGridJsonResponseCoopsRec
                objeto.JQGridJsonResponseCoopsRec(pagecount, currentpage, recordcount, coopfpocs)
                Return objeto
            End Using
        End Using
    End Function

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetcoopPAE(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, fidx As Integer, accionx As String) As JQGridJsonResponsefpocPAE
        Return GetCoopsPAEJson(pPageSize, pCurrentPage, pSortColumn, pSortOrder, fidx, accionx)
    End Function

    Private Function GetCoopsPAEJson(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pfidx As Integer, accionx As String) As JQGridJsonResponsefpocPAE
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
            Using cmd As New NpgsqlCommand("sp_fpocq", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pCurrentPage)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSortOrder)
                cmd.Parameters.AddWithValue("@fidx", pfidx)
                cmd.Parameters.AddWithValue("@accionx", accionx)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim fpocPAEs = New List(Of clsFrentePAE)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim fpocPAE As clsFrentePAE = New clsFrentePAE()
                        fpocPAE.idpasopae = ValidarDBNull(row.Item("idpasopaer"), "entero")
                        fpocPAE.fid = ValidarDBNull(row.Item("fidr"), "entero")
                        fpocPAE.fecimpdcto = ValidarDBNull(row.Item("fec_imp_dctor"), "fecha")
                        fpocPAE.fecentdcto = ValidarDBNull(row.Item("fec_ent_dctor"), "fecha")
                        fpocPAE.fecnotif = ValidarDBNull(row.Item("fec_notifr"), "fecha")
                        fpocPAE.ministro = ValidarDBNull(row.Item("ministror"), "entero")
                        fpocPAE.nomministro = ValidarDBNull(row.Item("nomministror"), "cadena")
                        fpocPAE.obv = ValidarDBNull(row.Item("obvr"), "cadena")
                        fpocPAE.evidencia = ValidarDBNull(row.Item("evidenciar"), "cadena")
                        fpocPAE.estatus = ValidarDBNull(row.Item("estatusr"), "entero")
                        fpocPAE.horanotif = ValidarDBNull(row.Item("hora_notifr"), "hora")
                        fpocPAE.suerteprinc = ValidarDBNull(row.Item("suerte_princr"), "real")
                        fpocPAE.saldoparcial = ValidarDBNull(row.Item("saldo_parcialr"), "real")
                        fpocPAE.factoract = ValidarDBNull(row.Item("factoractr"), "real")
                        fpocPAE.sumapagos = ValidarDBNull(row.Item("suma_pagosr"), "real")
                        fpocPAE.nombrecoop = ValidarDBNull(row.Item("nombre_coopr"), "cadena")
                        fpocPAE.dirfirma = ValidarDBNull(row.Item("dirfirmar"), "entero")
                        fpocPAE.nomdirector = ValidarDBNull(row.Item("nomdirectorr"), "cadena")
                        fpocPAE.archivofirma = ValidarDBNull(row.Item("archivofirmarr"), "cadena")
                        fpocPAE.callenotif = ValidarDBNull(row.Item("callenotifr"), "cadena")
                        fpocPAE.colonianotif = ValidarDBNull(row.Item("colonianotifr"), "cadena")
                        fpocPAE.numnotif = ValidarDBNull(row.Item("numnotifr"), "cadena")
                        fpocPAEs.Add(fpocPAE)
                    Next row

                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponsefpocPAE = New JQGridJsonResponsefpocPAE
                objeto.JQGridJsonResponsefpocPAE(pagecount, currentpage, recordcount, fpocPAEs)
                Return objeto
            End Using
        End Using
    End Function

    'Webservice utilizado para relacionar toda la situación financiera por frente
    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_vwcoops_4(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, idusu As Integer, pSortOrder As String, obr_clv_int As Integer, accion As Integer) As JQGridJsonResponse_vw_coops_4
        Return Get_vwcoops_4Json(pPageSize, pCurrentPage, pSortColumn, pSortOrder, idusu, obr_clv_int, accion)

    End Function

    Private Function Get_vwcoops_4Json(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, idusu As Integer, obr_clv_int As Integer, accion As Integer) As JQGridJsonResponse_vw_coops_4
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
            Using cmd As New NpgsqlCommand("public2.sp_coops_vwcoop4", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@idusu", idusu)
                cmd.Parameters.AddWithValue("@obr_clv_int", obr_clv_int)
                cmd.Parameters.AddWithValue("@accion", accion)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim vw_coops_4_s = New List(Of cls_vwcoops_4)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim vw_coops_4 As cls_vwcoops_4 = New cls_vwcoops_4()
                        vw_coops_4.fid = ValidarDBNull(row.Item("out_fid"), "entero")
                        vw_coops_4.geom_frente = ValidarDBNull(row.Item("out_geom_frente"), "cadena")
                        vw_coops_4.mts_frente = ValidarDBNull(row.Item("out_mts_frente"), "real")
                        vw_coops_4.cid = ValidarDBNull(row.Item("out_cid"), "entero")
                        vw_coops_4.coopid = ValidarDBNull(row.Item("out_coopid"), "cadena")
                        vw_coops_4.pid = ValidarDBNull(row.Item("out_pid"), "entero")
                        vw_coops_4.oid = ValidarDBNull(row.Item("out_oid"), "entero")
                        vw_coops_4.obs_grales = ValidarDBNull(row.Item("out_obs_grales"), "cadena")
                        vw_coops_4.obra_sifidoc = ValidarDBNull(row.Item("out_obra_sifidoc"), "cadena")
                        vw_coops_4.gid = ValidarDBNull(row.Item("out_gid"), "entero")
                        vw_coops_4.feccre_frente = ValidarDBNull(row.Item("out_feccre_frente"), "fecha")
                        vw_coops_4.fecmod_frente = ValidarDBNull(row.Item("out_fecmod_frente"), "fecha")
                        vw_coops_4.usucre_frente = ValidarDBNull(row.Item("out_usucre_frente"), "cadena")
                        vw_coops_4.usumod_frente = ValidarDBNull(row.Item("out_usumod_frente"), "cadena")
                        vw_coops_4.prid = ValidarDBNull(row.Item("out_prid"), "entero")
                        vw_coops_4.inc = ValidarDBNull(row.Item("out_inc"), "real")
                        vw_coops_4.did = ValidarDBNull(row.Item("out_did"), "entero")
                        vw_coops_4.factor_act_pago = ValidarDBNull(row.Item("out_factor_act_pago"), "real")
                        vw_coops_4.obr_clv_int = ValidarDBNull(row.Item("out_obr_clv_int"), "entero")
                        vw_coops_4.coo_clv2 = ValidarDBNull(row.Item("out_coo_clv2"), "entero")
                        vw_coops_4.activo = ValidarDBNull(row.Item("out_activo"), "entero")
                        vw_coops_4.capital = ValidarDBNull(row.Item("out_capital"), "real")
                        vw_coops_4.midcoop = ValidarDBNull(row.Item("out_midcoop"), "entero")
                        vw_coops_4.mapellidop = ValidarDBNull(row.Item("out_mapellidop"), "cadena")
                        vw_coops_4.mapellidom = ValidarDBNull(row.Item("out_mapellidom"), "cadena")
                        vw_coops_4.mnombres = ValidarDBNull(row.Item("out_mnombres"), "cadena")
                        vw_coops_4.mcallecoop = ValidarDBNull(row.Item("out_mcallecoop"), "cadena")
                        vw_coops_4.mcolcoop = ValidarDBNull(row.Item("out_mcolcoop"), "cadena")
                        vw_coops_4.mnooficial_ext = ValidarDBNull(row.Item("out_mnooficial_ext"), "cadena")
                        vw_coops_4.mnooficial_int = ValidarDBNull(row.Item("out_mnooficial_int"), "cadena")
                        vw_coops_4.mtelcoop = ValidarDBNull(row.Item("out_mtelcoop"), "cadena")
                        vw_coops_4.mnomficha = ValidarDBNull(row.Item("out_mnomficha"), "cadena")
                        vw_coops_4.mestado = ValidarDBNull(row.Item("out_mestado"), "cadena")
                        vw_coops_4.mpais = ValidarDBNull(row.Item("out_mpais"), "cadena")
                        vw_coops_4.mcorreo = ValidarDBNull(row.Item("out_mcorreo"), "cadena")
                        vw_coops_4.usrcre_coop = ValidarDBNull(row.Item("out_usrcre_coop"), "cadena")
                        vw_coops_4.feccre_coop = ValidarDBNull(row.Item("out_feccre_coop"), "fecha")
                        vw_coops_4.usrmod_coop = ValidarDBNull(row.Item("out_usrmod_coop"), "cadena")
                        vw_coops_4.fecmod_coop = ValidarDBNull(row.Item("out_fecmod_coop"), "fecha")
                        vw_coops_4.mcurp = ValidarDBNull(row.Item("out_mcurp"), "cadena")
                        vw_coops_4.mrelacionpredio = ValidarDBNull(row.Item("out_mrelacionpredio"), "entero")
                        vw_coops_4.ine = ValidarDBNull(row.Item("out_ine"), "cadena")
                        vw_coops_4.doc_identific = ValidarDBNull(row.Item("out_doc_identific"), "cadena")
                        vw_coops_4.obr_clv = ValidarDBNull(row.Item("out_obr_clv"), "cadena")
                        vw_coops_4.obr_mts = ValidarDBNull(row.Item("out_obr_mts"), "real")
                        vw_coops_4.obr_cost = ValidarDBNull(row.Item("out_obr_cost"), "real")
                        vw_coops_4.obr_int = ValidarDBNull(row.Item("out_obr_int"), "entero")
                        vw_coops_4.obr_fecha = ValidarDBNull(row.Item("out_obr_fecha"), "fecha")
                        vw_coops_4.obr_cost_total = ValidarDBNull(row.Item("out_obr_cost_total"), "real")
                        vw_coops_4.obr_inc = ValidarDBNull(row.Item("out_obr_inc"), "real")
                        vw_coops_4.obr_fecinip = ValidarDBNull(row.Item("out_obr_fecinip"), "fecha")
                        vw_coops_4.obr_fecvenp = ValidarDBNull(row.Item("out_obr_fecvenp"), "fecha")
                        vw_coops_4.obr_npago = ValidarDBNull(row.Item("out_obr_npago"), "entero")
                        vw_coops_4.obr_opergob = ValidarDBNull(row.Item("out_obr_opergob"), "cadena")
                        vw_coops_4.obr_fec_ini_proc = ValidarDBNull(row.Item("out_obr_fec_ini_proc"), "fecha")
                        vw_coops_4.obr_fec_ini_cob = ValidarDBNull(row.Item("out_obr_fec_ini_cob"), "fecha")
                        vw_coops_4.obr_clv_int_obra = ValidarDBNull(row.Item("out_obr_clv_int_obra"), "entero")
                        vw_coops_4.obr_prog2 = ValidarDBNull(row.Item("out_obr_prog2"), "entero")
                        vw_coops_4.nomprog = ValidarDBNull(row.Item("out_nomprog"), "cadena")
                        vw_coops_4.progdescrip = ValidarDBNull(row.Item("out_progdescrip"), "cadena")
                        vw_coops_4.obr_clv2 = ValidarDBNull(row.Item("out_obr_clv2"), "cadena")
                        vw_coops_4.obr_status = ValidarDBNull(row.Item("out_obr_status"), "entero")
                        vw_coops_4.cestatus = ValidarDBNull(row.Item("out_cestatus"), "cadena")
                        vw_coops_4.oid_obra = ValidarDBNull(row.Item("out_oid_obra"), "entero")
                        vw_coops_4.obr_fec_canc = ValidarDBNull(row.Item("out_obr_fec_canc"), "fecha")
                        vw_coops_4.obr_sis = ValidarDBNull(row.Item("out_obr_sis"), "cadena")
                        vw_coops_4.col_clv2 = ValidarDBNull(row.Item("out_col_clv2"), "cadena")
                        vw_coops_4.no_contrato = ValidarDBNull(row.Item("out_no_contrato"), "cadena")
                        vw_coops_4.gastos_admvos = ValidarDBNull(row.Item("out_gastos_admvos"), "real")
                        vw_coops_4.obr_fec_pub1 = ValidarDBNull(row.Item("out_obr_fec_pub1"), "fecha")
                        vw_coops_4.obr_fec_pub2 = ValidarDBNull(row.Item("out_obr_fec_pub2"), "fecha")
                        vw_coops_4.evid_pub1 = ValidarDBNull(row.Item("out_evid_pub1"), "cadena")
                        vw_coops_4.evid_pub2 = ValidarDBNull(row.Item("out_evid_pub2"), "cadena")
                        vw_coops_4.evid_obra_proc = ValidarDBNull(row.Item("out_evid_obra_proc"), "cadena")
                        vw_coops_4.evid_termino_obra = ValidarDBNull(row.Item("out_evid_termino_obra"), "cadena")
                        vw_coops_4.obr_nat = ValidarDBNull(row.Item("out_obr_nat"), "cadena")
                        vw_coops_4.pid_predio = ValidarDBNull(row.Item("out_pid_predio"), "entero")
                        vw_coops_4.objectid = ValidarDBNull(row.Item("out_objectid"), "cadena")
                        vw_coops_4.gid_server = ValidarDBNull(row.Item("out_gid_server"), "real")
                        vw_coops_4.cup = ValidarDBNull(row.Item("out_cup"), "cadena")
                        vw_coops_4.feccre_pred = ValidarDBNull(row.Item("out_feccre_pred"), "fecha")
                        vw_coops_4.fecmod_pred = ValidarDBNull(row.Item("out_fecmod_pred"), "fecha")
                        vw_coops_4.tipo = ValidarDBNull(row.Item("out_tipo"), "cadena")
                        vw_coops_4.tipopredio = ValidarDBNull(row.Item("out_tipopredio"), "real")
                        vw_coops_4.ctapredial = ValidarDBNull(row.Item("out_ctapredial"), "cadena")
                        vw_coops_4.ctaimuvi = ValidarDBNull(row.Item("out_ctaimuvi"), "cadena")
                        vw_coops_4.observacio = ValidarDBNull(row.Item("out_observacio"), "cadena")
                        vw_coops_4.shape_area = ValidarDBNull(row.Item("out_shape_area"), "real")
                        vw_coops_4.shape_len = ValidarDBNull(row.Item("out_shape_len"), "real")
                        vw_coops_4.geom_predio = ValidarDBNull(row.Item("out_geom_predio"), "cadena")
                        vw_coops_4.uso_predio = ValidarDBNull(row.Item("out_uso_predio"), "entero")
                        vw_coops_4.uso_suelo = ValidarDBNull(row.Item("out_uso_suelo"), "cadena")
                        vw_coops_4.r20 = ValidarDBNull(row.Item("out_r20"), "cadena")
                        vw_coops_4.nooficial = ValidarDBNull(row.Item("out_nooficial"), "cadena")
                        vw_coops_4.sapal = ValidarDBNull(row.Item("out_sapal"), "cadena")
                        vw_coops_4.usrcre_pred = ValidarDBNull(row.Item("out_usrcre_pred"), "entero")
                        vw_coops_4.usrmod_pred = ValidarDBNull(row.Item("out_usrmod_pred"), "entero")
                        vw_coops_4.num_escritura = ValidarDBNull(row.Item("out_num_escritura"), "cadena")
                        vw_coops_4.reg_escritura = ValidarDBNull(row.Item("out_reg_escritura"), "cadena")
                        vw_coops_4.folio_escritura = ValidarDBNull(row.Item("out_folio_escritura"), "cadena")
                        vw_coops_4.tomo_escritura = ValidarDBNull(row.Item("out_tomo_escritura"), "cadena")
                        vw_coops_4.doc_escritura = ValidarDBNull(row.Item("out_doc_escritura"), "cadena")
                        vw_coops_4.lote = ValidarDBNull(row.Item("out_lote"), "cadena")
                        vw_coops_4.mzna = ValidarDBNull(row.Item("out_mzna"), "cadena")
                        vw_coops_4.saldo_sin = ValidarDBNull(row.Item("out_saldo_sin"), "real")
                        vw_coops_4.saldo_sin_act = ValidarDBNull(row.Item("out_saldo_sin_act"), "real")
                        vw_coops_4.pagos = ValidarDBNull(row.Item("out_pagos"), "real")
                        vw_coops_4.recargos = ValidarDBNull(row.Item("out_recargos"), "real")
                        vw_coops_4.clv_inpc_ant = ValidarDBNull(row.Item("out_clv_inpc_ant"), "cadena")
                        vw_coops_4.clv_inpc_actual = ValidarDBNull(row.Item("out_clv_inpc_actual"), "cadena")
                        vw_coops_4.clv_inpc_actual_2 = ValidarDBNull(row.Item("out_clv_inpc_actual_2"), "cadena")
                        vw_coops_4.factor_act = ValidarDBNull(row.Item("out_factor_act"), "real")
                        vw_coops_4.monto_act = ValidarDBNull(row.Item("out_monto_act"), "real")
                        vw_coops_4.saldo = ValidarDBNull(row.Item("out_saldo"), "real")
                        vw_coops_4.calle = ValidarDBNull(row.Item("out_calle"), "cadena")
                        vw_coops_4.colonia = ValidarDBNull(row.Item("out_colonia"), "cadena")
                        vw_coops_4.limite1 = ValidarDBNull(row.Item("out_limite1"), "cadena")
                        vw_coops_4.limite2 = ValidarDBNull(row.Item("out_limite2"), "cadena")
                        vw_coops_4.tramo = ValidarDBNull(row.Item("out_tramo"), "cadena")
                        vw_coops_4.pae = ValidarDBNull(row.Item("out_pae"), "entero")
                        vw_coops_4.iddet = ValidarDBNull(row.Item("out_iddet"), "entero")
                        vw_coops_4.det_estatus = ValidarDBNull(row.Item("out_det_estatus"), "entero")
                        vw_coops_4.fec_imp_det = ValidarDBNull(row.Item("out_fec_imp_det"), "fecha")
                        vw_coops_4.fec_ent_det = ValidarDBNull(row.Item("out_fec_ent_det"), "fecha")
                        vw_coops_4.fec_notif_det = ValidarDBNull(row.Item("out_fec_notif_det"), "fecha")
                        vw_coops_4.hora_notif_det = ValidarDBNull(row.Item("out_hora_notif_det"), "hora")
                        vw_coops_4.idministro = ValidarDBNull(row.Item("out_idministro"), "entero")
                        vw_coops_4.musunombre = ValidarDBNull(row.Item("out_musunombre"), "cadena")
                        vw_coops_4.tipo_doc = ValidarDBNull(row.Item("out_tipo_doc"), "entero")
                        vw_coops_4.nom_doc = ValidarDBNull(row.Item("out_nom_doc"), "cadena")
                        vw_coops_4_s.Add(vw_coops_4)
                    Next row

                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponse_vw_coops_4 = New JQGridJsonResponse_vw_coops_4
                objeto.JQGridJsonResponse_vw_coops_4(pagecount, currentpage, recordcount, vw_coops_4_s)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function EditarCoopCV_all(campo As String, dato As String, obra_coop_s As String, idusu As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idcoopx As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public3.sp_actualiza_dato_CV_all", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@obra_coop_s_in", obra_coop_s)
                cmd.Parameters.AddWithValue("@idusu_in", idusu)
                cmd.Parameters.AddWithValue("@dato_in", dato)
                cmd.Parameters.AddWithValue("@campo_in", campo)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@NoError", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@DescError", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output



                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)


                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()

                con.Close()
            End Using
        End Using
        Try
            Return "Dato de cooperador de cobranza actualizado correctamente:"
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function


    <WebMethod(Description:="Retorna registro de cooperadores por obra")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetCoopsxObra_psql(obr_clv_int As Integer, coop_excluir As Integer, accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_coops_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@obr_clv_int_in", obr_clv_int)
                cmd.Parameters.AddWithValue("@coop_excluir_in", coop_excluir)
                cmd.Parameters.AddWithValue("@accion_in", accion)
                adapt.Fill(dt, "coops")
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

    <WebMethod(Description:="Retorna registro de cooperadores por obra")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetCoop_psql(fid As Integer, accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_coop_x_fid_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fid_in", fid)
                cmd.Parameters.AddWithValue("@accion_in", accion)
                adapt.Fill(dt, "coop_fid")
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