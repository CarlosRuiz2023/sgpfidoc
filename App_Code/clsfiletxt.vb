Public Class clsfiletxt




#Region "variables privadas"
    Private _contenido As String = String.Empty
    Private _accion As String = String.Empty
#End Region

#Region "Propiedades"
    Public Property contenido() As String
        Get
            Return _contenido
        End Get
        Set(ByVal Value As String)
            _contenido = Value
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

#Region "Metodos"



#End Region
End Class
