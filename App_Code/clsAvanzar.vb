Imports System.Data
Imports System.Data.SqlClient

Public Class clsAvanzar
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _IdEstatus As Integer = 0
    Private _Fecha As String = String.Empty
    Private _Opciones As String = String.Empty
    Private _Croquis As String = String.Empty
    Private _Observaciones As String = String.Empty
    Private _Usu As Integer = 0
    Private _Accion As String = String.Empty
    Private _Elabora As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _FecEntrega As Date
    Private _ADona As Integer = 0
    Private _Mas13 As Integer = 0
    Private _Tramo As String = String.Empty
    Private _OficioRM As String = String.Empty
    Private _FechaSRM As Date
    Private _FechaRRM As Date
    Private _OficioARM As String = String.Empty

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
    Public Property IdEstatus() As String
        Get
            Return _IdEstatus
        End Get
        Set(ByVal Value As String)
            _IdEstatus = Value
        End Set
    End Property
    Public Property Fecha() As String
        Get
            Return _Fecha
        End Get
        Set(ByVal Value As String)
            _Fecha = Value
        End Set
    End Property
    Public Property Opciones() As String
        Get
            Return _Opciones
        End Get
        Set(ByVal Value As String)
            _Opciones = Value
        End Set
    End Property
    Public Property Croquis() As String
        Get
            Return _Croquis
        End Get
        Set(ByVal Value As String)
            _Croquis = Value
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
    Public Property Usu() As Integer
        Get
            Return _Usu
        End Get
        Set(ByVal Value As Integer)
            _Usu = Value
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

    Public Property Elabora() As String
        Get
            Return _Elabora
        End Get
        Set(ByVal Value As String)
            _Elabora = Value
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

    Public Property FecEntrega() As Date
        Get
            Return _FecEntrega
        End Get
        Set(ByVal Value As Date)
            _FecEntrega = Value
        End Set
    End Property

    Public Property ADona() As Integer
        Get
            Return _ADona
        End Get
        Set(ByVal Value As Integer)
            _ADona = Value
        End Set
    End Property

    Public Property Mas13() As Integer
        Get
            Return _Mas13
        End Get
        Set(ByVal Value As Integer)
            _Mas13 = Value
        End Set
    End Property

    Public Property Tramo() As String
        Get
            Return _Tramo
        End Get
        Set(ByVal Value As String)
            _Tramo = Value
        End Set
    End Property

    Public Property OficioRM() As String
        Get
            Return _OficioRM
        End Get
        Set(ByVal Value As String)
            _OficioRM = Value
        End Set
    End Property

    Public Property FechaSRM() As Date
        Get
            Return _FechaSRM
        End Get
        Set(ByVal Value As Date)
            _FechaSRM = Value
        End Set
    End Property

    Public Property FechaRRM() As Date
        Get
            Return _FechaRRM
        End Get
        Set(ByVal Value As Date)
            _FechaRRM = Value
        End Set
    End Property

    Public Property OficioARM() As String
        Get
            Return _OficioARM
        End Get
        Set(ByVal Value As String)
            _OficioARM = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consulta(ByVal objAva As clsAvanzar) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objAva._IdSol
        Dim IdEstatus As SqlParameter = New SqlParameter("@idestatus", SqlDbType.Int, 6)
        IdEstatus.Value = objAva._IdEstatus
        Dim Fecha As SqlParameter = New SqlParameter("@fecha", SqlDbType.NVarChar, 15)
        Fecha.Value = objAva._Fecha
        Dim Opciones As SqlParameter = New SqlParameter("@opciones", SqlDbType.NVarChar, 150)
        Opciones.Value = objAva._Opciones
        Dim Croquis As SqlParameter = New SqlParameter("@croquis", SqlDbType.NVarChar, 250)
        Croquis.Value = objAva._Croquis
        Dim Observa As SqlParameter = New SqlParameter("@observa", SqlDbType.NVarChar, 255)
        Observa.Value = objAva._Observaciones
        Dim Usu As SqlParameter = New SqlParameter("@usu", SqlDbType.Int, 6)
        Usu.Value = objAva._Usu
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objAva._Accion
        Dim Elabora As SqlParameter = New SqlParameter("@elabora", SqlDbType.NVarChar, 50)
        Elabora.Value = objAva._Elabora
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objAva._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objAva._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objAva._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objAva._FecMod
        Dim FecEntrega As SqlParameter = New SqlParameter("@fecentrega", SqlDbType.Date, 10)
        FecEntrega.Value = objAva._FecEntrega
        Dim ADona As SqlParameter = New SqlParameter("@adona", SqlDbType.Int, 6)
        ADona.Value = objAva._ADona
        Dim Mas13 As SqlParameter = New SqlParameter("@mas13", SqlDbType.Int, 6)
        Mas13.Value = objAva._Mas13
        Dim Tramo As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 200)
        Tramo.Value = objAva._Tramo

        Dim OficioRM As SqlParameter = New SqlParameter("@oficiorm", SqlDbType.NVarChar, 50)
        OficioRM.Value = objAva._OficioRM
        Dim FechaSRM As SqlParameter = New SqlParameter("@fechasrm", SqlDbType.Date, 10)
        FechaSRM.Value = objAva._FechaSRM
        Dim FechaRRM As SqlParameter = New SqlParameter("@fecharrm", SqlDbType.Date, 10)
        FechaRRM.Value = objAva._FechaRRM
        Dim OficioARM As SqlParameter = New SqlParameter("@oficioarm", SqlDbType.NVarChar, 255)
        OficioARM.Value = objAva._OficioARM

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(IdEstatus)
        params.Add(Fecha)
        params.Add(Opciones)
        params.Add(Croquis)
        params.Add(Observa)
        params.Add(Usu)
        params.Add(Accion)
        params.Add(Elabora)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(FecEntrega)
        params.Add(ADona)
        params.Add(Mas13)
        params.Add(Tramo)
        params.Add(OficioRM)
        params.Add(FechaSRM)
        params.Add(FechaRRM)
        params.Add(OficioARM)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Avanzar", params)
    End Function

    Public Shared Function Insertar(ByVal objAva As clsAvanzar) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objAva._IdSol
        Dim IdEstatus As SqlParameter = New SqlParameter("@idestatus", SqlDbType.Int, 6)
        IdEstatus.Value = objAva._IdEstatus
        Dim Fecha As SqlParameter = New SqlParameter("@fecha", SqlDbType.Date, 15)
        Fecha.Value = objAva._Fecha
        Dim Opciones As SqlParameter = New SqlParameter("@opciones", SqlDbType.NVarChar, 150)
        Opciones.Value = objAva._Opciones
        Dim Croquis As SqlParameter = New SqlParameter("@croquis", SqlDbType.NVarChar, 250)
        Croquis.Value = objAva._Croquis
        Dim Observa As SqlParameter = New SqlParameter("@observa", SqlDbType.NVarChar, 255)
        Observa.Value = objAva._Observaciones
        Dim Usu As SqlParameter = New SqlParameter("@usu", SqlDbType.Int, 6)
        Usu.Value = objAva._Usu
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objAva._Accion
        Dim Elabora As SqlParameter = New SqlParameter("@elabora", SqlDbType.NVarChar, 50)
        Elabora.Value = objAva._Elabora
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objAva._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objAva._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objAva._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objAva._FecMod
        Dim FecEntrega As SqlParameter = New SqlParameter("@fecentrega", SqlDbType.Date, 10)
        FecEntrega.Value = objAva._FecEntrega
        Dim ADona As SqlParameter = New SqlParameter("@adona", SqlDbType.Int, 6)
        ADona.Value = objAva._ADona
        Dim Mas13 As SqlParameter = New SqlParameter("@mas13", SqlDbType.Int, 6)
        Mas13.Value = objAva._Mas13
        Dim Tramo As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 200)
        Tramo.Value = objAva._Tramo

        Dim OficioRM As SqlParameter = New SqlParameter("@oficiorm", SqlDbType.NVarChar, 50)
        OficioRM.Value = objAva._OficioRM
        Dim FechaSRM As SqlParameter = New SqlParameter("@fechasrm", SqlDbType.Date, 10)
        FechaSRM.Value = objAva._FechaSRM
        Dim FechaRRM As SqlParameter = New SqlParameter("@fecharrm", SqlDbType.Date, 10)
        FechaRRM.Value = objAva._FechaRRM
        Dim OficioARM As SqlParameter = New SqlParameter("@oficioarm", SqlDbType.NVarChar, 255)
        OficioARM.Value = objAva._OficioARM

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(IdEstatus)
        params.Add(Fecha)
        params.Add(Opciones)
        params.Add(Croquis)
        params.Add(Observa)
        params.Add(Usu)
        params.Add(Accion)
        params.Add(Elabora)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(FecEntrega)
        params.Add(ADona)
        params.Add(Mas13)
        params.Add(Tramo)
        params.Add(OficioRM)
        params.Add(FechaSRM)
        params.Add(FechaRRM)
        params.Add(OficioARM)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Avanzar", params)
    End Function

#End Region

End Class
