Imports System.Data
Imports System.Data.SqlClient

Public Class clsMonitoreo
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _FechaC1 As Date
    Private _FechaC2 As Date
    Private _FotoIO As String = String.Empty
    Private _FotoOC As String = String.Empty
    Private _Nota As String = String.Empty
    Private _Accion As String = String.Empty

    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _Avance As Integer = 0

    Private _ImagenProceso As String = String.Empty
    Private _ImagenTerminada As String = String.Empty

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

    Public Property FechaC1() As Date
        Get
            Return _FechaC1
        End Get
        Set(ByVal Value As Date)
            _FechaC1 = Value
        End Set
    End Property
    Public Property FechaC2() As Date
        Get
            Return _FechaC2
        End Get
        Set(ByVal Value As Date)
            _FechaC2 = Value
        End Set
    End Property
    Public Property FotoIO() As String
        Get
            Return _FotoIO
        End Get
        Set(ByVal Value As String)
            _FotoIO = Value
        End Set
    End Property
    Public Property FotoOC() As String
        Get
            Return _FotoOC
        End Get
        Set(ByVal Value As String)
            _FotoOC = Value
        End Set
    End Property
    Public Property Nota() As String
        Get
            Return _Nota
        End Get
        Set(ByVal Value As String)
            _Nota = Value
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

    Public Property Avance() As Integer
        Get
            Return _Avance
        End Get
        Set(ByVal Value As Integer)
            _Avance = Value
        End Set
    End Property

    Public Property ImagenProceso() As String
        Get
            Return _ImagenProceso
        End Get
        Set(ByVal Value As String)
            _ImagenProceso = Value
        End Set
    End Property

    Public Property ImagenTerminada() As String
        Get
            Return _ImagenTerminada
        End Get
        Set(ByVal Value As String)
            _ImagenTerminada = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consulta(ByVal objMon As clsMonitoreo) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objMon._IdSol
        Dim Fechac1 As SqlParameter = New SqlParameter("@fechac1", SqlDbType.Date, 10)
        Fechac1.Value = objMon._FechaC1
        Dim Fechac2 As SqlParameter = New SqlParameter("@fechac2", SqlDbType.Date, 10)
        Fechac2.Value = objMon._FechaC2
        Dim FotoIO As SqlParameter = New SqlParameter("@fotoio", SqlDbType.NVarChar, 250)
        FotoIO.Value = objMon._FotoIO
        Dim FotoOC As SqlParameter = New SqlParameter("@fotooc", SqlDbType.NVarChar, 250)
        FotoOC.Value = objMon._FotoOC
        Dim Nota As SqlParameter = New SqlParameter("@nota", SqlDbType.NVarChar, 250)
        Nota.Value = objMon._Nota
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objMon._Accion

        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objMon._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objMon._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objMon._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objMon._FecMod
        Dim Avance As SqlParameter = New SqlParameter("@avance", SqlDbType.Int, 6)
        Avance.Value = objMon._Avance
        Dim ImagenProceso As SqlParameter = New SqlParameter("@imagenproceso", SqlDbType.NVarChar, 250)
        ImagenProceso.Value = objMon._ImagenProceso
        Dim ImagenTerminada As SqlParameter = New SqlParameter("@imagenterminada", SqlDbType.NVarChar, 250)
        ImagenTerminada.Value = objMon._ImagenTerminada

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Fechac1)
        params.Add(Fechac2)
        params.Add(FotoIO)
        params.Add(FotoOC)
        params.Add(Nota)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Avance)
        params.Add(ImagenProceso)
        params.Add(ImagenTerminada)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Monitoreo", params)
    End Function

    Public Shared Function Insertar(ByVal objMon As clsMonitoreo) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objMon._IdSol
        Dim Fechac1 As SqlParameter = New SqlParameter("@fechac1", SqlDbType.Date, 10)
        Fechac1.Value = objMon._FechaC1
        Dim Fechac2 As SqlParameter = New SqlParameter("@fechac2", SqlDbType.Date, 10)
        Fechac2.Value = objMon._FechaC2
        Dim FotoIO As SqlParameter = New SqlParameter("@fotoio", SqlDbType.NVarChar, 200)
        FotoIO.Value = objMon._FotoIO
        Dim FotoOC As SqlParameter = New SqlParameter("@fotooc", SqlDbType.NVarChar, 5200)
        FotoOC.Value = objMon._FotoOC
        Dim Nota As SqlParameter = New SqlParameter("@nota", SqlDbType.NVarChar, 250)
        Nota.Value = objMon._Nota
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objMon._Accion

        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objMon._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objMon._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objMon._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objMon._FecMod
        Dim Avance As SqlParameter = New SqlParameter("@avance", SqlDbType.Int, 6)
        Avance.Value = objMon._Avance
        Dim ImagenProceso As SqlParameter = New SqlParameter("@imagenproceso", SqlDbType.NVarChar, 250)
        ImagenProceso.Value = objMon._ImagenProceso
        Dim ImagenTerminada As SqlParameter = New SqlParameter("@imagenterminada", SqlDbType.NVarChar, 250)
        ImagenTerminada.Value = objMon._ImagenTerminada

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Fechac1)
        params.Add(Fechac2)
        params.Add(FotoIO)
        params.Add(FotoOC)
        params.Add(Nota)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Avance)
        params.Add(ImagenProceso)
        params.Add(ImagenTerminada)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Monitoreo", params)
    End Function

#End Region

End Class
