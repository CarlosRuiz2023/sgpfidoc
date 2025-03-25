Imports System.Data
Imports System.Data.SqlClient

Public Class clsAutorizar

#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _Accion As String = ""
    Private _Autoriza As Integer = 0

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

    Public Property Accion() As String
        Get
            Return _Accion
        End Get
        Set(ByVal Value As String)
            _Accion = Value
        End Set
    End Property

    Public Property Autoriza() As Integer
        Get
            Return _Autoriza
        End Get
        Set(ByVal Value As Integer)
            _Autoriza = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consulta(ByVal objAut As clsAutorizar) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objAut._IdSol

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objAut._Accion

        Dim autoriza As SqlParameter = New SqlParameter("@autoriza", SqlDbType.Int, 6)
        autoriza.Value = objAut._Autoriza

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Accion)
        params.Add(autoriza)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_AutorizarO", params)
    End Function

    Public Shared Function Insertar(ByVal objAut As clsAutorizar) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objAut._IdSol

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objAut._Accion

        Dim autoriza As SqlParameter = New SqlParameter("@autoriza", SqlDbType.Int, 6)
        autoriza.Value = objAut._Autoriza

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Accion)
        params.Add(autoriza)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_AutorizarO", params)
    End Function

    Public Shared Function Consultae(ByVal objAut As clsAutorizar) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objAut._IdSol

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objAut._Accion

        Dim autoriza As SqlParameter = New SqlParameter("@autoriza", SqlDbType.Int, 6)
        autoriza.Value = objAut._Autoriza

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Accion)
        params.Add(Autoriza)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_AutorizarO", params)
    End Function

#End Region

End Class
