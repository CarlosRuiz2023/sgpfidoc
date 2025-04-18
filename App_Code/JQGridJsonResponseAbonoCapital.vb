﻿Public Class JQGridJsonResponseAbonoCapital


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

    Public Sub JQGridJsonResponseAbonoCapital(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, abonos_capital As List(Of clsAbonoCapital))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim cargo_pagado As clsAbonoCapital = New clsAbonoCapital()

        For Each abono_capital In abonos_capital
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = abono_capital.clv_coo
            objeto.row = New List(Of String)(New String() {
                                                            abono_capital.clv_coo,
                                                            abono_capital.monto_abonar,
                                                            abono_capital.idpago,
                                                            abono_capital.fecha_pago,
                                                            abono_capital.coo_clv2,
                                                            abono_capital.folio_caja
                                                })
            _items.Add(objeto)
        Next
    End Sub

End Class


