Imports System.Data
Imports System.Data.SqlClient

Public Class clsExpJuridico
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _Accion As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _OfGE As String = String.Empty
    Private _OfCS As String = String.Empty
    Private _OfEst As String = String.Empty
    Private _POE As String = String.Empty
    Private _PLocal As String = String.Empty
    Private _POfAC As String = String.Empty
    Private _NCE As String = String.Empty
    Private _OfREst As String = String.Empty
    Private _ResCong As String = String.Empty
    Private _ExpJurFull As String = String.Empty

    Private _FecEGE As Date
    Private _FecRGE As Date
    Private _nooficioGE As String = String.Empty
    Private _FecECS As Date
    Private _FecRCS As Date
    Private _nooficioCS As String = String.Empty
    Private _FecEOE As Date
    Private _FecROE As Date
    Private _nooficioOE As String = String.Empty

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

    Public Property OfGE() As String
        Get
            Return _OfGE
        End Get
        Set(ByVal Value As String)
            _OfGE = Value
        End Set
    End Property

    Public Property OfCS() As String
        Get
            Return _OfCS
        End Get
        Set(ByVal Value As String)
            _OfCS = Value
        End Set
    End Property

    Public Property OfEst() As String
        Get
            Return _OfEst
        End Get
        Set(ByVal Value As String)
            _OfEst = Value
        End Set
    End Property

    Public Property POE() As String
        Get
            Return _POE
        End Get
        Set(ByVal Value As String)
            _POE = Value
        End Set
    End Property

    Public Property PLocal() As String
        Get
            Return _PLocal
        End Get
        Set(ByVal Value As String)
            _PLocal = Value
        End Set
    End Property

    Public Property POfAC() As String
        Get
            Return _POfAC
        End Get
        Set(ByVal Value As String)
            _POfAC = Value
        End Set
    End Property

    Public Property NCE() As String
        Get
            Return _NCE
        End Get
        Set(ByVal Value As String)
            _NCE = Value
        End Set
    End Property

    Public Property OfREst() As String
        Get
            Return _OfREst
        End Get
        Set(ByVal Value As String)
            _OfREst = Value
        End Set
    End Property

    Public Property ResCong() As String
        Get
            Return _ResCong
        End Get
        Set(ByVal Value As String)
            _ResCong = Value
        End Set
    End Property

    Public Property FecEGE() As Date
        Get
            Return _FecEGE
        End Get
        Set(ByVal Value As Date)
            _FecEGE = Value
        End Set
    End Property

    Public Property FecRGE() As Date
        Get
            Return _FecRGE
        End Get
        Set(ByVal Value As Date)
            _FecRGE = Value
        End Set
    End Property

    Public Property nooficioGE() As String
        Get
            Return _nooficioGE
        End Get
        Set(ByVal Value As String)
            _nooficioGE = Value
        End Set
    End Property

    Public Property FecECS() As Date
        Get
            Return _FecECS
        End Get
        Set(ByVal Value As Date)
            _FecECS = Value
        End Set
    End Property

    Public Property FecRCS() As Date
        Get
            Return _FecRCS
        End Get
        Set(ByVal Value As Date)
            _FecRCS = Value
        End Set
    End Property

    Public Property nooficioCS() As String
        Get
            Return _nooficioCS
        End Get
        Set(ByVal Value As String)
            _nooficioCS = Value
        End Set
    End Property


    Public Property FecEOE() As Date
        Get
            Return _FecEOE
        End Get
        Set(ByVal Value As Date)
            _FecEOE = Value
        End Set
    End Property

    Public Property FecROE() As Date
        Get
            Return _FecROE
        End Get
        Set(ByVal Value As Date)
            _FecROE = Value
        End Set
    End Property

    Public Property nooficioOE() As String
        Get
            Return _nooficioOE
        End Get
        Set(ByVal Value As String)
            _nooficioOE = Value
        End Set
    End Property

    Public Property ExpJurFull() As String
        Get
            Return _ExpJurFull
        End Get
        Set(ByVal Value As String)
            _ExpJurFull = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consulta(ByVal objExp As clsExpJuridico) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objExp._IdSol
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objExp._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 80)
        UsuCre.Value = objExp._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objExp._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 80)
        UsuMod.Value = objExp._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objExp._FecMod
        Dim OfGE As SqlParameter = New SqlParameter("@ofge", SqlDbType.NVarChar, 300)
        OfGE.Value = objExp._OfGE
        Dim OfCS As SqlParameter = New SqlParameter("@ofcs", SqlDbType.NVarChar, 300)
        OfCS.Value = objExp._OfCS
        Dim OfEst As SqlParameter = New SqlParameter("@ofest", SqlDbType.NVarChar, 300)
        OfEst.Value = objExp._OfEst
        Dim POE As SqlParameter = New SqlParameter("@poe", SqlDbType.NVarChar, 300)
        POE.Value = objExp._POE
        Dim PLocal As SqlParameter = New SqlParameter("@plocal", SqlDbType.NVarChar, 300)
        PLocal.Value = objExp._PLocal
        Dim POfAC As SqlParameter = New SqlParameter("@pofac", SqlDbType.NVarChar, 300)
        POfAC.Value = objExp._POfAC
        Dim NCE As SqlParameter = New SqlParameter("@nce", SqlDbType.NVarChar, 300)
        NCE.Value = objExp._NCE
        Dim OfREst As SqlParameter = New SqlParameter("@ofrest", SqlDbType.NVarChar, 300)
        OfREst.Value = objExp._OfREst
        Dim ResCong As SqlParameter = New SqlParameter("@rescong", SqlDbType.NVarChar, 300)
        ResCong.Value = objExp._ResCong

        Dim FecEGE As SqlParameter = New SqlParameter("@FecEGE", SqlDbType.Date, 10)
        FecEGE.Value = objExp._FecEGE
        Dim FecRGE As SqlParameter = New SqlParameter("@FecRGE", SqlDbType.Date, 10)
        FecRGE.Value = objExp._FecRGE
        Dim nooficioGE As SqlParameter = New SqlParameter("@nooficioGE", SqlDbType.NVarChar, 30)
        nooficioGE.Value = objExp._nooficioGE
        Dim FecECS As SqlParameter = New SqlParameter("@FecECS", SqlDbType.Date, 10)
        FecECS.Value = objExp._FecECS
        Dim FecRCS As SqlParameter = New SqlParameter("@FecRCS", SqlDbType.Date, 10)
        FecRCS.Value = objExp._FecRCS
        Dim nooficioCS As SqlParameter = New SqlParameter("@nooficioCS", SqlDbType.NVarChar, 30)
        nooficioCS.Value = objExp._nooficioCS
        Dim FecEOE As SqlParameter = New SqlParameter("@FecEOE", SqlDbType.Date, 10)
        FecEOE.Value = objExp._FecEOE
        Dim FecROE As SqlParameter = New SqlParameter("@FecROE", SqlDbType.Date, 10)
        FecROE.Value = objExp._FecROE
        Dim nooficioOE As SqlParameter = New SqlParameter("@nooficioOE", SqlDbType.NVarChar, 30)
        nooficioOE.Value = objExp._nooficioOE
        Dim ExpJurFull As SqlParameter = New SqlParameter("@ExpJurFull", SqlDbType.NVarChar, 50)
        ExpJurFull.Value = objExp._ExpJurFull

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(OfGE)
        params.Add(OfCS)
        params.Add(OfEst)
        params.Add(POE)
        params.Add(PLocal)
        params.Add(POfAC)
        params.Add(NCE)
        params.Add(OfREst)
        params.Add(ResCong)

        params.Add(FecEGE)
        params.Add(FecRGE)
        params.Add(nooficioGE)
        params.Add(FecECS)
        params.Add(FecRCS)
        params.Add(nooficioCS)
        params.Add(FecEOE)
        params.Add(FecROE)
        params.Add(nooficioOE)
        params.Add(ExpJurFull)


        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_ExpJuridico", params)
    End Function

    Public Shared Function Insertar(ByVal objExp As clsExpJuridico) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objExp._IdSol
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objExp._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 80)
        UsuCre.Value = objExp._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objExp._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 80)
        UsuMod.Value = objExp._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objExp._FecMod
        Dim OfGE As SqlParameter = New SqlParameter("@ofge", SqlDbType.NVarChar, 300)
        OfGE.Value = objExp._OfGE
        Dim OfCS As SqlParameter = New SqlParameter("@ofcs", SqlDbType.NVarChar, 300)
        OfCS.Value = objExp._OfCS
        Dim OfEst As SqlParameter = New SqlParameter("@ofest", SqlDbType.NVarChar, 300)
        OfEst.Value = objExp._OfEst
        Dim POE As SqlParameter = New SqlParameter("@poe", SqlDbType.NVarChar, 300)
        POE.Value = objExp._POE
        Dim PLocal As SqlParameter = New SqlParameter("@plocal", SqlDbType.NVarChar, 300)
        PLocal.Value = objExp._PLocal
        Dim POfAC As SqlParameter = New SqlParameter("@pofac", SqlDbType.NVarChar, 300)
        POfAC.Value = objExp._POfAC
        Dim NCE As SqlParameter = New SqlParameter("@nce", SqlDbType.NVarChar, 300)
        NCE.Value = objExp._NCE
        Dim OfREst As SqlParameter = New SqlParameter("@ofrest", SqlDbType.NVarChar, 300)
        OfREst.Value = objExp._OfREst
        Dim ResCong As SqlParameter = New SqlParameter("@rescong", SqlDbType.NVarChar, 300)
        ResCong.Value = objExp._ResCong

        Dim FecEGE As SqlParameter = New SqlParameter("@FecEGE", SqlDbType.Date, 10)
        FecEGE.Value = objExp._FecEGE
        Dim FecRGE As SqlParameter = New SqlParameter("@FecRGE", SqlDbType.Date, 10)
        FecRGE.Value = objExp._FecRGE
        Dim nooficioGE As SqlParameter = New SqlParameter("@nooficioGE", SqlDbType.NVarChar, 30)
        nooficioGE.Value = objExp._nooficioGE
        Dim FecECS As SqlParameter = New SqlParameter("@FecECS", SqlDbType.Date, 10)
        FecECS.Value = objExp._FecECS
        Dim FecRCS As SqlParameter = New SqlParameter("@FecRCS", SqlDbType.Date, 10)
        FecRCS.Value = objExp._FecRCS
        Dim nooficioCS As SqlParameter = New SqlParameter("@nooficioCS", SqlDbType.NVarChar, 30)
        nooficioCS.Value = objExp._nooficioCS
        Dim FecEOE As SqlParameter = New SqlParameter("@FecEOE", SqlDbType.Date, 10)
        FecEOE.Value = objExp._FecEOE
        Dim FecROE As SqlParameter = New SqlParameter("@FecROE", SqlDbType.Date, 10)
        FecROE.Value = objExp._FecROE
        Dim nooficioOE As SqlParameter = New SqlParameter("@nooficioOE", SqlDbType.NVarChar, 30)
        nooficioOE.Value = objExp._nooficioOE
        Dim ExpJurFull As SqlParameter = New SqlParameter("@ExpJurFull", SqlDbType.NVarChar, 50)
        ExpJurFull.Value = objExp._ExpJurFull

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(OfGE)
        params.Add(OfCS)
        params.Add(OfEst)
        params.Add(POE)
        params.Add(PLocal)
        params.Add(POfAC)
        params.Add(NCE)
        params.Add(OfREst)
        params.Add(ResCong)

        params.Add(FecEGE)
        params.Add(FecRGE)
        params.Add(nooficioGE)
        params.Add(FecECS)
        params.Add(FecRCS)
        params.Add(nooficioCS)
        params.Add(FecEOE)
        params.Add(FecROE)
        params.Add(nooficioOE)
        params.Add(ExpJurFull)
        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_ExpJuridico", params)
    End Function

#End Region
End Class
