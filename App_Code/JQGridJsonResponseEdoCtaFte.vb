Public Class JQGridJsonResponseEdoCtaFte
#Region "Passive attributes"

    Private _items As List(Of JQGridItem)




    Public Property Items() As List(Of JQGridItem)
        Get
            Return _items
        End Get
        Set(ByVal Value As List(Of JQGridItem))
            _items = Value
        End Set
    End Property


#End Region

    Public Sub JQGridJsonResponseEdoCtaFte(edoctaftes As List(Of clsEdoCtaFte))

        _items = New List(Of JQGridItem)
        Dim edoctafte As clsEdoCtaFte = New clsEdoCtaFte()

        For Each edoctafte In edoctaftes
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = edoctafte.fid
            objeto.row = New List(Of String)(New String() {edoctafte.fid,
                                                           edoctafte.pid,
                                                           edoctafte.oid,
                                                           edoctafte.cid,
                                                           edoctafte.cooperador,
                                                           edoctafte.mnomficha,
                                                           edoctafte.callenotif,
                                                           edoctafte.colnotif,
                                                           edoctafte.nooficnotif,
                                                           edoctafte.mts_frente,
                                                           edoctafte.prid,
                                                           edoctafte.costo_mto_lineal,
                                                           edoctafte.costo_total_obra,
                                                           edoctafte.nomprog,
                                                           edoctafte.progmun,
                                                           edoctafte.progcoop,
                                                           edoctafte.progdescrip,
                                                           edoctafte.nooficial,
                                                           edoctafte.ctapredial,
                                                           edoctafte.lote,
                                                           edoctafte.mzna,
                                                           edoctafte.r20,
                                                           edoctafte.cup,
                                                           edoctafte.ctaimuvi,
                                                           edoctafte.uso_predio,
                                                           edoctafte.sapal,
                                                           edoctafte.tipopredio,
                                                           edoctafte.uso_suelo,
                                                           edoctafte.adeudo,
                                                           edoctafte.incremento,
                                                           edoctafte.usucre,
                                                           edoctafte.feccre,
                                                           edoctafte.usrmod,
                                                           edoctafte.fecmod,
                                                           edoctafte.suma_pagos_antes_antes,
                                                           edoctafte.suma_pagos_antes_desp,
                                                           edoctafte.suma_pagos_desp_antes,
                                                           edoctafte.suma_pagos_desp_desp,
                                                           edoctafte.saldo_parcial,
                                                           edoctafte.saldo_act,
                                                           edoctafte.saldo_act2,
                                                           edoctafte.recargos,
                                                           edoctafte.saldo_pagar,
                                                           edoctafte.periodo_recargos,
                                                           edoctafte.clv_inpc_ant,
                                                           edoctafte.clv_inpc_actual,
                                                           edoctafte.clv_inpc_actual_2,
                                                           edoctafte.fec_ini_per_act,
                                                           edoctafte.fec_fin_per_act,
                                                           edoctafte.fec_fin_per_act_2,
                                                           edoctafte.fec_notif_det,
                                                           edoctafte.fec_notif_req,
                                                           edoctafte.fec_notif_ejec,
                                                           edoctafte.fec_pav,
                                                           edoctafte.fec_rec,
                                                           edoctafte.nopagos,
                                                           edoctafte.fec_ini_pag,
                                                           edoctafte.fec_venc,
                                                           edoctafte.fec_proceso,
                                                           edoctafte.fec_cob,
                                                           edoctafte.fec_pub_1,
                                                           edoctafte.fec_pub_2,
                                                           edoctafte.fec_aviso_cong,
                                                           edoctafte.status_obra,
                                                           edoctafte.sector,
                                                           edoctafte.subsector,
                                                           edoctafte.cvecalle,
                                                           edoctafte.calle,
                                                           edoctafte.colonia,
                                                           edoctafte.tramo,
                                                           edoctafte.cestatus,
                                                           edoctafte.accesorios6,
                                                           edoctafte.accesorios7,
                                                           edoctafte.periodo_act,
                                                           edoctafte.factor_act,
                                                           edoctafte.descuentos,
                                                           edoctafte.estatus_conv,
                                                           edoctafte.idconv,
                                                           edoctafte.fec_conv,
                                                           edoctafte.factor_act_conv,
                                                           edoctafte.recargos_conv,
                                                           edoctafte.descto_recargos_conv,
                                                           edoctafte.recargo_por_conv,
                                                           edoctafte.fecha_venc_conv,
                                                           edoctafte.num_pagos_conv,
                                                           edoctafte.saldo_conv,
                                                           edoctafte.pagos_conv,
                                                           edoctafte.archivo_conv})
            _items.Add(objeto)
        Next
    End Sub




End Class
