Imports System.Data
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceEdoCta
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los datos de un estado de cuentas de un cooperador")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetEdoCtaFte_cv(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponseEdoCtaFrente_cv
        Return GetEdoCtaFteJSon_cv(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro)

    End Function

    Private Function GetEdoCtaFteJSon_cv(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String) As JQGridJsonResponseEdoCtaFrente_cv
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_cartera_vencida", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fid", pPageSize)
                cmd.Parameters.AddWithValue("@accion", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)

                adapt.Fill(dt)
                Dim edoctaftes_cv = New List(Of clsedoctafte_cv)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim edoctafte_cv As clsedoctafte_cv = New clsedoctafte_cv()
                        edoctafte_cv.fid = Convert.ToInt32(row.Item("out_fid"))
                        edoctafte_cv.geomfrente = ValidarDBNull(row.Item("out_geom_frente"))
                        edoctafte_cv.mtsfrente = ValidarDBNull(row.Item("out_mts_frente"))
                        edoctafte_cv.cid = ValidarDBNull(row.Item("out_cid"))
                        edoctafte_cv.coopid = ValidarDBNull(row.Item("out_coopid"))
                        edoctafte_cv.obrasifidoc = ValidarDBNull(row.Item("out_obra_sifidoc"))
                        edoctafte_cv.feccre = ValidarDBNull(row.Item("out_feccre"))
                        edoctafte_cv.fecmod = ValidarDBNull(row.Item("out_fecmod"))
                        edoctafte_cv.usucre = ValidarDBNull(row.Item("out_usucre"))
                        edoctafte_cv.usrmod = ValidarDBNull(row.Item("out_usrmod"))
                        edoctafte_cv.prid = ValidarDBNull(row.Item("out_prid"))
                        edoctafte_cv.costomtolineal = ValidarDBNull(row.Item("out_costo_mto_lineal"))
                        edoctafte_cv.adeudo = ValidarDBNull(row.Item("out_adeudo"))
                        edoctafte_cv.saldo = ValidarDBNull(row.Item("out_saldo"))
                        edoctafte_cv.saldo_act = ValidarDBNull(row.Item("out_saldo_act"))
                        edoctafte_cv.geomobra = ValidarDBNull(row.Item("out_geom_obra"))
                        edoctafte_cv.calle = ValidarDBNull(row.Item("out_calle"))
                        edoctafte_cv.colonia = ValidarDBNull(row.Item("out_colonia"))
                        edoctafte_cv.tramo = ValidarDBNull(row.Item("out_tramo"))
                        edoctafte_cv.noobra = ValidarDBNull(row.Item("out_noobra"))
                        edoctafte_cv.noobra2 = ValidarDBNull(row.Item("out_noobra2"))
                        edoctafte_cv.noobra3 = ValidarDBNull(row.Item("out_noobra3"))
                        edoctafte_cv.fecrec = ValidarDBNull(row.Item("out_fec_rec"))
                        edoctafte_cv.fecinipag = ValidarDBNull(row.Item("out_fec_ini_pag"))
                        edoctafte_cv.fecvenc = ValidarDBNull(row.Item("out_fec_venc"))
                        edoctafte_cv.fecproceso = ValidarDBNull(row.Item("out_fec_proceso"))
                        edoctafte_cv.feccob = ValidarDBNull(row.Item("out_fec_cob"))
                        edoctafte_cv.fecpav = ValidarDBNull(row.Item("out_fec_pav"))
                        edoctafte_cv.statusfidoc = ValidarDBNull(row.Item("out_status_sifidoc"))
                        edoctafte_cv.geompredio = ValidarDBNull(row.Item("out_geom_predio"))
                        edoctafte_cv.ctapredial = ValidarDBNull(row.Item("out_ctapredial"))
                        edoctafte_cv.nooficial = ValidarDBNull(row.Item("out_nooficial"))
                        edoctafte_cv.mapellidop = ValidarDBNull(row.Item("out_mapellidop"))
                        edoctafte_cv.mapellidom = ValidarDBNull(row.Item("out_mapellidom"))
                        edoctafte_cv.mnombres = ValidarDBNull(row.Item("out_mnombres"))
                        edoctafte_cv.nomcoop = ValidarDBNull(row.Item("out_nom_coop"))
                        edoctaftes_cv.Add(edoctafte_cv)
                    Next row

                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseEdoCtaFrente_cv = New JQGridJsonResponseEdoCtaFrente_cv
                objeto.JQGridJsonResponseEdoCtaFrente_cv(pagecount, currentpage, recordcount, edoctaftes_cv)
                Return objeto

            End Using
        End Using
    End Function


    <WebMethod(Description:="Retorna datos de un predio seleccionado")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetEdoCtaFte(fid As Integer, accion As Integer) As JQGridJsonResponseEdoCtaFte
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim recordcount As Integer

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_edo_cuenta_coop_gral", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fid", fid)
                cmd.Parameters.AddWithValue("@accion", accion)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)

                adapt.Fill(dt)
                Dim edoctaftes = New List(Of clsEdoCtaFte)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim edoctafte As clsEdoCtaFte = New clsEdoCtaFte
                        edoctafte.fid = ValidarDBNull(row.Item("out_fid"))
                        edoctafte.pid = ValidarDBNull(row.Item("out_pid"))
                        edoctafte.oid = ValidarDBNull(row.Item("out_oid"))
                        edoctafte.cid = ValidarDBNull(row.Item("out_cid"))
                        edoctafte.cooperador = ValidarDBNull(row.Item("out_obrasifidoc"))
                        edoctafte.mnomficha = ValidarDBNull(row.Item("out_nomcoop"))
                        edoctafte.callenotif = ValidarDBNull(row.Item("out_callenotif"))
                        edoctafte.colnotif = ValidarDBNull(row.Item("out_colonianotif"))
                        edoctafte.nooficnotif = ValidarDBNull(row.Item("out_nooficnotif"))
                        edoctafte.mts_frente = ValidarDBNull(row.Item("out_mtsfte"))
                        edoctafte.prid = ValidarDBNull(row.Item("out_prid"))
                        edoctafte.costo_mto_lineal = ValidarDBNull(row.Item("out_costomtolineal"))
                        edoctafte.costo_total_obra = ValidarDBNull(row.Item("out_costototalobra"))
                        edoctafte.nomprog = ValidarDBNull(row.Item("out_programa"))
                        edoctafte.progmun = ValidarDBNull(row.Item("out_progmun"))
                        edoctafte.progcoop = ValidarDBNull(row.Item("out_progcoop"))
                        edoctafte.progdescrip = ValidarDBNull(row.Item("out_progdescrip"))
                        edoctafte.nooficial = ValidarDBNull(row.Item("out_nooficial"))
                        edoctafte.ctapredial = ValidarDBNull(row.Item("out_ctapredial"))
                        edoctafte.lote = ValidarDBNull(row.Item("out_lote"))
                        edoctafte.mzna = ValidarDBNull(row.Item("out_mzna"))
                        edoctafte.r20 = ValidarDBNull(row.Item("out_r20"))
                        edoctafte.cup = ValidarDBNull(row.Item("out_cup"))
                        edoctafte.ctaimuvi = ValidarDBNull(row.Item("out_ctaimuvi"))
                        edoctafte.uso_predio = ValidarDBNull(row.Item("out_uso_predio"))
                        edoctafte.sapal = ValidarDBNull(row.Item("out_sapal"))
                        edoctafte.tipopredio = ValidarDBNull(row.Item("out_tipopredio"))
                        edoctafte.uso_suelo = ValidarDBNull(row.Item("out_usosuelo"))
                        edoctafte.adeudo = ValidarDBNull(row.Item("out_adeudo"))
                        edoctafte.incremento = ValidarDBNull(row.Item("out_incremento"))
                        edoctafte.usucre = ValidarDBNull(row.Item("out_usucre"))
                        edoctafte.feccre = ValidarDBNull(row.Item("out_feccre"))
                        edoctafte.usrmod = ValidarDBNull(row.Item("out_usrmod"))
                        edoctafte.fecmod = ValidarDBNull(row.Item("out_fecmod"))
                        edoctafte.suma_pagos_antes_antes = ValidarDBNull(row.Item("out_sum_pagos_antes_antes"))
                        edoctafte.suma_pagos_antes_desp = ValidarDBNull(row.Item("out_sum_pagos_antes_desp"))
                        edoctafte.suma_pagos_desp_antes = ValidarDBNull(row.Item("out_sum_pagos_desp_antes"))
                        edoctafte.suma_pagos_desp_desp = ValidarDBNull(row.Item("out_sum_pagos_desp_desp"))
                        edoctafte.saldo_parcial = ValidarDBNull(row.Item("out_saldo_parcial"))
                        edoctafte.saldo_act = ValidarDBNull(row.Item("out_saldo_act"))
                        edoctafte.saldo_act2 = ValidarDBNull(row.Item("out_saldo_act2"))
                        edoctafte.recargos = ValidarDBNull(row.Item("out_recargos"))
                        edoctafte.saldo_pagar = ValidarDBNull(row.Item("out_saldo_pagar"))
                        edoctafte.periodo_recargos = ValidarDBNull(row.Item("out_periodo_recargos"))
                        edoctafte.clv_inpc_ant = ValidarDBNull(row.Item("out_clv_inpc_ant"))
                        edoctafte.clv_inpc_actual = ValidarDBNull(row.Item("out_clv_inpc_actual"))
                        edoctafte.clv_inpc_actual_2 = ValidarDBNull(row.Item("out_clv_inpc_actual_2"))
                        edoctafte.fec_ini_per_act = ValidarDBNull(row.Item("out_fec_ini_per_act"))
                        edoctafte.fec_fin_per_act = ValidarDBNull(row.Item("out_fec_fin_per_act"))
                        edoctafte.fec_fin_per_act_2 = ValidarDBNull(row.Item("out_fec_fin_per_act_2"))
                        edoctafte.fec_notif_det = ValidarDBNull(row.Item("out_fecnotifdet"))
                        edoctafte.fec_notif_req = ValidarDBNull(row.Item("out_fecnotifreq"))
                        edoctafte.fec_notif_ejec = ValidarDBNull(row.Item("out_fecnotifejec"))
                        edoctafte.fec_pav = ValidarDBNull(row.Item("out_fecpav"))
                        edoctafte.fec_rec = ValidarDBNull(row.Item("out_fecrec"))
                        edoctafte.nopagos = ValidarDBNull(row.Item("out_numpagos"))
                        edoctafte.fec_ini_pag = ValidarDBNull(row.Item("out_fecinipag"))
                        edoctafte.fec_venc = ValidarDBNull(row.Item("out_fecvenc"))
                        edoctafte.fec_proceso = ValidarDBNull(row.Item("out_fecproceso"))
                        edoctafte.fec_cob = ValidarDBNull(row.Item("out_feccob"))
                        edoctafte.fec_pub_1 = ValidarDBNull(row.Item("out_fecpub1"))
                        edoctafte.fec_pub_2 = ValidarDBNull(row.Item("out_fecpub2"))
                        edoctafte.fec_aviso_cong = ValidarDBNull(row.Item("out_fecavisocong"))
                        edoctafte.status_obra = ValidarDBNull(row.Item("out_estatusobra"))
                        edoctafte.sector = ValidarDBNull(row.Item("out_sector"))
                        edoctafte.subsector = ValidarDBNull(row.Item("out_subsector"))
                        edoctafte.cvecalle = ValidarDBNull(row.Item("out_cvecalle"))
                        edoctafte.calle = ValidarDBNull(row.Item("out_calle"))
                        edoctafte.colonia = ValidarDBNull(row.Item("out_colonia"))
                        edoctafte.tramo = ValidarDBNull(row.Item("out_tramo"))
                        edoctafte.cestatus = ValidarDBNull(row.Item("out_estatusobrac"))
                        edoctafte.accesorios6 = ValidarDBNull(row.Item("out_accesorios6"))
                        edoctafte.accesorios7 = ValidarDBNull(row.Item("out_accesorios7"))
                        edoctafte.periodo_act = ValidarDBNull(row.Item("out_periodoact"))
                        edoctafte.factor_act = ValidarDBNull(row.Item("out_factoract"))
                        edoctafte.descuentos = ValidarDBNull(row.Item("out_descuentos"))
                        edoctafte.estatus_conv = ValidarDBNull(row.Item("out_estatusconv"))
                        edoctafte.idconv = ValidarDBNull(row.Item("out_idconv"))
                        edoctafte.fec_conv = ValidarDBNull(row.Item("out_fec_conv"))
                        edoctafte.factor_act_conv = ValidarDBNull(row.Item("out_factor_act_conv"))
                        edoctafte.recargos_conv = ValidarDBNull(row.Item("out_recargos_conv"))
                        edoctafte.descto_recargos_conv = ValidarDBNull(row.Item("out_descto_recargos_conv"))
                        edoctafte.fecha_venc_conv = ValidarDBNull(row.Item("out_fecha_venc_conv"))
                        edoctafte.num_pagos_conv = ValidarDBNull(row.Item("out_num_pagos_conv"))
                        edoctafte.saldo_conv = ValidarDBNull(row.Item("out_saldo_conv"))
                        edoctafte.pagos_conv = ValidarDBNull(row.Item("out_pagos_conv"))
                        edoctafte.archivo_conv = ValidarDBNull(row.Item("out_archivo_conv"))
                        edoctaftes.Add(edoctafte)
                    Next row
                End If

                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                Dim objeto As JQGridJsonResponseEdoCtaFte = New JQGridJsonResponseEdoCtaFte
                objeto.JQGridJsonResponseEdoCtaFte(edoctaftes)
                Return objeto

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
End Class