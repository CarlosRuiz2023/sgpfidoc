

Public Class clsFrentePAE


#Region "variables privadas"
    Private _idpasopae As Integer = 0
    Private _fid As Integer = 0
    Private _fecimpdcto As Date
    Private _fecentdcto As Date
    Private _fecnotif As Date
    Private _ministro As Integer = 0
    Private _nomministro As String = String.Empty
    Private _obv As String = String.Empty
    Private _evidencia As String = String.Empty
    Private _estatus As Integer = 0
    Private _horanotif As String = String.Empty
    Private _suerteprinc As Double = 0
    Private _saldoparcial As Double = 0
    Private _factoract As Double = 0
    Private _sumapagos As Double = 0
    Private _nombrecoop As String = String.Empty
    Private _callenotif As String = String.Empty
    Private _colonianotif As String = String.Empty
    Private _numnotif As String = String.Empty
    Private _dirfirma As Integer = 0
    Private _nomdirector As String = String.Empty
    Private _archivofirma As String = String.Empty
    Private _accion As String = String.Empty                   'Variable para identificar la gestion del registro 0---->ALTA, 1 ----> EDITAR y 2 ----> BAJAR'

#End Region

#Region "Propiedades"
    Public Property idpasopae() As Integer
        Get
            Return _idpasopae
        End Get
        Set(ByVal Value As Integer)
            _idpasopae = Value
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
    Public Property fecimpdcto() As Date
        Get
            Return _fecimpdcto
        End Get
        Set(ByVal Value As Date)
            _fecimpdcto = Value
        End Set
    End Property
    Public Property fecentdcto() As Date
        Get
            Return _fecentdcto
        End Get
        Set(ByVal Value As Date)
            _fecentdcto = Value
        End Set
    End Property
    Public Property fecnotif() As Date
        Get
            Return _fecnotif
        End Get
        Set(ByVal Value As Date)
            _fecnotif = Value
        End Set
    End Property
    Public Property ministro() As Integer
        Get
            Return _ministro
        End Get
        Set(ByVal Value As Integer)
            _ministro = Value
        End Set
    End Property
    Public Property nomministro() As String
        Get
            Return _nomministro
        End Get
        Set(ByVal Value As String)
            _nomministro = Value
        End Set
    End Property

    Public Property obv() As String
        Get
            Return _obv
        End Get
        Set(ByVal Value As String)
            _obv = Value
        End Set
    End Property
    Public Property evidencia() As String
        Get
            Return _evidencia
        End Get
        Set(ByVal Value As String)
            _evidencia = Value
        End Set
    End Property
    Public Property estatus() As Integer
        Get
            Return _estatus
        End Get
        Set(ByVal Value As Integer)
            _estatus = Value
        End Set
    End Property
    Public Property horanotif() As String
        Get
            Return _horanotif
        End Get
        Set(ByVal Value As String)
            _horanotif = Value
        End Set
    End Property
    Public Property suerteprinc() As Double
        Get
            Return _suerteprinc
        End Get
        Set(ByVal Value As Double)
            _suerteprinc = Value
        End Set
    End Property
    Public Property saldoparcial() As Double
        Get
            Return _saldoparcial
        End Get
        Set(ByVal Value As Double)
            _saldoparcial = Value
        End Set
    End Property
    Public Property factoract() As Double
        Get
            Return _factoract
        End Get
        Set(ByVal Value As Double)
            _factoract = Value
        End Set
    End Property
    Public Property sumapagos() As Double
        Get
            Return _sumapagos
        End Get
        Set(ByVal Value As Double)
            _sumapagos = Value
        End Set
    End Property
    Public Property nombrecoop() As String
        Get
            Return _nombrecoop
        End Get
        Set(ByVal Value As String)
            _nombrecoop = Value
        End Set
    End Property
    Public Property callenotif() As String
        Get
            Return _callenotif
        End Get
        Set(ByVal Value As String)
            _callenotif = Value
        End Set
    End Property
    Public Property colonianotif() As String
        Get
            Return _colonianotif
        End Get
        Set(ByVal Value As String)
            _colonianotif = Value
        End Set
    End Property
    Public Property numnotif() As String
        Get
            Return _numnotif
        End Get
        Set(ByVal Value As String)
            _numnotif = Value
        End Set
    End Property
    Public Property dirfirma() As Integer
        Get
            Return _dirfirma
        End Get
        Set(ByVal Value As Integer)
            _dirfirma = Value
        End Set
    End Property
    Public Property nomdirector() As String
        Get
            Return _nomdirector
        End Get
        Set(ByVal Value As String)
            _nomdirector = Value
        End Set
    End Property
    Public Property archivofirma() As String
        Get
            Return _archivofirma
        End Get
        Set(ByVal Value As String)
            _archivofirma = Value
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

#End Region


End Class
