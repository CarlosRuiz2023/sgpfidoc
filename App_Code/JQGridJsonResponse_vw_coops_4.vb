Public Class JQGridJsonResponse_vw_coops_4

#Region "Passive attributes"
    Private _pageCount As Integer
    Private _currentPage As Integer
    Private _recordCount As Integer
    Private _items As List(Of JQGridItem)

    Public Property PageCount() As Integer
        Get
            Return _pageCount
        End Get
        Set(ByVal Value As Integer)
            _pageCount = Value
        End Set
    End Property
    Public Property CurrentPage() As Integer
        Get
            Return _currentPage
        End Get
        Set(ByVal Value As Integer)
            _currentPage = Value
        End Set
    End Property

    Public Property RecordCount() As Integer
        Get
            Return _recordCount
        End Get
        Set(ByVal Value As Integer)
            _recordCount = Value
        End Set
    End Property

    Public Property Items() As List(Of JQGridItem)
        Get
            Return _items
        End Get
        Set(ByVal Value As List(Of JQGridItem))
            _items = Value
        End Set
    End Property
#End Region

    Public Sub JQGridJsonResponse_vw_coops_4(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, vwcoops4_s As List(Of cls_vwcoops_4))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim vwcoops4 As cls_vwcoops_4 = New cls_vwcoops_4()

        For Each vwcoops4 In vwcoops4_s
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = vwcoops4.fid
            objeto.row = New List(Of String)(New String() {vwcoops4.fid,
                                                           vwcoops4.geom_frente,
                                                           vwcoops4.mts_frente,
                                                           vwcoops4.cid,
                                                           vwcoops4.coopid,
                                                           vwcoops4.pid,
                                                           vwcoops4.oid,
                                                           vwcoops4.obs_grales,
                                                           vwcoops4.obra_sifidoc,
                                                           vwcoops4.gid,
                                                           vwcoops4.feccre_frente,
                                                           vwcoops4.fecmod_frente,
                                                           vwcoops4.usucre_frente,
                                                           vwcoops4.usumod_frente,
                                                           vwcoops4.prid,
                                                           vwcoops4.inc,
                                                           vwcoops4.did,
                                                           vwcoops4.factor_act_pago,
                                                           vwcoops4.obr_clv_int,
                                                           vwcoops4.coo_clv2,
                                                           vwcoops4.activo,
                                                           vwcoops4.capital,
                                                           vwcoops4.midcoop,
                                                           vwcoops4.mapellidop,
                                                           vwcoops4.mapellidom,
                                                           vwcoops4.mnombres,
                                                           vwcoops4.mcallecoop,
                                                           vwcoops4.mcolcoop,
                                                           vwcoops4.mnooficial_ext,
                                                           vwcoops4.mnooficial_int,
                                                           vwcoops4.mtelcoop,
                                                           vwcoops4.mnomficha,
                                                           vwcoops4.mestado,
                                                           vwcoops4.mpais,
                                                           vwcoops4.mcorreo,
                                                           vwcoops4.usrcre_coop,
                                                           vwcoops4.feccre_coop,
                                                           vwcoops4.usrmod_coop,
                                                           vwcoops4.fecmod_coop,
                                                           vwcoops4.mcurp,
                                                           vwcoops4.mrelacionpredio,
                                                           vwcoops4.ine,
                                                           vwcoops4.doc_identific,
                                                           vwcoops4.obr_clv,
                                                           vwcoops4.obr_mts,
                                                           vwcoops4.obr_cost,
                                                           vwcoops4.obr_int,
                                                           vwcoops4.obr_fecha,
                                                           vwcoops4.obr_cost_total,
                                                           vwcoops4.obr_inc,
                                                           vwcoops4.obr_fecinip,
                                                           vwcoops4.obr_fecvenp,
                                                           vwcoops4.obr_npago,
                                                           vwcoops4.obr_opergob,
                                                           vwcoops4.obr_fec_ini_proc,
                                                           vwcoops4.obr_fec_ini_cob,
                                                           vwcoops4.obr_clv_int_obra,
                                                           vwcoops4.obr_prog2,
                                                           vwcoops4.nomprog,
                                                           vwcoops4.progdescrip,
                                                           vwcoops4.obr_clv2,
                                                           vwcoops4.obr_status,
                                                           vwcoops4.cestatus,
                                                           vwcoops4.oid_obra,
                                                           vwcoops4.obr_fec_canc,
                                                           vwcoops4.obr_sis,
                                                           vwcoops4.col_clv2,
                                                           vwcoops4.no_contrato,
                                                           vwcoops4.gastos_admvos,
                                                           vwcoops4.obr_fec_pub1,
                                                           vwcoops4.obr_fec_pub2,
                                                           vwcoops4.evid_pub1,
                                                           vwcoops4.evid_pub2,
                                                           vwcoops4.evid_obra_proc,
                                                           vwcoops4.evid_termino_obra,
                                                           vwcoops4.obr_nat,
                                                           vwcoops4.pid_predio,
                                                           vwcoops4.objectid,
                                                           vwcoops4.gid_server,
                                                           vwcoops4.cup,
                                                           vwcoops4.feccre_pred,
                                                           vwcoops4.fecmod_pred,
                                                           vwcoops4.tipo,
                                                           vwcoops4.tipopredio,
                                                           vwcoops4.ctapredial,
                                                           vwcoops4.ctaimuvi,
                                                           vwcoops4.observacio,
                                                           vwcoops4.shape_area,
                                                           vwcoops4.shape_len,
                                                           vwcoops4.geom_predio,
                                                           vwcoops4.uso_predio,
                                                           vwcoops4.uso_suelo,
                                                           vwcoops4.r20,
                                                           vwcoops4.nooficial,
                                                           vwcoops4.sapal,
                                                           vwcoops4.usrcre_pred,
                                                           vwcoops4.usrmod_pred,
                                                           vwcoops4.num_escritura,
                                                           vwcoops4.reg_escritura,
                                                           vwcoops4.folio_escritura,
                                                           vwcoops4.tomo_escritura,
                                                           vwcoops4.doc_escritura,
                                                           vwcoops4.lote,
                                                           vwcoops4.mzna,
                                                           vwcoops4.saldo_sin,
                                                           vwcoops4.saldo_sin_act,
                                                           vwcoops4.pagos,
                                                           vwcoops4.recargos,
                                                           vwcoops4.clv_inpc_ant,
                                                           vwcoops4.clv_inpc_actual,
                                                           vwcoops4.clv_inpc_actual_2,
                                                           vwcoops4.factor_act,
                                                           vwcoops4.monto_act,
                                                           vwcoops4.saldo,
                                                           vwcoops4.calle,
                                                           vwcoops4.colonia,
                                                           vwcoops4.limite1,
                                                           vwcoops4.limite2,
                                                           vwcoops4.tramo,
                                                           vwcoops4.pae,
                                                           vwcoops4.iddet,
                                                           vwcoops4.det_estatus,
                                                           vwcoops4.fec_imp_det,
                                                           vwcoops4.fec_ent_det,
                                                           vwcoops4.fec_notif_det,
                                                           vwcoops4.hora_notif_det,
                                                           vwcoops4.idministro,
                                                           vwcoops4.musunombre,
                                                           vwcoops4.tipo_doc,
                                                           vwcoops4.nom_doc
                                                          })
            _items.Add(objeto)
        Next
    End Sub

End Class
