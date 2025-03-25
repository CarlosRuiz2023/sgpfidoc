Public Class JQGridItem
#Region "Passive attributes"
    Private _id As Long = 0
    Private _row As List(Of String)
#End Region

#Region "Properties"
    Public Property Id() As Long
        Get
            Return _id
        End Get
        Set(ByVal Value As Long)
            _id = Value
        End Set
    End Property
    Public Property row() As List(Of String)
        Get
            Return _row
        End Get
        Set(ByVal Value As List(Of String))
            _row = Value
        End Set
    End Property
#End Region

#Region "active attributes"

    Public Sub JQGridItem(pId As Long, pRow As List(Of String))
        _id = pId
        _row = pRow
    End Sub
#End Region
End Class

