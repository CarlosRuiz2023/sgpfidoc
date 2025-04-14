Public Class JQGridJsonResponsePagos

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

    Public Sub JQGridJsonResponseTipoAsamblea(pagos_list As List(Of clsPago))
        _items = New List(Of JQGridItem)
        Dim pago As clsPago = New clsPago()

        For Each pago In pagos_list
            Dim objeto As JQGridItem = New JQGridItem
            objeto.row = New List(Of String)(New String() {
                                                        pago._coop_s,
                                                        pago.Obra_s,
                                                        pago.Fec_as400,
                                                        pago.Usu_fidoc,
                                                        pago.Importe,
                                                        pago.Tipo_mov,
                                                        pago.Obra_coop_s,
                                                        pago.Fid,
                                                        pago.Usucre,
                                                        pago.P2_recibo,
                                                        pago.Recibo,
                                                        pago.Obr_clv_int,
                                                        pago.Mov_activo,
                                                        pago.Nombre,
                                                        pago.Elemento})
            _items.Add(objeto)
        Next
    End Sub



End Class
