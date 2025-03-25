Public Class clsPobra

#Region "variables privadas"
    Private _oid As Integer = 0
    Private _tramo As String = String.Empty
    Private _calle As String = String.Empty
    Private _colonia As String = String.Empty
    Private _limite1 As String = String.Empty
    Private _limite2 As String = String.Empty

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property oid() As Integer
        Get
            Return _oid
        End Get
        Set(ByVal Value As Integer)
            _oid = Value
        End Set
    End Property

    Public Property tramo() As String
        Get
            Return _tramo
        End Get
        Set(ByVal Value As String)
            _tramo = Value
        End Set
    End Property

    Public Property calle() As String
        Get
            Return _calle
        End Get
        Set(ByVal Value As String)
            _calle = Value
        End Set
    End Property

    Public Property colonia() As String
        Get
            Return _colonia
        End Get
        Set(ByVal Value As String)
            _colonia = Value
        End Set
    End Property

    Public Property limite1() As String
        Get
            Return _limite1
        End Get
        Set(ByVal Value As String)
            _limite1 = Value
        End Set
    End Property

    Public Property limite2() As String
        Get
            Return _limite2
        End Get
        Set(ByVal Value As String)
            _limite2 = Value
        End Set
    End Property

#End Region

#Region "Metodos"




#End Region

End Class




