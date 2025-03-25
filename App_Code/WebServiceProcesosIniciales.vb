Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://fidoc.gob.mx/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceProcesosIniciales
    Inherits System.Web.Services.WebService


    <WebMethod(Description:="Generar recargo de requerimiento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GeneraRecReq(accion As String) As JQGridJsonResponseCoopS
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_proc_inic", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@accion", accion)
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


    <WebMethod(Description:="Generar recargo de requerimiento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function EliminaDesctosVencidos(accion As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim numerror As Integer = 0
        Dim idmov As Integer
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_proc_inic_", con)
                cmd.Parameters.AddWithValue("@accion", accion)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output
                Dim parpresupx As NpgsqlParameter = New NpgsqlParameter("@idmov", NpgsqlTypes.NpgsqlDbType.Integer, 36) ' .Value = Space(1000)
                parpresupx.Direction = ParameterDirection.Output


                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(parpresupx)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                idmov = cmd.Parameters("@idmov").Value()
                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                con.Close()
            End Using
        End Using
        Try
            If numerror > 0 Then
                Return messerror & ":0"
            Else
                Return "Accion ejecutada correctamente:" & idmov.ToString
            End If
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
                                ValidarDBNull = ""
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