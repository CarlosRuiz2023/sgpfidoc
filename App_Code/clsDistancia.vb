Imports System.Data
Imports System.Data.SqlClient

Public Class clsDistancia
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _Distancia As Decimal
    Private _Observaciones As String = String.Empty
    Private _CuentaP As String = String.Empty
    Private _Accion As String = String.Empty

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdSol() As String
        Get
            Return _IdSol
        End Get
        Set(ByVal Value As String)
            _IdSol = Value
        End Set
    End Property
    Public Property Distancia() As Decimal
        Get
            Return _Distancia
        End Get
        Set(ByVal Value As Decimal)
            _Distancia = Value
        End Set
    End Property
    Public Property Observaciones() As String
        Get
            Return _Observaciones
        End Get
        Set(ByVal Value As String)
            _Observaciones = Value
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
    Public Property CuentaP() As String
        Get
            Return _CuentaP
        End Get
        Set(ByVal Value As String)
            _CuentaP = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consulta(ByVal objDis As clsDistancia) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objDis._IdSol
        Dim Distancia As SqlParameter = New SqlParameter("@distancia", SqlDbType.Decimal, 10)
        Distancia.Value = objDis._Distancia
        Dim Observa As SqlParameter = New SqlParameter("@observa", SqlDbType.NVarChar, 255)
        Observa.Value = objDis._Observaciones
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objDis._Accion

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Distancia)
        params.Add(Observa)
        params.Add(Accion)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Distancia", params)
    End Function

    Public Shared Function Insertar(ByVal objDis As clsDistancia) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objDis._IdSol
        Dim Distancia As SqlParameter = New SqlParameter("@distancia", SqlDbType.Decimal, 10)
        Distancia.Value = objDis._Distancia
        Dim Observa As SqlParameter = New SqlParameter("@observa", SqlDbType.NVarChar, 255)
        Observa.Value = objDis._Observaciones
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objDis._Accion

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Distancia)
        params.Add(Observa)
        params.Add(Accion)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Distancia", params)
    End Function

    Public Shared Function Consulta_Metros(ByVal objDis As clsDistancia) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim CuentaP As SqlParameter = New SqlParameter("@cuentap", SqlDbType.NVarChar, 12)
        CuentaP.Value = objDis._CuentaP
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objDis._Accion

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(CuentaP)
        params.Add(Accion)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Distancia", params)
    End Function

    Public Shared Function ConsultaTotal(ByVal objDis As clsDistancia) As DataTable
        Dim strQuery As String = _
        "select sum(mCoopMetros) as total from mCooperadores where 1 = 1 and mSolId = " & objDis.IdSol
        Return conn.EjecutarConsulta3(strQuery)
    End Function

#End Region
End Class
