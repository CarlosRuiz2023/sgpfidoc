Public Class JQGridJsonResponseFrentePredioCoopV

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

    Public Sub JQGridJsonResponseFrentePredioCoopV(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, coopsfpc As List(Of clsFrentePredioCoopV))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim coopfpc As clsFrentePredioCoopV = New clsFrentePredioCoopV()

        For Each coopfpc In coopsfpc
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = coopfpc.fid
            objeto.row = New List(Of String)(New String() {coopfpc.oid,
                                                           coopfpc.fid,
                                                           coopfpc.pid,
                                                           coopfpc.cid,
                                                           coopfpc.prid,
                                                           coopfpc.programa,
                                                           coopfpc.obrasifidoc,
                                                           coopfpc.coopid,
                                                           coopfpc.mtsfrente,
                                                           coopfpc.costomtolineal,
                                                           coopfpc.capital,
                                                           coopfpc.incremento,
                                                           coopfpc.sum_pagos_antes_fec_notif_det,
                                                           coopfpc.sum_pagos_antes_fec_act,
                                                           coopfpc.acces_falta_antes_fec_act,
                                                           coopfpc.sum_acces_desp_fec_act_6,
                                                           coopfpc.sum_acces_desp_fec_act_7,
                                                           coopfpc.sum_pagos_desp_fec_act,
                                                           coopfpc.saldo_parcial,
                                                           coopfpc.saldo_act,
                                                           coopfpc.saldo_total,
                                                           coopfpc.saldo_pagar,
                                                           coopfpc.recargos,
                                                           coopfpc.periodorecargos,
                                                           coopfpc.calle,
                                                           coopfpc.colonia,
                                                           coopfpc.tramo,
                                                           coopfpc.noobra,
                                                           coopfpc.noobra2,
                                                           coopfpc.noobra3,
                                                           coopfpc.fecrec,
                                                           coopfpc.fecinipag,
                                                           coopfpc.fecvenc,
                                                           coopfpc.fecproceso,
                                                           coopfpc.feccob,
                                                           coopfpc.fecpav,
                                                           coopfpc.fecnotifdet,
                                                           coopfpc.fecact,
                                                           coopfpc.statussifidoc,
                                                           coopfpc.ctapredial,
                                                           coopfpc.nooficial,
                                                           coopfpc.mapellidop,
                                                           coopfpc.mapellidom,
                                                           coopfpc.mnombres,
                                                           coopfpc.nomcoop,
                                                           coopfpc.usosuelo,
                                                           coopfpc.factoract,
                                                           coopfpc.periodoact,
                                                           coopfpc.feccre,
                                                           coopfpc.fecmod,
                                                           coopfpc.usucre,
                                                           coopfpc.usumod,
                                                           coopfpc.geomfrente,
                                                           coopfpc.geompredio,
                                                           coopfpc.geomobra
                                                          })
            _items.Add(objeto)
        Next
    End Sub
End Class

