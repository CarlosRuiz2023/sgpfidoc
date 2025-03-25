Public Class clsDesctoRec

    Private _fid As Integer
    Private _pid As Integer
    Private _oid As Integer
    Private _obrasifidoc As String
    Private _folio_pago As String
    Private _porcentaje_descto As Integer
    Private _monto_saldo_pagar As Double
    Private _monto_descto As Double
    Private _factor_act_pago As Double
    Private _fec_aplic_descto As Date
    Private _fec_ofrece_descto As Date
    Private _recargos_pagados As Double
    Private _recargos_iniciales As Double
    Private _fec_mov_as400 As Date
    Private _fec_lim_pago As Date
    Private _usuario As Integer
    Private _estatus_descto As Integer
    Private _accion As String


    Public Property fid() As Integer        Get            Return _fid        End Get        Set(ByVal Value As Integer)            _fid = Value        End Set    End Property
    Public Property pid() As Integer        Get            Return _pid        End Get        Set(ByVal Value As Integer)            _pid = Value        End Set    End Property
    Public Property oid() As Integer        Get            Return _oid        End Get        Set(ByVal Value As Integer)            _oid = Value        End Set    End Property
    Public Property obrasifidoc() As String        Get            Return _obrasifidoc        End Get        Set(ByVal Value As String)            _obrasifidoc = Value        End Set    End Property
    Public Property folio_pago() As String        Get            Return _folio_pago        End Get        Set(ByVal Value As String)            _folio_pago = Value        End Set    End Property
    Public Property porcentaje_descto() As Integer        Get            Return _porcentaje_descto        End Get        Set(ByVal Value As Integer)            _porcentaje_descto = Value        End Set    End Property
    Public Property monto_saldo_pagar() As Double        Get            Return _monto_saldo_pagar        End Get        Set(ByVal Value As Double)            _monto_saldo_pagar = Value        End Set    End Property
    Public Property monto_descto() As Double        Get            Return _monto_descto        End Get        Set(ByVal Value As Double)            _monto_descto = Value        End Set    End Property    Public Property factor_act_pago() As Double        Get            Return _factor_act_pago        End Get        Set(ByVal Value As Double)            _factor_act_pago = Value        End Set    End Property
    Public Property fec_aplic_descto() As Date        Get            Return _fec_aplic_descto        End Get        Set(ByVal Value As Date)            _fec_aplic_descto = Value        End Set    End Property
    Public Property fec_ofrece_descto() As Date        Get            Return _fec_ofrece_descto        End Get        Set(ByVal Value As Date)            _fec_ofrece_descto = Value        End Set    End Property
    Public Property recargos_pagados() As Double        Get            Return _recargos_pagados        End Get        Set(ByVal Value As Double)            _recargos_pagados = Value        End Set    End Property
    Public Property recargos_iniciales() As Double        Get            Return _recargos_iniciales        End Get        Set(ByVal Value As Double)            _recargos_iniciales = Value        End Set    End Property
    Public Property fec_mov_as400() As Date        Get            Return _fec_mov_as400        End Get        Set(ByVal Value As Date)            _fec_mov_as400 = Value        End Set    End Property
    Public Property fec_lim_pago() As Date        Get            Return _fec_lim_pago        End Get        Set(ByVal Value As Date)            _fec_lim_pago = Value        End Set    End Property
    Public Property usuario() As Integer        Get            Return _usuario        End Get        Set(ByVal Value As Integer)            _usuario = Value        End Set    End Property
    Public Property estatus_descto() As Integer        Get            Return _estatus_descto        End Get        Set(ByVal Value As Integer)            _estatus_descto = Value        End Set    End Property

    Public Property accion() As String        Get            Return _accion        End Get        Set(ByVal Value As String)            _accion = Value        End Set    End Property
End Class
