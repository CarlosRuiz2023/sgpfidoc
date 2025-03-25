Public Class clsUsuarioTareaAccion
#Region "variables privadas"
    Private _id_accion_tarea As Integer = 0
    Private _fid As Integer = 0
    Private _pid As Integer = 0
    Private _oid As Integer = 0
    Private _obr_clv_int As Integer = 0
    Private _cid As Integer = 0
    Private _idtarea As Integer = 0
    Private _idusu_solicita As Integer = 0
    Private _idusu_autoriza As Integer = 0
    Private _idusu_rubrica As Integer = 0
    Private _idusu_rubrica2 As Integer = 0
    Private _folio_solic As String = String.Empty
    Private _parametro1 As String = String.Empty
    Private _parametro2 As String = String.Empty
    Private _parametro3 As String = String.Empty
    Private _parametro4 As String = String.Empty
    Private _parametro5 As String = String.Empty
    Private _parametro6 As String = String.Empty
    Private _parametro7 As String = String.Empty
    Private _parametro8 As String = String.Empty
    Private _parametro9 As String = String.Empty
    Private _parametro10 As String = String.Empty
    Private _parametro11 As String = String.Empty
    Private _parametro12 As String = String.Empty
    Private _parametro13 As String = String.Empty
    Private _parametro14 As String = String.Empty
    Private _parametro15 As String = String.Empty
    Private _parametro16 As String = String.Empty
    Private _parametro17 As String = String.Empty
    Private _parametro18 As String = String.Empty
    Private _parametro19 As String = String.Empty
    Private _parametro20 As String = String.Empty
    Private _strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"


    Public Property id_accion_tarea() As Integer
        Get
            Return _id_accion_tarea
        End Get
        Set(ByVal Value As Integer)
            _id_accion_tarea = Value
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
    Public Property pid() As Integer
        Get
            Return _pid
        End Get
        Set(ByVal Value As Integer)
            _pid = Value
        End Set
    End Property
    Public Property oid() As Integer
        Get
            Return _oid
        End Get
        Set(ByVal Value As Integer)
            _oid = Value
        End Set
    End Property
    Public Property obr_clv_int() As Integer
        Get
            Return _obr_clv_int
        End Get
        Set(ByVal Value As Integer)
            _obr_clv_int = Value
        End Set
    End Property
    Public Property cid() As Integer
        Get
            Return _cid
        End Get
        Set(ByVal Value As Integer)
            _cid = Value
        End Set
    End Property
    Public Property idtarea() As Integer
        Get
            Return _idtarea
        End Get
        Set(ByVal Value As Integer)
            _idtarea = Value
        End Set
    End Property
    Public Property idusu_solicita() As Integer
        Get
            Return _idusu_solicita
        End Get
        Set(ByVal Value As Integer)
            _idusu_solicita = Value
        End Set
    End Property
    Public Property idusu_autoriza() As Integer
        Get
            Return _idusu_autoriza
        End Get
        Set(ByVal Value As Integer)
            _idusu_autoriza = Value
        End Set
    End Property
    Public Property idusu_rubrica() As Integer
        Get
            Return _idusu_rubrica
        End Get
        Set(ByVal Value As Integer)
            _idusu_rubrica = Value
        End Set
    End Property
    Public Property idusu_rubrica2() As Integer
        Get
            Return _idusu_rubrica2
        End Get
        Set(ByVal Value As Integer)
            _idusu_rubrica2 = Value
        End Set
    End Property
    Public Property folio_solic() As String
        Get
            Return _folio_solic
        End Get
        Set(ByVal Value As String)
            _folio_solic = Value
        End Set
    End Property

    Public Property parametro1() As String
        Get
            Return _parametro1
        End Get
        Set(ByVal Value As String)
            _parametro1 = Value
        End Set
    End Property
    Public Property parametro2() As String
        Get
            Return _parametro2
        End Get
        Set(ByVal Value As String)
            _parametro2 = Value
        End Set
    End Property
    Public Property parametro3() As String
        Get
            Return _parametro3
        End Get
        Set(ByVal Value As String)
            _parametro3 = Value
        End Set
    End Property
    Public Property parametro4() As String
        Get
            Return _parametro4
        End Get
        Set(ByVal Value As String)
            _parametro4 = Value
        End Set
    End Property
    Public Property parametro5() As String
        Get
            Return _parametro5
        End Get
        Set(ByVal Value As String)
            _parametro5 = Value
        End Set
    End Property
    Public Property parametro6() As String
        Get
            Return _parametro6
        End Get
        Set(ByVal Value As String)
            _parametro6 = Value
        End Set
    End Property
    Public Property parametro7() As String
        Get
            Return _parametro7
        End Get
        Set(ByVal Value As String)
            _parametro7 = Value
        End Set
    End Property
    Public Property parametro8() As String
        Get
            Return _parametro8
        End Get
        Set(ByVal Value As String)
            _parametro8 = Value
        End Set
    End Property
    Public Property parametro9() As String
        Get
            Return _parametro9
        End Get
        Set(ByVal Value As String)
            _parametro9 = Value
        End Set
    End Property
    Public Property parametro10() As String
        Get
            Return _parametro10
        End Get
        Set(ByVal Value As String)
            _parametro10 = Value
        End Set
    End Property
    Public Property parametro11() As String
        Get
            Return _parametro11
        End Get
        Set(ByVal Value As String)
            _parametro11 = Value
        End Set
    End Property
    Public Property parametro12() As String
        Get
            Return _parametro12
        End Get
        Set(ByVal Value As String)
            _parametro12 = Value
        End Set
    End Property
    Public Property parametro13() As String
        Get
            Return _parametro13
        End Get
        Set(ByVal Value As String)
            _parametro13 = Value
        End Set
    End Property
    Public Property parametro14() As String
        Get
            Return _parametro14
        End Get
        Set(ByVal Value As String)
            _parametro14 = Value
        End Set
    End Property
    Public Property parametro15() As String
        Get
            Return _parametro15
        End Get
        Set(ByVal Value As String)
            _parametro15 = Value
        End Set
    End Property
    Public Property parametro16() As String
        Get
            Return _parametro16
        End Get
        Set(ByVal Value As String)
            _parametro16 = Value
        End Set
    End Property
    Public Property parametro17() As String
        Get
            Return _parametro17
        End Get
        Set(ByVal Value As String)
            _parametro17 = Value
        End Set
    End Property
    Public Property parametro18() As String
        Get
            Return _parametro18
        End Get
        Set(ByVal Value As String)
            _parametro18 = Value
        End Set
    End Property
    Public Property parametro19() As String
        Get
            Return _parametro19
        End Get
        Set(ByVal Value As String)
            _parametro19 = Value
        End Set
    End Property
    Public Property parametro20() As String
        Get
            Return _parametro20
        End Get
        Set(ByVal Value As String)
            _parametro20 = Value
        End Set
    End Property
    Public Property strMensaje() As String
        Get
            Return _strMensaje
        End Get
        Set(ByVal Value As String)
            _strMensaje = Value
        End Set
    End Property

#End Region


End Class
