Public Class clsDocPAE

#Region "variables privadas"
    Private _iddoc As Integer = 0
    Private _fec_imp_doc As Date
    Private _fec_ent_doc As Date
    Private _fec_notific_doc As Date
    Private _idministro As Integer
    Private _estatus_doc As Integer
    Private _img_doc_firma As String
    Private _obra_coop_s As String
    Private _fid As Integer
    Private _tipo_doc As Integer
    Shared conn As New clsConexion
#End Region


#Region "Propiedades"
    Public Property iddoc() As Integer
        Get
            Return _iddoc
        End Get
        Set(ByVal Value As Integer)
            _iddoc = Value
        End Set
    End Property

    Public Property fec_imp_doc() As Date
        Get
            Return _fec_imp_doc
        End Get
        Set(ByVal Value As Date)
            _fec_imp_doc = Value
        End Set
    End Property

    Public Property fec_ent_doc() As Date
        Get
            Return _fec_ent_doc
        End Get
        Set(ByVal Value As Date)
            _fec_ent_doc = Value
        End Set
    End Property

    Public Property fec_notific_doc() As Date
        Get
            Return _fec_notific_doc
        End Get
        Set(ByVal Value As Date)
            _fec_notific_doc = Value
        End Set
    End Property

    Public Property idministro() As Integer
        Get
            Return _idministro
        End Get
        Set(ByVal Value As Integer)
            _idministro = Value
        End Set
    End Property

    Public Property estatus_doc() As Integer
        Get
            Return _estatus_doc
        End Get
        Set(ByVal Value As Integer)
            _estatus_doc = Value
        End Set
    End Property

    Public Property img_doc_firma() As String
        Get
            Return _img_doc_firma
        End Get
        Set(ByVal Value As String)
            _img_doc_firma = Value
        End Set
    End Property

    Public Property obra_coop_s() As String
        Get
            Return _obra_coop_s
        End Get
        Set(ByVal Value As String)
            _obra_coop_s = Value
        End Set
    End Property

    Public Property fid() As Integer
        Get
            Return _fid
        End Get
        Set(ByVal Value As Integer)
            _fid = Value
        End Set
    End Property

    Public Property tipo_doc() As Integer
        Get
            Return _tipo_doc
        End Get
        Set(ByVal Value As Integer)
            _tipo_doc = Value
        End Set
    End Property

#End Region

End Class
