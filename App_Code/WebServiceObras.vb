Imports System.Data
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql


' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()>
<WebService(Namespace:="http://microsoft.com/webservices/")>
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Public Class WebServiceObras
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetObra_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponseObra
        Return GetObraJSon_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro)

    End Function

    Private Function GetObraJSon_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String) As JQGridJsonResponseObra
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Console.WriteLine("Prueba")




        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_obra_grid3", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim obras = New List(Of clsObra)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim obra As clsObra = New clsObra()
                        obra.oid = ValidarDBNull(row.Item("out_oid"), "entero")
                        obra.geom = ValidarDBNull(row.Item("out_geom"), "cadena")
                        obra.idsol = ValidarDBNull(row.Item("out_idsol"), "entero")
                        obra.tramo = ValidarDBNull(row.Item("out_tramo"), "cadena")
                        obra.sector = ValidarDBNull(row.Item("out_sector"), "entero")
                        obra.subsector = ValidarDBNull(row.Item("out_subsector"), "entero")
                        obra.cvecalle = ValidarDBNull(row.Item("out_cvecalle"), "entero")
                        obra.idpoligono = ValidarDBNull(row.Item("out_idpoligono"), "entero")
                        obra.calle = ValidarDBNull(row.Item("out_calle"), "cadena")
                        obra.colonia = ValidarDBNull(row.Item("out_colonia"), "cadena")
                        obra.id_implan = ValidarDBNull(row.Item("out_id_implan"), "entero")
                        obra.usrmod = ValidarDBNull(row.Item("out_usrmod"), "entero")
                        obra.fec_mod = ValidarDBNull(row.Item("out_fec_mod"), "fecha")
                        obra.obr_fec_pub1 = ValidarDBNull(row.Item("out_obr_fec_pub1"), "fecha")
                        obra.evid_pub1 = ValidarDBNull(row.Item("out_evid_pub1"), "cadena")
                        obra.obr_fec_pub2 = ValidarDBNull(row.Item("out_obr_fec_pub2"), "fecha")
                        obra.evid_pub2 = ValidarDBNull(row.Item("out_evid_pub2"), "cadena")
                        obra.col_clv2 = ValidarDBNull(row.Item("out_col_clv2"), "cadena")
                        obra.limite1 = ValidarDBNull(row.Item("out_limite1"), "cadena")
                        obra.limite2 = ValidarDBNull(row.Item("out_limite2"), "cadena")
                        obra.col_nom = ValidarDBNull(row.Item("out_col_nom"), "cadena")
                        obra.cestatus = ValidarDBNull(row.Item("out_cestatus"), "cadena")
                        obra.nomprog = ValidarDBNull(row.Item("out_nomprog"), "cadena")
                        obra.progmun = ValidarDBNull(row.Item("out_progmun"), "entero")
                        obra.progcoop = ValidarDBNull(row.Item("out_progcoop"), "entero")
                        obra.descrip_tipo_obr = ValidarDBNull(row.Item("out_descrip_tipo_obr"), "cadena")
                        obra.obr_clv = ValidarDBNull(row.Item("out_obr_clv"), "cadena")
                        obra.obr_mts = ValidarDBNull(row.Item("out_obr_mts"), "real")
                        obra.obr_cost = ValidarDBNull(row.Item("out_obr_cost"), "real")
                        obra.obr_int = ValidarDBNull(row.Item("out_obr_int"), "entero")
                        obra.obr_fecha = ValidarDBNull(row.Item("out_obr_fecha"), "fecha")
                        obra.obr_cost_total = ValidarDBNull(row.Item("out_obr_cost_total"), "real")
                        obra.obr_inc = ValidarDBNull(row.Item("out_obr_inc"), "real")
                        obra.obr_fecinip = ValidarDBNull(row.Item("out_obr_fecinip"), "fecha")
                        obra.obr_idtipo_recurso = ValidarDBNull(row.Item("out_obr_id_tipo_recurso"), "entero")
                        obra.obr_descrip_tipo_recurso = ValidarDBNull(row.Item("out_obr_descrip_tipo_recurso"), "cadena")
                        obra.obr_fecvenp = ValidarDBNull(row.Item("out_obr_fecvenp"), "fecha")
                        obra.obr_npago = ValidarDBNull(row.Item("out_obr_npago"), "entero")
                        obra.obr_opergob = ValidarDBNull(row.Item("out_obr_opergob"), "cadena")
                        obra.obr_fec_ini_proc = ValidarDBNull(row.Item("out_obr_fec_ini_proc"), "fecha")
                        obra.obr_idtipo_recurso = ValidarDBNull(row.Item("out_obr_id_tipo_recurso"), "entero")
                        obra.obr_descrip_tipo_recurso = ValidarDBNull(row.Item("out_obr_descrip_tipo_recurso"), "cadena")
                        obra.obr_fec_ini_cob = ValidarDBNull(row.Item("out_obr_fec_ini_cob"), "fecha")
                        obra.obr_clv_int = ValidarDBNull(row.Item("out_obr_clv_int"), "entero")
                        obra.obr_prog2 = ValidarDBNull(row.Item("out_obr_prog2"), "entero")
                        obra.obr_clv2 = ValidarDBNull(row.Item("out_obr_clv2"), "cadena")
                        obra.obr_sis = ValidarDBNull(row.Item("out_obr_sis"), "cadena")
                        obra.obr_status = ValidarDBNull(row.Item("out_obr_status"), "entero")
                        obra.obr_fec_can = ValidarDBNull(row.Item("out_obr_fec_can"), "fecha")
                        obra.no_contrato = ValidarDBNull(row.Item("out_obr_no_contrato"), "cadena")
                        obra.gastos_admvos = ValidarDBNull(row.Item("out_obr_gastos_admvos"), "real")
                        obra.evid_obra_proc = ValidarDBNull(row.Item("out_obr_evid_proc"), "cadena")
                        obra.evid_termino_obra = ValidarDBNull(row.Item("out_obr_evid_termino"), "cadena")
                        obra.obr_nat = ValidarDBNull(row.Item("out_obr_nat"), "cadena")
                        obras.Add(obra)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))

                Dim objeto As JQGridJsonResponseObra = New JQGridJsonResponseObra
                objeto.JQGridJsonResponseObra(pagecount, currentpage, recordcount, obras)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetObraProc_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponseObra
        Return GetObraProcJSon_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro)

    End Function

    Private Function GetObraProcJSon_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String) As JQGridJsonResponseObra
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer




        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_obra_proc_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim obras = New List(Of clsObra)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim obra As clsObra = New clsObra()
                        obra.oid = ValidarDBNull(row.Item("out_oid"), "entero")
                        obra.geom = ValidarDBNull(row.Item("out_geom"), "cadena")
                        obra.idsol = ValidarDBNull(row.Item("out_idsol"), "entero")
                        obra.tramo = ValidarDBNull(row.Item("out_tramo"), "cadena")
                        obra.sector = ValidarDBNull(row.Item("out_sector"), "entero")
                        obra.subsector = ValidarDBNull(row.Item("out_subsector"), "entero")
                        obra.cvecalle = ValidarDBNull(row.Item("out_cvecalle"), "entero")
                        obra.idpoligono = ValidarDBNull(row.Item("out_idpoligono"), "entero")
                        obra.calle = ValidarDBNull(row.Item("out_calle"), "cadena")
                        obra.colonia = ValidarDBNull(row.Item("out_colonia"), "cadena")
                        obra.id_implan = ValidarDBNull(row.Item("out_id_implan"), "entero")
                        obra.usrmod = ValidarDBNull(row.Item("out_usrmod"), "entero")
                        obra.fec_mod = ValidarDBNull(row.Item("out_fec_mod"), "fecha")
                        obra.obr_fec_pub1 = ValidarDBNull(row.Item("out_obr_fec_pub1"), "fecha")
                        obra.evid_pub1 = ValidarDBNull(row.Item("out_evid_pub1"), "cadena")
                        obra.obr_fec_pub2 = ValidarDBNull(row.Item("out_obr_fec_pub2"), "fecha")
                        obra.evid_pub2 = ValidarDBNull(row.Item("out_evid_pub2"), "cadena")
                        obra.col_clv2 = ValidarDBNull(row.Item("out_col_clv2"), "cadena")
                        obra.limite1 = ValidarDBNull(row.Item("out_limite1"), "cadena")
                        obra.limite2 = ValidarDBNull(row.Item("out_limite2"), "cadena")
                        obra.col_nom = ValidarDBNull(row.Item("out_col_nom"), "cadena")
                        obra.cestatus = ValidarDBNull(row.Item("out_cestatus"), "cadena")
                        obra.nomprog = ValidarDBNull(row.Item("out_nomprog"), "cadena")
                        obra.progmun = ValidarDBNull(row.Item("out_progmun"), "entero")
                        obra.progcoop = ValidarDBNull(row.Item("out_progcoop"), "entero")
                        obra.descrip_tipo_obr = ValidarDBNull(row.Item("out_descrip_tipo_obr"), "cadena")
                        obra.obr_clv = ValidarDBNull(row.Item("out_obr_clv"), "cadena")
                        obra.obr_mts = ValidarDBNull(row.Item("out_obr_mts"), "real")
                        obra.obr_cost = ValidarDBNull(row.Item("out_obr_cost"), "real")
                        obra.obr_int = ValidarDBNull(row.Item("out_obr_int"), "entero")
                        obra.obr_fecha = ValidarDBNull(row.Item("out_obr_fecha"), "fecha")
                        obra.obr_cost_total = ValidarDBNull(row.Item("out_obr_cost_total"), "real")
                        obra.obr_inc = ValidarDBNull(row.Item("out_obr_inc"), "real")
                        obra.obr_fecinip = ValidarDBNull(row.Item("out_obr_fecinip"), "fecha")
                        obra.obr_fecvenp = ValidarDBNull(row.Item("out_obr_fecvenp"), "fecha")
                        obra.obr_npago = ValidarDBNull(row.Item("out_obr_npago"), "entero")
                        obra.obr_opergob = ValidarDBNull(row.Item("out_obr_opergob"), "cadena")
                        obra.obr_fec_ini_proc = ValidarDBNull(row.Item("out_obr_fec_ini_proc"), "fecha")
                        obra.obr_idtipo_recurso = ValidarDBNull(row.Item("out_obr_id_tipo_recurso"), "entero")
                        obra.obr_descrip_tipo_recurso = ValidarDBNull(row.Item("out_obr_descrip_tipo_recurso"), "cadena")
                        obra.obr_fec_ini_cob = ValidarDBNull(row.Item("out_obr_fec_ini_cob"), "fecha")
                        obra.obr_clv_int = ValidarDBNull(row.Item("out_obr_clv_int"), "entero")
                        obra.obr_prog2 = ValidarDBNull(row.Item("out_obr_prog2"), "entero")
                        obra.obr_clv2 = ValidarDBNull(row.Item("out_obr_clv2"), "cadena")
                        obra.obr_sis = ValidarDBNull(row.Item("out_obr_sis"), "cadena")
                        obra.obr_status = ValidarDBNull(row.Item("out_obr_status"), "entero")
                        obra.obr_fec_can = ValidarDBNull(row.Item("out_obr_fec_can"), "fecha")
                        obra.no_contrato = ValidarDBNull(row.Item("out_obr_no_contrato"), "cadena")
                        obra.gastos_admvos = ValidarDBNull(row.Item("out_obr_gastos_admvos"), "real")
                        obra.evid_obra_proc = ValidarDBNull(row.Item("out_obr_evid_proc"), "cadena")
                        obra.evid_termino_obra = ValidarDBNull(row.Item("out_obr_evid_termino"), "cadena")
                        obra.obr_nat = ValidarDBNull(row.Item("out_obr_nat"), "cadena")
                        obras.Add(obra)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))

                Dim objeto As JQGridJsonResponseObra = New JQGridJsonResponseObra
                objeto.JQGridJsonResponseObra(pagecount, currentpage, recordcount, obras)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetObrasVencidasRec_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseObrasVencidasRec

        Return GetObrasVencidasRec(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetObrasVencidasRec(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseObrasVencidasRec
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
            Using cmd As New NpgsqlCommand("public2.sp_obras_venc_rec_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim obras_venc_rec = New List(Of clsObrasVencRec)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim obra_venc_rec As clsObrasVencRec = New clsObrasVencRec()
                        obra_venc_rec.num_coops = ValidarDBNull(row.Item("out_num_coops"), "entero")
                        obra_venc_rec.total_metros_obra = ValidarDBNull(row.Item("out_total_metros_obra"), "real")
                        obra_venc_rec.obr_costo = ValidarDBNull(row.Item("out_obr_costo"), "real")
                        obra_venc_rec.oid = ValidarDBNull(row.Item("out_oid"), "entero")
                        obra_venc_rec.calle = ValidarDBNull(row.Item("out_calle"), "cadena")
                        obra_venc_rec.colonia = ValidarDBNull(row.Item("out_colonia"), "cadena")
                        obra_venc_rec.tramo = ValidarDBNull(row.Item("out_tramo"), "cadena")
                        obra_venc_rec.obr_clv_int = ValidarDBNull(row.Item("out_obr_clv_int"), "entero")
                        obra_venc_rec.obr_clv = ValidarDBNull(row.Item("out_obr_clv"), "cadena")
                        obra_venc_rec.obr_opergob = ValidarDBNull(row.Item("out_obr_opergob"), "cadena")
                        obra_venc_rec.obr_prog2 = ValidarDBNull(row.Item("out_obr_prog2"), "entero")
                        obra_venc_rec.nomprog = ValidarDBNull(row.Item("out_nomprog"), "cadena")
                        obra_venc_rec.descrip_tipo_obr = ValidarDBNull(row.Item("out_descrip_tipo_obr"), "cadena")
                        obra_venc_rec.obr_status = ValidarDBNull(row.Item("out_obr_status"), "entero")
                        obra_venc_rec.cestatus = ValidarDBNull(row.Item("out_cestatus"), "cadena")
                        obra_venc_rec.obr_fecinip = ValidarDBNull(row.Item("out_obr_fecinip"), "cadena")
                        obra_venc_rec.obr_fecvenp = ValidarDBNull(row.Item("out_obr_fecvenp"), "cadena")
                        obra_venc_rec.obr_fec_ini_proc = ValidarDBNull(row.Item("out_fec_ini_proc"), "cadena")
                        obra_venc_rec.obr_fec_ini_cob = ValidarDBNull(row.Item("out_fec_ini_cob"), "cadena")
                        obra_venc_rec.plazo_rec = ValidarDBNull(row.Item("out_plazo_rec"), "entero")
                        obra_venc_rec.num_meses_a_fecact = ValidarDBNull(row.Item("out_num_meses_a_fecact"), "entero")
                        obra_venc_rec.incremento_frente = ValidarDBNull(row.Item("out_incremento_frente"), "real")
                        obra_venc_rec.capital_inicial_frente_sin_inc = ValidarDBNull(row.Item("out_capital_inicial_frente_sin_inc"), "real")
                        obra_venc_rec.capital_inicial_frente_con_inc = ValidarDBNull(row.Item("out_capital_inicial_frente_con_inc"), "real")
                        obra_venc_rec.capital_pagado_frente = ValidarDBNull(row.Item("out_capital_pagado_frente"), "real")
                        obra_venc_rec.descto_capital_frente = ValidarDBNull(row.Item("out_descto_capital_frente"), "real")
                        obra_venc_rec.ayudas_sociales_frente = ValidarDBNull(row.Item("out_ayudas_sociales_frente"), "real")
                        obra_venc_rec.total_recargos_frente = ValidarDBNull(row.Item("out_total_recargos_frente"), "real")
                        obra_venc_rec.cargos_pagados_frente = ValidarDBNull(row.Item("out_cargos_pagados_frente"), "real")
                        obra_venc_rec.descto_recargos_frente = ValidarDBNull(row.Item("out_descto_recargos_frente"), "real")
                        obra_venc_rec.saldo_capital_frente = ValidarDBNull(row.Item("out_saldo_capital_frente"), "real")
                        obra_venc_rec.saldo_recargos_frente = ValidarDBNull(row.Item("out_saldo_recargos_frente"), "real")
                        obra_venc_rec.saldo_gral_frente = ValidarDBNull(row.Item("out_saldo_gral_frente"), "real")
                        obra_venc_rec.saldo_sin = ValidarDBNull(row.Item("out_saldo_sin"), "real")
                        obra_venc_rec.saldo_con = ValidarDBNull(row.Item("out_saldo_con"), "real")
                        obra_venc_rec.avance_pago_con_inc = ValidarDBNull(row.Item("out_avance_pago_con_inc"), "real")
                        obra_venc_rec.avance_pago_sin_inc = ValidarDBNull(row.Item("out_avance_pago_sin_inc"), "real")
                        obra_venc_rec.id_act_costo_obra = ValidarDBNull(row.Item("out_id_act_costo_obra"), "entero")
                        obra_venc_rec.idcomite = ValidarDBNull(row.Item("out_idcomite"), "entero")
                        obra_venc_rec.idacuerdo = ValidarDBNull(row.Item("out_idacuerdo"), "entero")
                        obra_venc_rec.fec_cap_aprob_comite = ValidarDBNull(row.Item("out_fec_cap_aprob_comite"), "fecha")
                        obra_venc_rec.idusu_aprob_comite = ValidarDBNull(row.Item("out_idusu_aprob_comite"), "entero")
                        obra_venc_rec.costo_mto_nuevo = ValidarDBNull(row.Item("out_costo_mto_nuevo"), "real")
                        obra_venc_rec.fec_cap_costo_mto = ValidarDBNull(row.Item("out_fec_cap_costo_mto"), "fecha")
                        obra_venc_rec.idusu_cap_costo_mto = ValidarDBNull(row.Item("out_idusu_cap_costo_mto"), "entero")
                        obra_venc_rec.idasamblea = ValidarDBNull(row.Item("out_idasamblea"), "entero")
                        obra_venc_rec.num_coops_act = ValidarDBNull(row.Item("out_num_coops_act"), "entero")
                        obra_venc_rec.fec_comite = ValidarDBNull(row.Item("out_fec_comite"), "fecha")
                        obra_venc_rec.acta_comite = ValidarDBNull(row.Item("out_acta_comite"), "cadena")
                        obra_venc_rec.num_sesion = ValidarDBNull(row.Item("out_num_sesion"), "entero")
                        obra_venc_rec.folio_acuerdo = ValidarDBNull(row.Item("out_folio_acuerdo"), "cadena")
                        obra_venc_rec.presup_nuevo = ValidarDBNull(row.Item("out_presup_nuevo"), "cadena")
                        obras_venc_rec.Add(obra_venc_rec)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseObrasVencidasRec = New JQGridJsonResponseObrasVencidasRec
                objeto.JQGridJsonResponseObrasVencidasRec(pagecount, currentpage, recordcount, obras_venc_rec)
                Return objeto
            End Using
        End Using
    End Function

    <WebMethod(Description:="Actualizar el registro del documento")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GuardarActCostoObra(objActCostoObra As clsObrasVencRec) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idActCostoObra As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_proc_act_costo_obra", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@id_act_cosot_obra_in", objActCostoObra.id_act_costo_obra)
                cmd.Parameters.AddWithValue("@obr_clv_s_in", objActCostoObra.obr_clv)
                cmd.Parameters.AddWithValue("@obr_clv_int_in", objActCostoObra.obr_clv_int)
                cmd.Parameters.AddWithValue("@oid_in", objActCostoObra.oid)
                cmd.Parameters.AddWithValue("@idcomite_in", objActCostoObra.idcomite)
                cmd.Parameters.AddWithValue("@idacuerdo_in", objActCostoObra.idacuerdo)
                cmd.Parameters.AddWithValue("@fec_cap_aprob_comite_in", objActCostoObra.fec_cap_aprob_comite)
                cmd.Parameters.AddWithValue("@idusu_aprob_comite_in", objActCostoObra.idusu_aprob_comite)
                cmd.Parameters.AddWithValue("@costo_mto_nuevo_in", objActCostoObra.costo_mto_nuevo)
                cmd.Parameters.AddWithValue("@fec_cap_costo_mto_in", objActCostoObra.fec_cap_costo_mto)
                cmd.Parameters.AddWithValue("@idusu_cap_costo_mto_in", objActCostoObra.idusu_cap_costo_mto)
                cmd.Parameters.AddWithValue("@idasamblea_in", objActCostoObra.idasamblea)
                cmd.Parameters.AddWithValue("@num_coops_act_in", objActCostoObra.num_coops_act)
                cmd.Parameters.AddWithValue("@presup_nuevo_in", objActCostoObra.presup_nuevo)
                cmd.Parameters.AddWithValue("@accionx", objActCostoObra.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridActCostoObra As NpgsqlParameter = New NpgsqlParameter("@idact_costo_obra_r", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridActCostoObra.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridActCostoObra)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idActCostoObra = cmd.Parameters("@idact_costo_obra_r").Value()
                con.Close()
            End Using
        End Using
        Try
            Return messerror
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function


    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetObra_rep1(obr_clv_int_txt As String) As JQGridJsonResponseObra
        Return GetObraJSon_rep1(obr_clv_int_txt)

    End Function

    Private Function GetObraJSon_rep1(obr_clv_int_txt As String) As JQGridJsonResponseObra
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_rep1_xls", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@obr_clv_int_txt", obr_clv_int_txt)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim obras = New List(Of clsObra)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim obra As clsObra = New clsObra()
                        obra.oid = ValidarDBNull(row.Item("out_oid"), "entero")
                        obra.geom = ValidarDBNull(row.Item("out_geom"), "cadena")
                        obra.idsol = ValidarDBNull(row.Item("out_idsol"), "entero")
                        obra.tramo = ValidarDBNull(row.Item("out_tramo"), "cadena")
                        obra.sector = ValidarDBNull(row.Item("out_sector"), "entero")
                        obra.subsector = ValidarDBNull(row.Item("out_subsector"), "entero")
                        obra.cvecalle = ValidarDBNull(row.Item("out_cvecalle"), "entero")
                        obra.idpoligono = ValidarDBNull(row.Item("out_idpoligono"), "entero")
                        obra.calle = ValidarDBNull(row.Item("out_calle"), "cadena")
                        obra.colonia = ValidarDBNull(row.Item("out_colonia"), "cadena")
                        obra.id_implan = ValidarDBNull(row.Item("out_id_implan"), "entero")
                        obra.usrmod = ValidarDBNull(row.Item("out_usrmod"), "entero")
                        obra.fec_mod = ValidarDBNull(row.Item("out_fec_mod"), "fecha")
                        obra.obr_fec_pub1 = ValidarDBNull(row.Item("out_obr_fec_pub1"), "fecha")
                        obra.evid_pub1 = ValidarDBNull(row.Item("out_evid_pub1"), "cadena")
                        obra.obr_fec_pub2 = ValidarDBNull(row.Item("out_obr_fec_pub2"), "fecha")
                        obra.evid_pub2 = ValidarDBNull(row.Item("out_evid_pub2"), "cadena")
                        obra.col_clv2 = ValidarDBNull(row.Item("out_col_clv2"), "cadena")
                        obra.limite1 = ValidarDBNull(row.Item("out_limite1"), "cadena")
                        obra.limite2 = ValidarDBNull(row.Item("out_limite2"), "cadena")
                        obra.col_nom = ValidarDBNull(row.Item("out_col_nom"), "cadena")
                        obra.cestatus = ValidarDBNull(row.Item("out_cestatus"), "cadena")
                        obra.nomprog = ValidarDBNull(row.Item("out_nomprog"), "cadena")
                        obra.progmun = ValidarDBNull(row.Item("out_progmun"), "entero")
                        obra.progcoop = ValidarDBNull(row.Item("out_progcoop"), "entero")
                        obra.descrip_tipo_obr = ValidarDBNull(row.Item("out_descrip_tipo_obr"), "cadena")
                        obra.obr_clv = ValidarDBNull(row.Item("out_obr_clv"), "cadena")
                        obra.obr_mts = ValidarDBNull(row.Item("out_obr_mts"), "real")
                        obra.obr_cost = ValidarDBNull(row.Item("out_obr_cost"), "real")
                        obra.obr_int = ValidarDBNull(row.Item("out_obr_int"), "entero")
                        obra.obr_fecha = ValidarDBNull(row.Item("out_obr_fecha"), "fecha")
                        obra.obr_cost_total = ValidarDBNull(row.Item("out_obr_cost_total"), "real")
                        obra.obr_inc = ValidarDBNull(row.Item("out_obr_inc"), "real")
                        obra.obr_fecinip = ValidarDBNull(row.Item("out_obr_fecinip"), "fecha")
                        obra.obr_fecvenp = ValidarDBNull(row.Item("out_obr_fecvenp"), "fecha")
                        obra.obr_npago = ValidarDBNull(row.Item("out_obr_npago"), "entero")
                        obra.obr_opergob = ValidarDBNull(row.Item("out_obr_opergob"), "cadena")
                        obra.obr_fec_ini_proc = ValidarDBNull(row.Item("out_obr_fec_ini_proc"), "fecha")
                        obra.obr_fec_ini_cob = ValidarDBNull(row.Item("out_obr_fec_ini_cob"), "fecha")
                        obra.obr_clv_int = ValidarDBNull(row.Item("out_obr_clv_int"), "entero")
                        obra.obr_prog2 = ValidarDBNull(row.Item("out_obr_prog2"), "entero")
                        obra.obr_clv2 = ValidarDBNull(row.Item("out_obr_clv2"), "cadena")
                        obra.obr_sis = ValidarDBNull(row.Item("out_obr_sis"), "cadena")
                        obra.obr_status = ValidarDBNull(row.Item("out_obr_status"), "entero")
                        obra.obr_fec_can = ValidarDBNull(row.Item("out_obr_fec_can"), "fecha")
                        obra.no_contrato = ValidarDBNull(row.Item("out_obr_no_contrato"), "cadena")
                        obra.gastos_admvos = ValidarDBNull(row.Item("out_obr_gastos_admvos"), "real")
                        obra.evid_obra_proc = ValidarDBNull(row.Item("out_obr_evid_proc"), "cadena")
                        obra.evid_termino_obra = ValidarDBNull(row.Item("out_obr_evid_termino"), "cadena")
                        obra.obr_nat = ValidarDBNull(row.Item("out_obr_nat"), "cadena")
                        obra.obr_num_coops = ValidarDBNull(row.Item("out_obr_num_coops"), "entero")
                        obra.obr_num_coops_s = ValidarDBNull(row.Item("out_obr_num_coops_s"), "entero")

                        obras.Add(obra)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))

                Dim objeto As JQGridJsonResponseObra = New JQGridJsonResponseObra
                objeto.JQGridJsonResponseObra(pagecount, currentpage, recordcount, obras)
                Return objeto
            End Using
        End Using
    End Function




    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObras_Rep1(estatus_obra_int As Integer, fecha_lim As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_obras_lim", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@cve_estatus_obra_in", estatus_obra_int)
                cmd.Parameters.AddWithValue("@fecha", fecha_lim)
                adapt.Fill(dt, "obras_rep1")
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


    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObra_lim_q(obr_clv_int As Integer, fecha_lim As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_obra_lim_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@obr_clv_int_in", obr_clv_int)
                cmd.Parameters.AddWithValue("@fecha_in", fecha_lim)
                adapt.Fill(dt, "obra_lim_q")
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




    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObras_Rep3(fecha_lim As String, obr_clv_int As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_rep3_xls", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fecha_lim", fecha_lim)
                cmd.Parameters.AddWithValue("@obr_clv_int_in", obr_clv_int)
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

    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObras_Rep4(fecha_lim As String, obr_clv_int As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_rep4_xls", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fecha_lim", fecha_lim)
                cmd.Parameters.AddWithValue("@obr_clv_int_in", obr_clv_int)
                adapt.Fill(dt, "obras_rep4")
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


    <WebMethod(Description:="Retorna datos de un predio seleccionado")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function RegObra_PostgresSql(objObraS As clsObraWritePsql) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim obr_clv_int As Integer = 0
        Dim obr_clv_txt As String
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_obra3", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure



                cmd.Parameters.AddWithValue("@obr_clv_int_in", objObraS.obr_clv_int)
                cmd.Parameters.AddWithValue("@obr_clv_in", objObraS.obr_clv)
                cmd.Parameters.AddWithValue("@obr_mts_in", objObraS.obr_mts)
                cmd.Parameters.AddWithValue("@obr_cost_in", objObraS.obr_cost)
                cmd.Parameters.AddWithValue("@obr_int_in", objObraS.obr_tipo)
                cmd.Parameters.AddWithValue("@obr_fecha_in", objObraS.obr_fecha)
                cmd.Parameters.AddWithValue("@obr_cost_total", objObraS.obr_cost_total)
                cmd.Parameters.AddWithValue("@obr_inc_in", objObraS.obr_inc)
                cmd.Parameters.AddWithValue("@obr_fecinip_in", objObraS.obr_fecinip)
                cmd.Parameters.AddWithValue("@obr_fecvenp_in", objObraS.obr_fecvencp)
                cmd.Parameters.AddWithValue("@obr_npago_in", objObraS.obr_npago)
                cmd.Parameters.AddWithValue("@obr_opergob_in", objObraS.obr_opergob)
                cmd.Parameters.AddWithValue("@obr_fec_ini_proc_in", objObraS.obr_fec_ini_proc)
                cmd.Parameters.AddWithValue("@obr_id_tipo_recurso_in", objObraS.id_tipo_recurso)
                cmd.Parameters.AddWithValue("@obr_fec_ini_cob_in", objObraS.obr_fec_ini_cob)
                cmd.Parameters.AddWithValue("@obr_clv_col_in", objObraS.col_clv2)
                cmd.Parameters.AddWithValue("@obr_clv_prog_in", objObraS.obr_prog2)
                cmd.Parameters.AddWithValue("@obr_status_in", objObraS.obr_status)
                cmd.Parameters.AddWithValue("@oid_in", objObraS.obr_oid)
                cmd.Parameters.AddWithValue("@obr_fec_canc_in", objObraS.obr_fec_canc)
                cmd.Parameters.AddWithValue("@obr_clv_sis_in", objObraS.obr_sis)
                cmd.Parameters.AddWithValue("@no_contrato_in", objObraS.no_contrato)
                cmd.Parameters.AddWithValue("@gastos_admvos_in", objObraS.gastos_admvos)
                cmd.Parameters.AddWithValue("@obr_fec_pub1_in", objObraS.obr_fec_pub1)
                cmd.Parameters.AddWithValue("@obr_fec_pub2_in", objObraS.obr_fec_pub2)
                cmd.Parameters.AddWithValue("@evid_pub1_in", objObraS.evid_pub1)
                cmd.Parameters.AddWithValue("@evid_pub2_in", objObraS.evid_pub2)
                cmd.Parameters.AddWithValue("@evid_obra_proc_in", objObraS.evid_obra_proc)
                cmd.Parameters.AddWithValue("@evid_termino_obra_in", objObraS.evid_termino_obra)
                cmd.Parameters.AddWithValue("@obr_nat_in", objObraS.obr_nat)
                cmd.Parameters.AddWithValue("@idusu_in", objObraS.idusu)
                cmd.Parameters.AddWithValue("@accionx", objObraS.accion)



                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output
                Dim par_obr_clv_int As NpgsqlParameter = New NpgsqlParameter("@obr_clv_int_out", NpgsqlTypes.NpgsqlDbType.Integer, 36) ' .Value = Space(1000)
                par_obr_clv_int.Direction = ParameterDirection.Output
                Dim par_obr_clv_txt As NpgsqlParameter = New NpgsqlParameter("@obr_clv_out", NpgsqlTypes.NpgsqlDbType.Integer, 36) ' .Value = Space(1000)
                par_obr_clv_txt.Direction = ParameterDirection.Output


                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(par_obr_clv_int)
                cmd.Parameters.Add(par_obr_clv_txt)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()
                obr_clv_int = cmd.Parameters("@obr_clv_int_out").Value()
                obr_clv_txt = cmd.Parameters("@obr_clv_out").Value()
                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                con.Close()


            End Using
        End Using
        Try
            If numerror > 0 Then
                Return messerror & ":0"
            Else
                Return "Accion ejecutada correctamente:" & obr_clv_int.ToString & ":" & obr_clv_txt
            End If
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function


    <WebMethod(Description:="Retorna datos de un predio seleccionado")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function RegObraProc_PostgresSql(objObraProc As clsObraProceso) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim obr_clv_int As Integer = 0
        Dim obr_clv_txt As String
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_obra4", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure



                cmd.Parameters.AddWithValue("@oid_in", objObraProc.oid)
                cmd.Parameters.AddWithValue("@obr_clv_int_in", objObraProc.obr_clv_int)
                cmd.Parameters.AddWithValue("@obra_s_in", objObraProc.obra_s)
                cmd.Parameters.AddWithValue("@fec_ini_proc_in", objObraProc.fec_ini_proc)
                cmd.Parameters.AddWithValue("@idtipo_recurso_in", objObraProc.idtipo_recurso)
                cmd.Parameters.AddWithValue("@descrip_in", objObraProc.descrip)
                cmd.Parameters.AddWithValue("@gastos_admvos_in", objObraProc.gastos_admvos)
                cmd.Parameters.AddWithValue("@num_contratos_in", objObraProc.num_contratos)
                cmd.Parameters.AddWithValue("@idusu_in", objObraProc.idusu)
                cmd.Parameters.AddWithValue("@fec_mod_in", objObraProc.fec_mod)
                cmd.Parameters.AddWithValue("@cactivo_in", objObraProc.cactivo)
                cmd.Parameters.AddWithValue("@accion_in", objObraProc.accion)


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
            If numerror > 0 Then
                Return messerror & ":0"
            Else
                Return "Accion ejecutada correctamente:"
            End If
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function


    <WebMethod(Description:="Retorna datos de un predio seleccionado")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function RegObra_Access(objObraS As clsObraWriteAccess) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf6").ConnectionString
        Dim ds As DataSet = New DataSet()
        Dim strSQL, strSQL2 As String

        strSQL = ""
        strSQL2 = ""


        'Dim strSQL As String = "insert into obra (obr_clv,obr_call,obr_col,obr_mts,obr_cost,obr_stat,obr_int,obr_tramo,obr_fecha,obr_cost_total,obr_inc,obr_contab,obr_sis,col_nom,obr_digito,obr_programa,obr_cuentac,obr_digagr,obr_fecinip,obr_fecvenp,obr_npago,obr_numera,obr_opergob) values (" + Char(34) + objObraS.obr_clv + Char(34) + "," + Char(34)+ objObraS.obr_call + Char(34) + "," + Char(34) + objObraS.obr_col + Char(34) + "," + objObraS.obr_mts + "," + objObraS.obr_cost + ","+ Char(34) + objObraS.obr_stat + Char(34) + "," + objObraS.obr_int + ","+Char(34) + objObraS.obr_tramo + Char(34) + ","+ Char(34) + objObraS.obr_fecha + Char(34) + "," + objObraS.obr_cost_total +"," + objObraS.obr_inc + ","+Char(34) + objObraS.obr_contab + Char(34) + ","+Char(34) + objObraS.obr_sis + Char(34)+","+Char(34) + objObraS.col_nom + Char(34) + ","+Char(34) + objObraS.obr_digito + Char(34)+","+Char(34) + objObraS.obr_programa + Char(34) + ","+Char(34) + objObraS.obr_cuentac + Char(34) +","+Char(34) + objObraS.obr_digagr + Char(34)+","+Char(34) + objObraS.obr_fecinip + Char(34) + ","+Char(34) + objObraS.obr_fecvenp + Char(34) + "," + objObraS.obr_npago + ","+Char(34) + objObraS.obr_numera + Char(34)+","+Char(34) + objObraS.obr_opergob + Char(34) +")"
        If objObraS.accion = 1 Then
            strSQL = "update obra set obr_mts=" & objObraS.obr_mts & ",obr_cost=" & objObraS.obr_cost & ",obr_fecinip='" & objObraS.obr_fecinip & "',obr_fecvenp='" & objObraS.obr_fecvenp & "',obr_npago=" & objObraS.obr_npago & ",obr_col='" & objObraS.obr_col & "',obr_programa='" & objObraS.obr_programa & "',obr_sis='" & objObraS.obr_sis & "' where obr_clv ='" & objObraS.obr_clv & "'"

            Using con As New OleDbConnection(constr)
                Dim cmd As OleDbCommand = con.CreateCommand()
                cmd.CommandText = strSQL
                Dim adapt As New OleDbDataAdapter(cmd)
                Try
                    con.Open()
                    cmd.ExecuteNonQuery()
                Catch ex As Exception
                    Return "Error: No fue posible actualizar registro en la tabla: obra"
                End Try
                con.Close()
            End Using

        End If
        If objObraS.accion = 0 Then
            strSQL = "insert into obra (obr_clv,obr_call,obr_col,obr_tramo,obr_fecha,obr_cost,obr_stat,obr_sis,obr_programa,obr_cuentac,obr_digagr,obr_fecinip,obr_fecvenp,obr_npago,obr_opergob,obr_numera,obr_contab) values ('" & objObraS.obr_clv & "','" & objObraS.obr_call & "','" & objObraS.obr_col & "','" & objObraS.obr_tramo & "','" & objObraS.obr_fecha & "'," & objObraS.obr_cost & ",'" & objObraS.obr_stat & "','" & objObraS.obr_sis & "','" & objObraS.obr_programa & "','" & objObraS.obr_cuentac & "','" & objObraS.obr_digagr + "','" & objObraS.obr_fecinip & "','" & objObraS.obr_fecvenp & "'," & objObraS.obr_npago & ",'" & objObraS.obr_opergob & "','0','0')"

            Using con As New OleDbConnection(constr)
                Dim cmd As OleDbCommand = con.CreateCommand()
                cmd.CommandText = strSQL
                Dim adapt As New OleDbDataAdapter(cmd)
                Try
                    con.Open()
                    cmd.ExecuteNonQuery()
                Catch ex As Exception
                    Return "Error: No fue posible guardar registro en la tabla: obra"
                End Try
                con.Close()
            End Using
        End If

        If objObraS.accion = 2 Then

            Dim transaction As OleDbTransaction = Nothing

            Dim obra_cancelada As String = "98" & Mid(objObraS.obr_clv, 3, 8)
            strSQL = "update obra set obr_clv='" & obra_cancelada & "' where obr_clv='" & objObraS.obr_clv & "'"

            strSQL2 = "update cooperador set coo_obr='" & obra_cancelada & "',coo_clv ='98' + mid(coo_clv,3,11) " & " where coo_obr='" & objObraS.obr_clv & "'"

            Using con As New OleDbConnection(constr)
                ''Dim cmd As OleDbCommand = con.CreateCommand()
                ''Dim adapt As New OleDbDataAdapter(cmd)
                Try
                    con.Open()

                    transaction = con.BeginTransaction(IsolationLevel.ReadCommitted)
                    '' cmd.Transaction = transaction
                    Dim cmd = New OleDb.OleDbCommand(strSQL, con, transaction)
                    cmd.ExecuteNonQuery()


                    cmd = New OleDb.OleDbCommand(strSQL2, con, transaction)
                    cmd.ExecuteNonQuery()
                    transaction.Commit()

                Catch ex As Exception
                    Return "Error: No fue posible cancelar registro en la tabla: obra"
                End Try
                con.Close()
            End Using
        End If

        If objObraS.accion = 4 Then ''Cambio de estatus de obra RECAUDACION ---> PROCESO

            Dim transaction As OleDbTransaction = Nothing

            strSQL = "update obra set obr_stat='" & objObraS.obr_stat & "',obr_opergob='" & objObraS.obr_opergob & "' where obr_clv='" & objObraS.obr_clv & "'"

            If (objObraS.obr_est_act = "4") Then
                strSQL2 = "update obrah set obr_fecha='" & objObraS.obr_feciniproc & "',obr_status='" & objObraS.obr_stat & "',obr_desc='Inic. Proc. Obra',obr_user='" & objObraS.obr_usuario & "' where obr_clv='" & objObraS.obr_clv & "'"
            Else
                strSQL2 = "insert into obrah (obr_clv,obr_fecha,obr_status,obr_desc,obr_user) values ('" & objObraS.obr_clv & "','" & objObraS.obr_feciniproc & "','" & objObraS.obr_stat & "','Inic. Proc. Obra','" & objObraS.obr_usuario & "');"
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


                    cmd = New OleDb.OleDbCommand(strSQL2, con, transaction)
                    cmd.ExecuteNonQuery()
                    transaction.Commit()

                Catch ex As Exception
                    Return "Error: No fue posible cambiar de estatus la obra: obra"
                End Try
                con.Close()
            End Using
        End If

        If objObraS.accion = 6 Then ''Cambio de estatus de obra PROCESO  ---> TERMINADA VENCIDA

            Dim transaction As OleDbTransaction = Nothing

            strSQL = "update obra set obr_stat='" & objObraS.obr_stat & "',obr_opergob='" & objObraS.obr_opergob & "' where obr_clv='" & objObraS.obr_clv & "'"

            If (objObraS.obr_est_act = "5") Then
                strSQL2 = "update obrah set obr_fecha='" & objObraS.obr_fecinicob & "',obr_status='" & objObraS.obr_stat & "',obr_desc='Terminada Vencida',obr_user='" & objObraS.obr_usuario & "' where obr_clv='" & objObraS.obr_clv & "'"
            Else
                strSQL2 = "insert into obrah (obr_clv,obr_fecha,obr_status,obr_desc,obr_user) values ('" & objObraS.obr_clv & "','" & objObraS.obr_fecinicob & "','" & objObraS.obr_stat & "','Terminada Vencida','" & objObraS.obr_usuario & "');"
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


                    cmd = New OleDb.OleDbCommand(strSQL2, con, transaction)
                    cmd.ExecuteNonQuery()
                    transaction.Commit()

                Catch ex As Exception
                    Return "Error: No fue posible cambiar de estatus la obra: obra"
                End Try
                con.Close()
            End Using
        End If



    End Function


    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetUbics(accion As Integer, oid As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_oids_obraq", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@accionx", accion)
                cmd.Parameters.AddWithValue("@oidx", oid)
                adapt.Fill(dt, "oids")
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

    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObraCoops_txt(obr_clv_int As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_obras_coops_txt", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@obr_clv_intx", obr_clv_int)
                adapt.Fill(dt, "obras")
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



    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObra2_psql(accion As Integer, obr_clv_int As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_obras2_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@obr_clv_int_in", obr_clv_int)
                cmd.Parameters.AddWithValue("@accion_in", accion)
                adapt.Fill(dt, "obra")
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

    <WebMethod(Description:="Retorna registro de la capa factibilidad")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObra_oid(accion As Integer, oid As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_obra_oid_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@oidx", oid)
                cmd.Parameters.AddWithValue("@accionx", accion)
                adapt.Fill(dt, "oid_p")
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

    <WebMethod(Description:="Retorna registro de la capa factibilidad")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObra_obr_clv_int(accion As Integer, obr_clv_int As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_obra_clv_int_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@obr_clv_intx", obr_clv_int)
                cmd.Parameters.AddWithValue("@accionx", accion)
                adapt.Fill(dt, "obra")
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



    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetOb(accion As String, oid As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_obraq", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@oidx", oid)
                cmd.Parameters.AddWithValue("@accionx", accion)
                adapt.Fill(dt, "obrass")
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

    <WebMethod(Description:="Actualizar el registro del documento")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObra(oid As Integer, accion As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_obraq", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@oidx", oid)
                cmd.Parameters.AddWithValue("@accionx", accion)
                adapt.Fill(ds, "Obra")
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

    <WebMethod(Description:="Actualizar el registro del documento")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetActCostoObra(oid As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_consulta_act_costo_obra_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@oid_in", oid)
                adapt.Fill(ds, "act_costo_obra")
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


    <WebMethod(Description:="Actualizar el registro del documento")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObraSIFIDOC(obr_clv As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf6").ConnectionString
        Dim ds As DataSet = New DataSet()

        Dim strSQL As String = "select * from obra where obr_clv='" + obr_clv + "'"

        Using con As New OleDbConnection(constr)
            Using cmd As New OleDbCommand(strSQL, con)
                Dim adapt As OleDbDataAdapter = New OleDbDataAdapter(cmd)
                adapt.Fill(ds, "obra_sifidoc")

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


    <WebMethod(Description:="Actualizar el registro del documento")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObrasSIFIDOC() As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf6").ConnectionString
        Dim ds As DataSet = New DataSet()

        Dim strSQL As String = "select * from obra where obr_stat in ('1','2','4','5') order by obr_call;"

        Using con As New OleDbConnection(constr)
            Using cmd As New OleDbCommand(strSQL, con)
                Dim adapt As OleDbDataAdapter = New OleDbDataAdapter(cmd)
                adapt.Fill(ds, "obras_sifidoc")

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


    <WebMethod(Description:="Actualizar el registro del documento")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetObrasSGP(accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_obras_sgp", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@accion_in", accion)
                adapt.Fill(ds, "ObrasSGP")
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
                            ValidarDBNull = ""
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