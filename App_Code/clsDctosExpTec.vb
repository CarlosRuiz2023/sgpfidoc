Imports System.Data
Imports System.Data.SqlClient

Public Class clsDctosExpTec
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _NoObra As String = String.Empty
    Private _Calle As String = String.Empty
    Private _Accion As String = String.Empty
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"

    Public Property IdSol() As Integer
        Get
            Return _IdSol
        End Get
        Set(ByVal Value As Integer)
            _IdSol = Value
        End Set
    End Property
    Property NoObra As String
        Get
            Return _NoObra
        End Get
        Set(value As String)
            _NoObra = value
        End Set
    End Property
    Property Calle As String
        Get
            Return _Calle
        End Get
        Set(value As String)
            _Calle = value
        End Set
    End Property
    Property Accion As String
        Get
            Return _Accion
        End Get
        Set(value As String)
            _Accion = value
        End Set
    End Property
    Property Mensaje() As String
        ' la parte Get es la que devuelve el valor de la propiedad
        Get
            Return strMensaje
        End Get
        ' la parte Set es la que se usa al asignar el nuevo valor
        Set(ByVal Value As String)
            If Value <> "" Then
                strMensaje = Value
            End If
        End Set
    End Property



#End Region

#Region "Metodos"
    Public Shared Function Consulta(ByVal objDctosExpTec As clsDctosExpTec, ByRef tbl As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@IdSol", SqlDbType.Int, 6)
        IdSol.Value = objDctosExpTec._IdSol
        Dim Calle As SqlParameter = New SqlParameter("@Calle", SqlDbType.NVarChar, 100)
        Calle.Value = objDctosExpTec._Calle
        Dim NoObra As SqlParameter = New SqlParameter("@NoObra", SqlDbType.NVarChar, 10)
        NoObra.Value = objDctosExpTec._NoObra
        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 10)
        Accion.Value = objDctosExpTec._Accion
        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo

        params.Add(IdSol)

        params.Add(Calle)
        params.Add(NoObra)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)


        '-------------------------Invoca la función para ejecutar el SP

        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_DctosExpTec", params, objDctosExpTec.Mensaje, tbl)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objDctosExpTec.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objDctosExpTec.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objDctosExpTec.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objDctosExpTec.strMensaje = intError & " - " & objDctosExpTec.strMensaje
            End Select
            Return False
        Else
            objDctosExpTec.strMensaje = "OK"
            Return True
        End If
    End Function

#End Region
End Class
