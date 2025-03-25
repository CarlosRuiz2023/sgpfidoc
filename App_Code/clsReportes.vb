Imports System.Data
Imports System.Data.SqlClient

Public Class clsReportes
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _Fecha1 As Date
    Private _Fecha2 As Date
    Private _Fecha3 As Date
    Private _Fecha4 As Date
    Private _SECFNO As Integer = 0
    Private _SSCFNO As Integer = 0
    Private _CLACNO As Integer = 0
    Private _Nombre As String = String.Empty
    Private _Tramo As String = String.Empty
    Private _Accion As String = String.Empty
    Private _Calle As String = String.Empty
    Private _Col As String = String.Empty
    Private _idprog As Integer = 0
    Private _Sifidoc As String = String.Empty

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

    Public Property Fecha1() As Date
        Get
            Return _Fecha1
        End Get
        Set(ByVal Value As Date)
            _Fecha1 = Value
        End Set
    End Property

    Public Property Fecha2() As Date
        Get
            Return _Fecha2
        End Get
        Set(ByVal Value As Date)
            _Fecha2 = Value
        End Set
    End Property

    Public Property Fecha3() As Date
        Get
            Return _Fecha3
        End Get
        Set(ByVal Value As Date)
            _Fecha3 = Value
        End Set
    End Property

    Public Property Fecha4() As Date
        Get
            Return _Fecha4
        End Get
        Set(ByVal Value As Date)
            _Fecha4 = Value
        End Set
    End Property
    Public Property SECFNO() As String
        Get
            Return _SECFNO
        End Get
        Set(ByVal Value As String)
            _SECFNO = Value
        End Set
    End Property
    Public Property SSCFNO() As String
        Get
            Return _SSCFNO
        End Get
        Set(ByVal Value As String)
            _SSCFNO = Value
        End Set
    End Property
    Public Property CLACNO() As String
        Get
            Return _CLACNO
        End Get
        Set(ByVal Value As String)
            _CLACNO = Value
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

    Public Property Accion() As String
        Get
            Return _Accion
        End Get
        Set(ByVal Value As String)
            _Accion = Value
        End Set
    End Property

    Public Property Nombre() As String
        Get
            Return _Nombre
        End Get
        Set(ByVal Value As String)
            _Nombre = Value
        End Set
    End Property

    Public Property Calle() As String
        Get
            Return _Calle
        End Get
        Set(ByVal Value As String)
            _Calle = Value
        End Set
    End Property
    Public Property Col() As String
        Get
            Return _Col
        End Get
        Set(ByVal Value As String)
            _Col = Value
        End Set
    End Property

    Public Property IdProg() As Integer
        Get
            Return _idprog
        End Get
        Set(ByVal Value As Integer)
            _idprog = Value
        End Set
    End Property

    Public Property Sifidoc() As String
        Get
            Return _Sifidoc
        End Get
        Set(ByVal Value As String)
            _Sifidoc = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consulta(ByVal objRep As clsReportes) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objRep._IdSol
        Dim Fecha1 As SqlParameter = New SqlParameter("@fecha1", SqlDbType.Date, 10)
        Fecha1.Value = objRep._Fecha1
        Dim Fecha2 As SqlParameter = New SqlParameter("@fecha2", SqlDbType.Date, 10)
        Fecha2.Value = objRep._Fecha2
        Dim Fecha3 As SqlParameter = New SqlParameter("@fecha3", SqlDbType.Date, 10)
        Fecha3.Value = objRep._Fecha3
        Dim Fecha4 As SqlParameter = New SqlParameter("@fecha4", SqlDbType.Date, 10)
        Fecha4.Value = objRep._Fecha4
        Dim SECFNO As SqlParameter = New SqlParameter("@SECFNO", SqlDbType.Int, 6)
        SECFNO.Value = objRep._SECFNO
        Dim SSCFNO As SqlParameter = New SqlParameter("@SSCFNO", SqlDbType.Int, 6)
        SSCFNO.Value = objRep._SSCFNO
        Dim CLACNO As SqlParameter = New SqlParameter("@CLACNO", SqlDbType.Int, 6)
        CLACNO.Value = objRep._CLACNO
        Dim Tramo As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 200)
        Tramo.Value = objRep._Tramo
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 30)
        Nombre.Value = objRep._Nombre
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 20)
        Accion.Value = objRep._Accion
        Dim Calle As SqlParameter = New SqlParameter("@calle", SqlDbType.NVarChar, 150)
        Calle.Value = objRep._Calle
        Dim Col As SqlParameter = New SqlParameter("@col", SqlDbType.NVarChar, 150)
        Col.Value = objRep._Col
        Dim Sifidoc As SqlParameter = New SqlParameter("@sifidoc", SqlDbType.NVarChar, 30)
        Sifidoc.Value = objRep._Sifidoc

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(Fecha1)
        params.Add(Fecha2)
        params.Add(Fecha3)
        params.Add(Fecha4)
        params.Add(SECFNO)
        params.Add(SSCFNO)
        params.Add(CLACNO)
        params.Add(Tramo)
        params.Add(Nombre)
        params.Add(Accion)
        params.Add(Calle)
        params.Add(Col)
        params.Add(Sifidoc)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Reportes", params)
    End Function

    Public Shared Function solicitudes(ByVal objRep As clsReportes) As DataTable
        Dim strQuery As String = _
        "select s.mSolId, s.mSolCalle,s.mSolColonia,s.mSolTramo,s.mSolNombre, s.mSolFecha, an.mAnuEstatus, " & _
        "s.cEstatusSolicitud, e.cEstDescripcion, p.mSapalEstatus, d.mDUEstatus,s.mSolTramoO,f.mSFecA,(select min(mFFecha) as fecha from mEFichas  where msolId = s.mSolId) as mFFecha, " & _
        "(select min(mFPlazo) as fecha from mEFichas  where msolId = s.mSolId) as mFPlazo, ini.mIOFecI " & _
        "from mSolicitudes s " & _
        "left join mAnuencia an on s.mSolId = an.mSolId " & _
        "left join mDU d on s.mSolId = d.mSolId " & _
        "left join mSapal p on s.mSolId = p.mSolId " & _
        "left join cEstatusSolicitud e on s.cEstatusSolicitud = e.cEstId " & _
        "left join mSFidoc f on f.mSolId = s.mSolId " & _
        "left join mIniObra ini on ini.mSolId = s.mSolId " & _
        "group by s.mSolId, s.mSolCalle,s.mSolColonia,s.mSolTramo,s.mSolNombre, s.mSolFecha, an.mAnuEstatus, " & _
        "s.cEstatusSolicitud, e.cEstDescripcion, p.mSapalEstatus, d.mDUEstatus,s.mSolTramoO,f.mSFecA, ini.mIOFecI " & _
        "order by s.mSolId asc, s.mSolFecha desc "
        Return conn.EjecutarConsultaO(strQuery)
    End Function

    Public Shared Function solicitudesRF(ByVal objRep As clsReportes) As DataTable
        Dim strQuery As String = _
        "select s.mSolId, s.mSolSECFNO, s.mSolSSCFNO,s.mSolCLACNO,s.mSolTramo,s.mSolNombre, s.mSolFecha, " & _
        "s.cEstatusSolicitud, e.cEstDescripcion, s.mSolTramoO, f.mSFecA, p.mPOFecS, p.mPoFecE, c.mPCFec, c.mPCEstatus, " & _
        "i.mIOFecI, i.mIOFecT, en.mEOFechaE " & _
        "from mSolicitudes s " & _
        "left join cEstatusSolicitud e on s.cEstatusSolicitud = e.cEstId " & _
        "left join mSFidoc f on f.mSolId = s.mSolId " & _
        "left join mPOP p on p.msolId = s.mSolId " & _
        "left join mPComite c on c.msolid = s.msolId " & _
        "left join mIniObra i on i.msolid = s.msolid " & _
        "left join mEntregaObra en on en.msolid = s.msolid " & _
        "group by s.mSolId, s.mSolSECFNO, s.mSolSSCFNO,s.mSolCLACNO,s.mSolTramo,s.mSolNombre, s.mSolFecha, " & _
        "s.cEstatusSolicitud, e.cEstDescripcion, s.mSolTramoO, f.mSFecA, p.mPOFecS, p.mPoFecE, c.mPCFec, c.mPCEstatus, " & _
        "i.mIOFecI, i.mIOFecT, en.mEOFechaE " & _
        "order by s.mSolId asc, s.mSolFecha desc "
        Return conn.EjecutarConsultaO(strQuery)
    End Function

    Public Shared Function solicitudesExp(ByVal objRep As clsReportes) As DataTable
        Dim strQuery As String = _
        "select * from vw_exp_tecnico where mSolId=" & objRep._IdSol & ""
        Return conn.EjecutarConsultaO(strQuery)
    End Function

    Public Shared Function callesv(ByVal objRep As clsReportes) As DataTable
        Dim strQuery As String = _
        "select s.mSolId, s.mSolCalle,s.mSolColonia,s.mSolTramo,s.mSolNombre, s.mSolFecha, " & _
        "s.cEstatusSolicitud, e.cEstDescripcion, f.mFFecha, f.mFPlazo " & _
        "from mSolicitudes s " & _
        "left join cEstatusSolicitud e on s.cEstatusSolicitud = e.cEstId " & _
        "left join mEFichas f on f.mSolId = s.mSolId " & _
        "group by s.mSolId, s.mSolCalle,s.mSolColonia,s.mSolTramo,s.mSolNombre, s.mSolFecha, " & _
        "s.cEstatusSolicitud, e.cEstDescripcion, f.mFFecha, f.mFPlazo " & _
        "order by s.mSolId asc, s.mSolFecha desc "
        Return conn.EjecutarConsultaO(strQuery)
    End Function

    Public Shared Function programa(ByVal objRep As clsReportes) As DataTable
        Dim strQuery As String = _
        "select cProgNombre from cProgramas where cProgID=" & objRep._idprog & ""
        Return conn.EjecutarConsultaO(strQuery)
    End Function
#End Region
End Class
