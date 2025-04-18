﻿Public Class JQGridJsonResponseTipoAnexoContrato

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

    Public Sub JQGridJsonResponseTipoAnexoContrato(pPageCount As Integer, pCurrentPage As Integer, pRecordCount As Integer, TiposAnexoContrato As List(Of clsTipoAnexoContrato))
        _pageCount = pPageCount
        _currentPage = pCurrentPage
        _recordCount = pRecordCount
        _items = New List(Of JQGridItem)
        Dim TipoAnexoContrato As clsTipoAnexoContrato = New clsTipoAnexoContrato()

        For Each TipoAnexoContrato In TiposAnexoContrato
            Dim objeto As JQGridItem = New JQGridItem
            objeto.Id = TipoAnexoContrato.idtipo_anexo_cont
            objeto.row = New List(Of String)(New String() {TipoAnexoContrato.idtipo_anexo_cont,
                                                           TipoAnexoContrato.etiqueta_anexo,
                                                           TipoAnexoContrato.observaciones,
                                                           TipoAnexoContrato.usu_cre,
                                                           TipoAnexoContrato.usu_mod,
                                                           TipoAnexoContrato.fec_cre,
                                                           TipoAnexoContrato.fec_mod,
                                                           TipoAnexoContrato.cactivo})
            _items.Add(objeto)
        Next
    End Sub
End Class


