Public Class JQGridJsonResponseCoopS


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

    Public Sub JQGridJsonResponseCoopS(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, coops As List(Of clsCoopS))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim coop As clsCoopS = New clsCoopS()

        For Each coop In coops
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = coop.fid
            objeto.row = New List(Of String)(New String() {
                                                                       coop.fid,
                                                                       coop.geom_frente,
                                                                       coop.mts_frente,
                                                                       coop.cid,
                                                                       coop.coopid,
                                                                       coop.pid,
                                                                       coop.oid,
                                                                       coop.obs_grales,
                                                                       coop.obra_sifidoc,
                                                                       coop.gid,
                                                                       coop.feccre_frente,
                                                                       coop.fecmod_frente,
                                                                       coop.usucre_frente,
                                                                       coop.usumod_frente,
                                                                       coop.prid,
                                                                       coop.inc,
                                                                       coop.did,
                                                                       coop.factor_act_pago,
                                                                       coop.obr_clv_int,
                                                                       coop.coo_clv2,
                                                                       coop.activo,
                                                                       coop.capital,
                                                                       coop.midcoop,
                                                                       coop.mapellidop,
                                                                       coop.mapellidom,
                                                                       coop.mnombres,
                                                                       coop.mcallecoop,
                                                                       coop.mcolcoop,
                                                                       coop.mnooficial_ext,
                                                                       coop.mnooficial_int,
                                                                       coop.mtelcoop,
                                                                       coop.mnomficha,
                                                                       coop.mestado,
                                                                       coop.mpais,
                                                                       coop.mcorreo,
                                                                       coop.usrcre_coop,
                                                                       coop.feccre_coop,
                                                                       coop.usrmod_coop,
                                                                       coop.fecmod_coop,
                                                                       coop.mcurp,
                                                                       coop.mrelacionpredio,
                                                                       coop.ine,
                                                                       coop.doc_identific,
                                                                       coop.obr_clv,
                                                                       coop.obr_mts,
                                                                       coop.obr_cost,
                                                                       coop.obr_int,
                                                                       coop.obr_fecha,
                                                                       coop.obr_cost_total,
                                                                       coop.obr_inc,
                                                                       coop.obr_fecinip,
                                                                       coop.obr_fecvenp,
                                                                       coop.obr_npago,
                                                                       coop.obr_opergob,
                                                                       coop.obr_fec_ini_proc,
                                                                       coop.obr_fec_ini_cob,
                                                                       coop.obr_clv_int_obra,
                                                                       coop.obr_prog2,
                                                                       coop.nomprog,
                                                                       coop.progdescrip,
                                                                       coop.obr_clv2,
                                                                       coop.obr_status,
                                                                       coop.cestatus,
                                                                       coop.oid_obra,
                                                                       coop.obr_fec_canc,
                                                                       coop.obr_sis,
                                                                       coop.col_clv2,
                                                                       coop.no_contrato,
                                                                       coop.gastos_admvos,
                                                                       coop.obr_fec_pub1,
                                                                       coop.obr_fec_pub2,
                                                                       coop.evid_pub1,
                                                                       coop.evid_pub2,
                                                                       coop.evid_obra_proc,
                                                                       coop.evid_termino_obra,
                                                                       coop.obr_nat,
                                                                       coop.pid_predio,
                                                                       coop.objectid,
                                                                       coop.gid_server,
                                                                       coop.cup,
                                                                       coop.feccre_pred,
                                                                       coop.fecmod_pred,
                                                                       coop.tipo,
                                                                       coop.tipopredio,
                                                                       coop.ctapredial,
                                                                       coop.ctaimuvi,
                                                                       coop.observacio,
                                                                       coop.shape_area,
                                                                       coop.shape_len,
                                                                       coop.geom_predio,
                                                                       coop.uso_predio,
                                                                       coop.uso_suelo,
                                                                       coop.r20,
                                                                       coop.nooficial,
                                                                       coop.sapal,
                                                                       coop.usrcre_pred,
                                                                       coop.usrmod_pred,
                                                                       coop.num_escritura,
                                                                       coop.reg_escritura,
                                                                       coop.folio_escritura,
                                                                       coop.tomo_escritura,
                                                                       coop.doc_escritura,
                                                                       coop.lote,
                                                                       coop.mzna,
                                                                       coop.saldo_sin,
                                                                       coop.saldo_sin_act,
                                                                       coop.pagos,
                                                                       coop.recargos,
                                                                       coop.clv_inpc_ant,
                                                                       coop.clv_inpc_actual,
                                                                       coop.clv_inpc_actual_2,
                                                                       coop.factor_act,
                                                                       coop.monto_act,
                                                                       coop.saldo,
                                                                       coop.calle,
                                                                       coop.colonia,
                                                                       coop.limite1,
                                                                       coop.limite2,
                                                                       coop.tramo,
                                                                       coop.pae,
                                                                       coop.iddet,
                                                                       coop.det_estatus,
                                                                       coop.fec_imp_det,
                                                                       coop.fec_ent_det,
                                                                       coop.fec_notif_det,
                                                                       coop.hora_notif_det,
                                                                       coop.idministro,
                                                                       coop.musunombre,
                                                                       coop.tipo_doc,
                                                                       coop.nom_doc
                                                                   })
            _items.Add(objeto)
        Next
    End Sub





End Class
