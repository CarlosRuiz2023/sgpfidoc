Public Class clsPublicacion
#Region "variables privadas"
    Private _oid As Integer
    Private _fecpub As String = String.Empty
    Private _evidencia As String = String.Empty
    Private _accionpub As Integer
    Private _accion As Integer
    Private _strMensaje As String = String.Empty
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
    Public Property fecpub() As String
        Get
            Return _fecpub
        End Get
        Set(ByVal Value As String)
            _fecpub = Value
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
    Property accionpub As Integer
        Get
            Return _accionpub
        End Get
        Set(value As Integer)
            _accionpub = value
        End Set
    End Property
    Property accion As Integer
        Get
            Return _accion
        End Get
        Set(value As Integer)
            _accion = value
        End Set
    End Property
    Property strmensaje() As String
        ' la parte Get es la que devuelve el valor de la propiedad
        Get
            Return _strMensaje
        End Get
        ' la parte Set es la que se usa al asignar el nuevo valor
        Set(ByVal Value As String)
            If Value <> "" Then
                _strMensaje = Value
            End If
        End Set
    End Property
#End Region

#Region "Metodos"



#End Region

End Class
