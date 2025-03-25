Public Class clsCoopWriteAccess
#Region "variables privadas"
    Private _coo_clv As String = String.Empty
    Private _coo_pat As String = String.Empty
    Private _coo_mat As String = String.Empty
    Private _coo_nom As String = String.Empty
    Private _coo_nof As String = String.Empty
    Private _coo_call As String = String.Empty
    Private _coo_num As String = String.Empty
    Private _coo_col As String = String.Empty
    Private _coo_ciu As String = String.Empty
    Private _coo_est As String = String.Empty
    Private _coo_cp As String = String.Empty
    Private _coo_tel As String = String.Empty
    Private _coo_lote As String = String.Empty
    Private _coo_ant As Integer = 0
    Private _coo_npag As Integer = 0
    Private _coo_venc1 As String = String.Empty
    Private _coo_obr As String = String.Empty
    Private _coo_mts As Double = 0
    Private _coo_inc As Double = 0
    Private _coo_clv1 As String = String.Empty
    Private _coo_pred As String = String.Empty
    Private _coo_nombre As String = String.Empty
    Private _coo_pagos As Integer = 0
    Private _coo_cargos As Integer = 0
    Private _coo_gto_req As Integer = 0
    Private _coo_gto_ejec As Integer = 0
    Private _coo_notificado As String = String.Empty
    Private _coo_requerido As String = String.Empty
    Private _coo_ejecutado As String = String.Empty
    Private _coo_ultimoaviso As String = String.Empty
    Private _coo_propx As Integer = 0
    Private _coo_rfc As String = String.Empty
    Private _coo_fiscal As String = String.Empty
    Private _coo_razonsoc As String = String.Empty
    Private _coo_grupo As String = String.Empty
    Private _coo_fecgrupo As String = String.Empty
    Private _coo_dec As Double = 0
    Private _coo_transferida As Integer = 0
    Private _accion As String = String.Empty
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"

    Public Property coo_clv() As String
        Get
            Return _coo_clv
        End Get
        Set(ByVal Value As String)
            _coo_clv = Value
        End Set
    End Property

    Public Property coo_pat() As String
        Get
            Return _coo_pat
        End Get
        Set(ByVal Value As String)
            _coo_pat = Value
        End Set
    End Property

    Public Property coo_mat() As String
        Get
            Return _coo_mat
        End Get
        Set(ByVal Value As String)
            _coo_mat = Value
        End Set
    End Property

    Public Property coo_nom() As String
        Get
            Return _coo_nom
        End Get
        Set(ByVal Value As String)
            _coo_nom = Value
        End Set
    End Property

    Public Property coo_nof() As String
        Get
            Return _coo_nof
        End Get
        Set(ByVal Value As String)
            _coo_nof = Value
        End Set
    End Property

    Public Property coo_call() As String
        Get
            Return _coo_call
        End Get
        Set(ByVal Value As String)
            _coo_call = Value
        End Set
    End Property

    Public Property coo_num() As String
        Get
            Return _coo_num
        End Get
        Set(ByVal Value As String)
            _coo_num = Value
        End Set
    End Property

    Public Property coo_col() As String
        Get
            Return _coo_col
        End Get
        Set(ByVal Value As String)
            _coo_col = Value
        End Set
    End Property

    Public Property coo_ciu() As String
        Get
            Return _coo_ciu
        End Get
        Set(ByVal Value As String)
            _coo_ciu = Value
        End Set
    End Property

    Public Property coo_est() As String
        Get
            Return _coo_est
        End Get
        Set(ByVal Value As String)
            _coo_est = Value
        End Set
    End Property

    Public Property coo_cp() As String
        Get
            Return _coo_cp
        End Get
        Set(ByVal Value As String)
            _coo_cp = Value
        End Set
    End Property

    Public Property coo_tel() As String
        Get
            Return _coo_tel
        End Get
        Set(ByVal Value As String)
            _coo_tel = Value
        End Set
    End Property

    Public Property coo_lote() As String
        Get
            Return _coo_lote
        End Get
        Set(ByVal Value As String)
            _coo_lote = Value
        End Set
    End Property

    Public Property coo_ant() As Integer
        Get
            Return _coo_ant
        End Get
        Set(ByVal Value As Integer)
            _coo_ant = Value
        End Set
    End Property

    Public Property coo_npag() As Integer
        Get
            Return _coo_npag
        End Get
        Set(ByVal Value As Integer)
            _coo_npag = Value
        End Set
    End Property

    Public Property coo_venc1() As String
        Get
            Return _coo_venc1
        End Get
        Set(ByVal Value As String)
            _coo_venc1 = Value
        End Set
    End Property

    Public Property coo_obr() As String
        Get
            Return _coo_obr
        End Get
        Set(ByVal Value As String)
            _coo_obr = Value
        End Set
    End Property

    Public Property coo_mts() As Double
        Get
            Return _coo_mts
        End Get
        Set(ByVal Value As Double)
            _coo_mts = Value
        End Set
    End Property

    Public Property coo_inc() As Double
        Get
            Return _coo_inc
        End Get
        Set(ByVal Value As Double)
            _coo_inc = Value
        End Set
    End Property

    Public Property coo_clv1() As String
        Get
            Return _coo_clv1
        End Get
        Set(ByVal Value As String)
            _coo_clv1 = Value
        End Set
    End Property

    Public Property coo_pred() As String
        Get
            Return _coo_pred
        End Get
        Set(ByVal Value As String)
            _coo_pred = Value
        End Set
    End Property

    Public Property coo_nombre() As String
        Get
            Return _coo_nombre
        End Get
        Set(ByVal Value As String)
            _coo_nombre = Value
        End Set
    End Property

    Public Property coo_pagos() As Integer
        Get
            Return _coo_pagos
        End Get
        Set(ByVal Value As Integer)
            _coo_pagos = Value
        End Set
    End Property

    Public Property coo_cargos() As Integer
        Get
            Return _coo_cargos
        End Get
        Set(ByVal Value As Integer)
            _coo_cargos = Value
        End Set
    End Property

    Public Property coo_gto_req() As Integer
        Get
            Return _coo_gto_req
        End Get
        Set(ByVal Value As Integer)
            _coo_gto_req = Value
        End Set
    End Property

    Public Property coo_gto_ejec() As Integer
        Get
            Return _coo_gto_ejec
        End Get
        Set(ByVal Value As Integer)
            _coo_gto_ejec = Value
        End Set
    End Property

    Public Property coo_notificado() As String
        Get
            Return _coo_notificado
        End Get
        Set(ByVal Value As String)
            _coo_notificado = Value
        End Set
    End Property

    Public Property coo_requerido() As String
        Get
            Return _coo_requerido
        End Get
        Set(ByVal Value As String)
            _coo_requerido = Value
        End Set
    End Property

    Public Property coo_ejecutado() As String
        Get
            Return _coo_ejecutado
        End Get
        Set(ByVal Value As String)
            _coo_ejecutado = Value
        End Set
    End Property

    Public Property coo_ultimoaviso() As String
        Get
            Return _coo_ultimoaviso
        End Get
        Set(ByVal Value As String)
            _coo_ultimoaviso = Value
        End Set
    End Property

    Public Property coo_propx() As Integer
        Get
            Return _coo_propx
        End Get
        Set(ByVal Value As Integer)
            _coo_propx = Value
        End Set
    End Property

    Public Property coo_rfc() As String
        Get
            Return _coo_rfc
        End Get
        Set(ByVal Value As String)
            _coo_rfc = Value
        End Set
    End Property

    Public Property coo_fiscal() As String
        Get
            Return _coo_fiscal
        End Get
        Set(ByVal Value As String)
            _coo_fiscal = Value
        End Set
    End Property

    Public Property coo_razonsoc() As String
        Get
            Return _coo_razonsoc
        End Get
        Set(ByVal Value As String)
            _coo_razonsoc = Value
        End Set
    End Property

    Public Property coo_grupo() As String
        Get
            Return _coo_grupo
        End Get
        Set(ByVal Value As String)
            _coo_grupo = Value
        End Set
    End Property

    Public Property coo_fecgrupo() As String
        Get
            Return _coo_fecgrupo
        End Get
        Set(ByVal Value As String)
            _coo_fecgrupo = Value
        End Set
    End Property

    Public Property coo_dec() As Double
        Get
            Return _coo_dec
        End Get
        Set(ByVal Value As Double)
            _coo_dec = Value
        End Set
    End Property

    Public Property coo_transferida() As Integer
        Get
            Return _coo_transferida
        End Get
        Set(ByVal Value As Integer)
            _coo_transferida = Value
        End Set
    End Property


    Public Property accion() As String
        Get
            Return _accion
        End Get
        Set(ByVal Value As String)
            _accion = Value
        End Set
    End Property

    Public Property Mensaje() As String
        Get
            Return strMensaje
        End Get
        Set(ByVal Value As String)
            strMensaje = Value
        End Set
    End Property



#End Region

#Region "Metodos"




#End Region

End Class