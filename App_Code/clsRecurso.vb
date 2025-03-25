Imports System.Data
Imports System.Data.SqlClient

Public Class clsRecurso
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _RId As Integer = 0
    Private _ROId As Integer = 0
    Private _RNombre As String = String.Empty
    Private _RMonto As Decimal
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date

    Private _Accion As String = String.Empty

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

    Public Property RId() As Integer
        Get
            Return _RId
        End Get
        Set(ByVal Value As Integer)
            _RId = Value
        End Set
    End Property

    Public Property ROId() As Integer
        Get
            Return _ROId
        End Get
        Set(ByVal Value As Integer)
            _ROId = Value
        End Set
    End Property

    Public Property RNombre() As String
        Get
            Return _RNombre
        End Get
        Set(ByVal Value As String)
            _RNombre = Value
        End Set
    End Property

    Public Property RMonto() As Decimal
        Get
            Return _RMonto
        End Get
        Set(ByVal Value As Decimal)
            _RMonto = Value
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

    Public Property UsuCre() As String
        Get
            Return _UsuCre
        End Get
        Set(ByVal Value As String)
            _UsuCre = Value
        End Set
    End Property

    Public Property FecCre() As Date
        Get
            Return _FecCre
        End Get
        Set(ByVal Value As Date)
            _FecCre = Value
        End Set
    End Property

    Public Property UsuMod() As String
        Get
            Return _UsuMod
        End Get
        Set(ByVal Value As String)
            _UsuMod = Value
        End Set
    End Property

    Public Property FecMod() As Date
        Get
            Return _FecMod
        End Get
        Set(ByVal Value As Date)
            _FecMod = Value
        End Set
    End Property

#End Region

#Region "Metodos"
    Public Shared Function Consultar(ByVal objRec As clsRecurso) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objRec._IdSol
        Dim RId As SqlParameter = New SqlParameter("@rid", SqlDbType.Int, 6)
        RId.Value = objRec._RId
        Dim ROId As SqlParameter = New SqlParameter("@roid", SqlDbType.Int, 6)
        ROId.Value = objRec._ROId

        Dim RNombre As SqlParameter = New SqlParameter("@rnombre", SqlDbType.NVarChar, 50)
        RNombre.Value = objRec._RNombre
        Dim RMonto As SqlParameter = New SqlParameter("@rmonto", SqlDbType.Decimal, 10)
        RMonto.Value = objRec._RMonto

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 20)
        Accion.Value = objRec._Accion

        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objRec._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objRec._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objRec._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objRec._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(RId)
        params.Add(ROId)
        params.Add(RNombre)
        params.Add(RMonto)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Recurso", params)
    End Function

    Public Shared Function Insertar(ByVal objRec As clsRecurso) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objRec._IdSol
        Dim RId As SqlParameter = New SqlParameter("@rid", SqlDbType.Int, 6)
        RId.Value = objRec._RId
        Dim ROId As SqlParameter = New SqlParameter("@roid", SqlDbType.Int, 6)
        ROId.Value = objRec._ROId

        Dim RNombre As SqlParameter = New SqlParameter("@rnombre", SqlDbType.NVarChar, 50)
        RNombre.Value = objRec._RNombre
        Dim RMonto As SqlParameter = New SqlParameter("@rmonto", SqlDbType.Decimal, 10)
        RMonto.Value = objRec._RMonto

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 20)
        Accion.Value = objRec._Accion

        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objRec._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objRec._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objRec._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objRec._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(RId)
        params.Add(ROId)
        params.Add(RNombre)
        params.Add(RMonto)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Recurso", params)
    End Function

    Public Shared Function Total(ByVal objRec As clsRecurso) As DataTable
        Dim strQuery As String = _
       "SELECT CAST(r.mRMun AS NUMERIC(10,2))+ CAST(r.mREst AS NUMERIC(10,2)) + CAST(r.mRFed AS NUMERIC(10,2)) + CAST(r.mRFidoc AS NUMERIC(10,2)) + (select ISNULL(sum(mRFMonto),0) from  mRecursoF where mSolId =  " & objRec.IdSol & " )" & _
        "FROM mRecurso as r " & _
        "where r.mSolId = " & objRec.IdSol & " " & _
        "group by r.mRmun, r.mrest,r.mrfed,r.mrfidoc"
        Return conn.EjecutarConsultaO(strQuery)
    End Function

#End Region

End Class

