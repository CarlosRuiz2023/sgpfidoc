Imports System.Data
Imports System.Data.SqlClient

Public Class clsIniObra
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _FechaI As Date
    Private _FechaT As Date
    Private _Licita As String = String.Empty
    Private _Asigna As String = String.Empty
    Private _Contrato As String = String.Empty
    Private _Importe As Decimal = 0
    Private _Contra As String = String.Empty
    Private _Superext As String = String.Empty
    Private _Superint As String = String.Empty
    Private _Accion As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _ImporteF As Decimal = 0

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

    Public Property FechaI() As Date
        Get
            Return _FechaI
        End Get
        Set(ByVal Value As Date)
            _FechaI = Value
        End Set
    End Property
    Public Property FechaT() As Date
        Get
            Return _FechaT
        End Get
        Set(ByVal Value As Date)
            _FechaT = Value
        End Set
    End Property
    Public Property Licita() As String
        Get
            Return _Licita
        End Get
        Set(ByVal Value As String)
            _Licita = Value
        End Set
    End Property
    Public Property Asigna() As String
        Get
            Return _Asigna
        End Get
        Set(ByVal Value As String)
            _Asigna = Value
        End Set
    End Property
    Public Property Contrato() As String
        Get
            Return _Contrato
        End Get
        Set(ByVal Value As String)
            _Contrato = Value
        End Set
    End Property

    Public Property Importe() As Decimal
        Get
            Return _Importe
        End Get
        Set(ByVal Value As Decimal)
            _Importe = Value
        End Set
    End Property

    Public Property Contra() As String
        Get
            Return _Contra
        End Get
        Set(ByVal Value As String)
            _Contra = Value
        End Set
    End Property

    Public Property Superext() As String
        Get
            Return _Superext
        End Get
        Set(ByVal Value As String)
            _Superext = Value
        End Set
    End Property

    Public Property Superint() As String
        Get
            Return _Superint
        End Get
        Set(ByVal Value As String)
            _Superint = Value
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

    Public Property ImporteF() As Decimal
        Get
            Return _ImporteF
        End Get
        Set(ByVal Value As Decimal)
            _ImporteF = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consulta(ByVal objIO As clsIniObra) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objIO._IdSol
        Dim FechaI As SqlParameter = New SqlParameter("@fechai", SqlDbType.Date, 15)
        FechaI.Value = objIO._FechaI
        Dim FechaT As SqlParameter = New SqlParameter("@fechat", SqlDbType.Date, 15)
        FechaT.Value = objIO._FechaT
        Dim Licita As SqlParameter = New SqlParameter("@licita", SqlDbType.NVarChar, 50)
        Licita.Value = objIO._Licita
        Dim Asigna As SqlParameter = New SqlParameter("@asigna", SqlDbType.NVarChar, 50)
        Asigna.Value = objIO._Asigna
        Dim Contrato As SqlParameter = New SqlParameter("@contrato", SqlDbType.NVarChar, 50)
        Contrato.Value = objIO._Contrato
        Dim Importe As SqlParameter = New SqlParameter("@importe", SqlDbType.Decimal, 10)
        Importe.Value = objIO._Importe
        Dim Contra As SqlParameter = New SqlParameter("@contra", SqlDbType.NVarChar, 50)
        Contra.Value = objIO._Contra
        Dim Superext As SqlParameter = New SqlParameter("@superext", SqlDbType.NVarChar, 50)
        Superext.Value = objIO._Superext
        Dim Superint As SqlParameter = New SqlParameter("@superint", SqlDbType.NVarChar, 50)
        Superint.Value = objIO._Superint
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objIO._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objIO._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objIO._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objIO._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objIO._FecMod
        Dim ImporteF As SqlParameter = New SqlParameter("@importef", SqlDbType.Decimal, 10)
        ImporteF.Value = objIO._ImporteF

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(FechaI)
        params.Add(FechaT)
        params.Add(Licita)
        params.Add(Asigna)
        params.Add(Contrato)
        params.Add(Importe)
        params.Add(Contra)
        params.Add(Superext)
        params.Add(Superint)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(ImporteF)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_IniObra", params)
    End Function

    Public Shared Function Insertar(ByVal objIO As clsIniObra) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objIO._IdSol
        Dim FechaI As SqlParameter = New SqlParameter("@fechai", SqlDbType.Date, 15)
        FechaI.Value = objIO._FechaI
        Dim FechaT As SqlParameter = New SqlParameter("@fechat", SqlDbType.Date, 15)
        FechaT.Value = objIO._FechaT
        Dim Licita As SqlParameter = New SqlParameter("@licita", SqlDbType.NVarChar, 50)
        Licita.Value = objIO._Licita
        Dim Asigna As SqlParameter = New SqlParameter("@asigna", SqlDbType.NVarChar, 50)
        Asigna.Value = objIO._Asigna
        Dim Contrato As SqlParameter = New SqlParameter("@contrato", SqlDbType.NVarChar, 50)
        Contrato.Value = objIO._Contrato
        Dim Importe As SqlParameter = New SqlParameter("@importe", SqlDbType.Decimal, 10)
        Importe.Value = objIO._Importe
        Dim Contra As SqlParameter = New SqlParameter("@contra", SqlDbType.NVarChar, 50)
        Contra.Value = objIO._Contra
        Dim Superext As SqlParameter = New SqlParameter("@superext", SqlDbType.NVarChar, 50)
        Superext.Value = objIO._Superext
        Dim Superint As SqlParameter = New SqlParameter("@superint", SqlDbType.NVarChar, 50)
        Superint.Value = objIO._Superint
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objIO._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objIO._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objIO._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objIO._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objIO._FecMod
        Dim ImporteF As SqlParameter = New SqlParameter("@importef", SqlDbType.Decimal, 10)
        ImporteF.Value = objIO._ImporteF

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(FechaI)
        params.Add(FechaT)
        params.Add(Licita)
        params.Add(Asigna)
        params.Add(Contrato)
        params.Add(Importe)
        params.Add(Contra)
        params.Add(Superext)
        params.Add(Superint)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(ImporteF)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_IniObra", params)
    End Function

#End Region

End Class
