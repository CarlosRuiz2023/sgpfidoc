Imports System.Data
Imports System.Data.SqlClient

Public Class clsNomRecurso

#Region "variables privadas"
    Private _IdNomRec As Integer = 0
    Private _Nombre As String = String.Empty
    Private _Accion As String = String.Empty

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdNomRec() As Integer
        Get
            Return _IdNomRec
        End Get
        Set(ByVal Value As Integer)
            _IdNomRec = Value
        End Set
    End Property

    Public Property Nombre() As Integer
        Get
            Return _Nombre
        End Get
        Set(ByVal Value As Integer)
            _Nombre = Value
        End Set
    End Property

    Public Property Accion() As String
        Get
            Return _Accion
        End Get
        Set(ByVal Value As String)
            _Accion = Value
        End Set
    End Property

#End Region

#Region "Metodos"
    Public Shared Function Consulta(ByVal objRec As clsNomRecurso) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdNomRec As SqlParameter = New SqlParameter("@idrecurso", SqlDbType.Int, 6)
        IdNomRec.Value = objRec._IdNomRec
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 50)
        Nombre.Value = objRec._Nombre
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objRec._Accion

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdNomRec)
        params.Add(Nombre)

        params.Add(Accion)
        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_NomRecurso", params)
    End Function

    Public Shared Function Insertar(ByVal objRec As clsNomRecurso) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdNomRec As SqlParameter = New SqlParameter("@idrecurso", SqlDbType.Int, 6)
        IdNomRec.Value = objRec._IdNomRec
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 50)
        Nombre.Value = objRec._Nombre
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objRec._Accion

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdNomRec)
        params.Add(Nombre)

        params.Add(Accion)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_NomRecurso", params)
    End Function

#End Region
End Class

