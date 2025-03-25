Imports System.Data
Imports System.Data.SqlClient

Public Class clsMovimientos
#Region "variables privadas"
    Private _IdSol As Integer = 0

    Private _FId As Integer = 0
    Private _FFecha As Date
    Private _FPlazo As String = String.Empty
    Private _FCoop As Integer = 0
    Private _FEntrega As String = String.Empty

    Private _SId As Integer = 0
    Private _SFecS As Date
    Private _SFecA As Date
    Private _SProm As String = String.Empty
    Private _SObra As String = String.Empty
    Private _SPredios As String = String.Empty
    Private _SPredDesc As String = String.Empty

    Private _APId As Integer = 0
    Private _APFecha As Date
    Private _APMonto As String = String.Empty
    Private _APAvance As String = String.Empty

    Private _POId As Integer = 0
    Private _POFecS As Date
    Private _POFecE As Date
    Private _POEst As String = String.Empty
    Private _POOficio As String = String.Empty
    Private _POAvance As String = String.Empty
    Private _POCosto As String = String.Empty
    Private _POOficioR As String = String.Empty

    Private _PCId As Integer = 0
    Private _PCFecS As Date
    Private _PCNum As String = String.Empty
    Private _PCEst As String = String.Empty
    Private _PCInciso As String = String.Empty

    Private _RId As Integer = 0
    Private _RMun As Decimal
    Private _REst As Decimal
    Private _RFed As Decimal
    Private _ROtro As String = String.Empty
    Private _RMOtro As Decimal
    Private _RFidoc As Decimal

    Private _Documento As String = String.Empty

    Private _Accion As String = String.Empty

    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property FId() As Integer
        Get
            Return _FId
        End Get
        Set(ByVal Value As Integer)
            _FId = Value
        End Set
    End Property

    Public Property IdSol() As Integer
        Get
            Return _IdSol
        End Get
        Set(ByVal Value As Integer)
            _IdSol = Value
        End Set
    End Property
    Public Property FFecha() As Date
        Get
            Return _FFecha
        End Get
        Set(ByVal Value As Date)
            _FFecha = Value
        End Set
    End Property
    Public Property FPlazo() As String
        Get
            Return _FPlazo
        End Get
        Set(ByVal Value As String)
            _FPlazo = Value
        End Set
    End Property
    Public Property FCoop() As Integer
        Get
            Return _FCoop
        End Get
        Set(ByVal Value As Integer)
            _FCoop = Value
        End Set
    End Property
    Public Property FEntrega() As String
        Get
            Return _FEntrega
        End Get
        Set(ByVal Value As String)
            _FEntrega = Value
        End Set
    End Property

    Public Property SId() As Integer
        Get
            Return _SId
        End Get
        Set(ByVal Value As Integer)
            _SId = Value
        End Set
    End Property

    Public Property SFecS() As Date
        Get
            Return _SFecS
        End Get
        Set(ByVal Value As Date)
            _SFecS = Value
        End Set
    End Property

    Public Property SFecA() As Date
        Get
            Return _SFecA
        End Get
        Set(ByVal Value As Date)
            _SFecA = Value
        End Set
    End Property

    Public Property SProm() As String
        Get
            Return _SProm
        End Get
        Set(ByVal Value As String)
            _SProm = Value
        End Set
    End Property

    Public Property SObra() As String
        Get
            Return _SObra
        End Get
        Set(ByVal Value As String)
            _SObra = Value
        End Set
    End Property

    Public Property SPredios() As String
        Get
            Return _SPredios
        End Get
        Set(ByVal Value As String)
            _SPredios = Value
        End Set
    End Property

    Public Property SPredDesc() As String
        Get
            Return _SPredDesc
        End Get
        Set(ByVal Value As String)
            _SPredDesc = Value
        End Set
    End Property

    Public Property APId() As Integer
        Get
            Return _APId
        End Get
        Set(ByVal Value As Integer)
            _APId = Value
        End Set
    End Property
    Public Property APFecha() As Date
        Get
            Return _APFecha
        End Get
        Set(ByVal Value As Date)
            _APFecha = Value
        End Set
    End Property

    Public Property APMonto() As String
        Get
            Return _APMonto
        End Get
        Set(ByVal Value As String)
            _APMonto = Value
        End Set
    End Property

    Public Property APAvance() As String
        Get
            Return _APAvance
        End Get
        Set(ByVal Value As String)
            _APAvance = Value
        End Set
    End Property

    Public Property POId() As Integer
        Get
            Return _POId
        End Get
        Set(ByVal Value As Integer)
            _POId = Value
        End Set
    End Property
    Public Property POFecS() As Date
        Get
            Return _POFecS
        End Get
        Set(ByVal Value As Date)
            _POFecS = Value
        End Set
    End Property

    Public Property POFecE() As Date
        Get
            Return _POFecE
        End Get
        Set(ByVal Value As Date)
            _POFecE = Value
        End Set
    End Property

    Public Property POEst() As String
        Get
            Return _POEst
        End Get
        Set(ByVal Value As String)
            _POEst = Value
        End Set
    End Property

    Public Property POOficio() As String
        Get
            Return _POOficio
        End Get
        Set(ByVal Value As String)
            _POOficio = Value
        End Set
    End Property

    Public Property POAvance() As String
        Get
            Return _POAvance
        End Get
        Set(ByVal Value As String)
            _POAvance = Value
        End Set
    End Property

    Public Property POCosto() As String
        Get
            Return _POCosto
        End Get
        Set(ByVal Value As String)
            _POCosto = Value
        End Set
    End Property
    Public Property PCId() As Integer
        Get
            Return _PCId
        End Get
        Set(ByVal Value As Integer)
            _PCId = Value
        End Set
    End Property

    Public Property PCFecS() As Date
        Get
            Return _PCFecS
        End Get
        Set(ByVal Value As Date)
            _PCFecS = Value
        End Set
    End Property

    Public Property PCNum() As String
        Get
            Return _PCNum
        End Get
        Set(ByVal Value As String)
            _PCNum = Value
        End Set
    End Property

    Public Property PCEst() As String
        Get
            Return _PCEst
        End Get
        Set(ByVal Value As String)
            _PCEst = Value
        End Set
    End Property

    Public Property PCInciso() As String
        Get
            Return _PCInciso
        End Get
        Set(ByVal Value As String)
            _PCInciso = Value
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

    Public Property RMun() As Decimal
        Get
            Return _RMun
        End Get
        Set(ByVal Value As Decimal)
            _RMun = Value
        End Set
    End Property

    Public Property REst() As Decimal
        Get
            Return _REst
        End Get
        Set(ByVal Value As Decimal)
            _REst = Value
        End Set
    End Property

    Public Property RFed() As Decimal
        Get
            Return _RFed
        End Get
        Set(ByVal Value As Decimal)
            _RFed = Value
        End Set
    End Property

    Public Property ROtro() As String
        Get
            Return _ROtro
        End Get
        Set(ByVal Value As String)
            _ROtro = Value
        End Set
    End Property

    Public Property RMOtro() As Decimal
        Get
            Return _RMOtro
        End Get
        Set(ByVal Value As Decimal)
            _RMOtro = Value
        End Set
    End Property

    Public Property RFidoc() As Decimal
        Get
            Return _RFidoc
        End Get
        Set(ByVal Value As Decimal)
            _RFidoc = Value
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

    Public Property Documento() As String
        Get
            Return _Documento
        End Get
        Set(ByVal Value As String)
            _Documento = Value
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

    Public Property POOficioR() As String
        Get
            Return _POOficioR
        End Get
        Set(ByVal Value As String)
            _POOficioR = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consultar(ByVal objMov As clsMovimientos) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objMov._IdSol
        Dim FId As SqlParameter = New SqlParameter("@fid", SqlDbType.Int, 6)
        FId.Value = objMov._FId
        Dim FFecha As SqlParameter = New SqlParameter("@ffecha", SqlDbType.Date, 10)
        FFecha.Value = objMov._FFecha
        Dim FPlazo As SqlParameter = New SqlParameter("@fplazo", SqlDbType.NVarChar, 20)
        FPlazo.Value = objMov._FPlazo
        Dim FCoop As SqlParameter = New SqlParameter("@fcoop", SqlDbType.Int, 6)
        FCoop.Value = objMov._FCoop
        Dim FEntrega As SqlParameter = New SqlParameter("@fentrega", SqlDbType.NVarChar, 20)
        FEntrega.Value = objMov._FEntrega

        Dim SId As SqlParameter = New SqlParameter("@sid", SqlDbType.Int, 6)
        SId.Value = objMov._SId
        Dim SFecS As SqlParameter = New SqlParameter("@sfecs", SqlDbType.Date, 10)
        SFecS.Value = objMov._SFecS
        Dim SFecA As SqlParameter = New SqlParameter("@sfeca", SqlDbType.Date, 10)
        SFecA.Value = objMov._SFecA
        Dim SProm As SqlParameter = New SqlParameter("@sprom", SqlDbType.NVarChar, 50)
        SProm.Value = objMov._SProm
        Dim SObra As SqlParameter = New SqlParameter("@sobra", SqlDbType.NVarChar, 50)
        SObra.Value = objMov._SObra
        Dim SPredios As SqlParameter = New SqlParameter("@spredios", SqlDbType.NVarChar, 10)
        SPredios.Value = objMov._SPredios
        Dim SPredDesc As SqlParameter = New SqlParameter("@spreddesc", SqlDbType.NVarChar, 200)
        SPredDesc.Value = objMov._SPredDesc


        Dim APId As SqlParameter = New SqlParameter("@apid", SqlDbType.Int, 6)
        APId.Value = objMov._APId
        Dim APFecha As SqlParameter = New SqlParameter("@apfecha", SqlDbType.Date, 10)
        APFecha.Value = objMov._APFecha
        Dim APMonto As SqlParameter = New SqlParameter("@apmonto", SqlDbType.NVarChar, 20)
        APMonto.Value = objMov._APMonto
        Dim APAvance As SqlParameter = New SqlParameter("@apavance", SqlDbType.NVarChar, 50)
        APAvance.Value = objMov._APAvance

        Dim POId As SqlParameter = New SqlParameter("@poid", SqlDbType.Int, 6)
        POId.Value = objMov._POId
        Dim POFecS As SqlParameter = New SqlParameter("@pofecs", SqlDbType.Date, 10)
        POFecS.Value = objMov._POFecS
        Dim POFecE As SqlParameter = New SqlParameter("@pofece", SqlDbType.Date, 10)
        POFecE.Value = objMov._POFecE
        Dim POEst As SqlParameter = New SqlParameter("@poest", SqlDbType.NVarChar, 50)
        POEst.Value = objMov._POEst
        Dim POOficio As SqlParameter = New SqlParameter("@pooficio", SqlDbType.NVarChar, 50)
        POOficio.Value = objMov._POOficio
        Dim POCosto As SqlParameter = New SqlParameter("@pocosto", SqlDbType.NVarChar, 50)
        POCosto.Value = objMov._POCosto
        Dim POAvance As SqlParameter = New SqlParameter("@poavance", SqlDbType.NVarChar, 50)
        POAvance.Value = objMov._POAvance
        Dim POOficioR As SqlParameter = New SqlParameter("@pooficior", SqlDbType.NVarChar, 50)
        POOficioR.Value = objMov._POOficioR

        Dim PCId As SqlParameter = New SqlParameter("@pcid", SqlDbType.Int, 6)
        PCId.Value = objMov._PCId
        Dim PCFecS As SqlParameter = New SqlParameter("@pcfecs", SqlDbType.Date, 10)
        PCFecS.Value = objMov._PCFecS
        Dim PCNum As SqlParameter = New SqlParameter("@pcnum", SqlDbType.NVarChar, 10)
        PCNum.Value = objMov._PCNum
        Dim PCEst As SqlParameter = New SqlParameter("@pcest", SqlDbType.NVarChar, 10)
        PCEst.Value = objMov._PCEst
        Dim PCInciso As SqlParameter = New SqlParameter("@pcinciso", SqlDbType.NVarChar, 10)
        PCInciso.Value = objMov._PCInciso

        Dim RId As SqlParameter = New SqlParameter("@rid", SqlDbType.Int, 6)
        RId.Value = objMov._RId
        Dim RMun As SqlParameter = New SqlParameter("@rmun", SqlDbType.Decimal, 10)
        RMun.Precision = 10
        RMun.Scale = 2
        RMun.Value = objMov._RMun
        Dim REst As SqlParameter = New SqlParameter("@rest", SqlDbType.Decimal, 10)
        REst.Precision = 10
        REst.Scale = 2
        REst.Value = objMov._REst
        Dim RFed As SqlParameter = New SqlParameter("@rfed", SqlDbType.Decimal, 10)
        RFed.Precision = 10
        RFed.Scale = 2
        RFed.Value = objMov._RFed
        Dim ROtro As SqlParameter = New SqlParameter("@rotro", SqlDbType.NVarChar, 50)
        ROtro.Value = objMov._ROtro
        Dim RMOtro As SqlParameter = New SqlParameter("@rmotro", SqlDbType.Decimal, 10)
        RMOtro.Precision = 10
        RMOtro.Scale = 2
        RMOtro.Value = objMov._RMOtro
        Dim RFidoc As SqlParameter = New SqlParameter("@rfidoc", SqlDbType.Decimal, 10)
        RFidoc.Precision = 10
        RFidoc.Scale = 2
        RFidoc.Value = objMov._RFidoc

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objMov._Accion

        Dim Documento As SqlParameter = New SqlParameter("@documento", SqlDbType.NVarChar, 255)
        Documento.Value = objMov._Documento

        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objMov._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objMov._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objMov._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objMov._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(FId)
        params.Add(FFecha)
        params.Add(FPlazo)
        params.Add(FCoop)
        params.Add(FEntrega)

        params.Add(SId)
        params.Add(SFecS)
        params.Add(SFecA)
        params.Add(SProm)
        params.Add(SObra)
        params.Add(SPredios)
        params.Add(SPredDesc)

        params.Add(APId)
        params.Add(APFecha)
        params.Add(APMonto)
        params.Add(APAvance)

        params.Add(POId)
        params.Add(POFecS)
        params.Add(POFecE)
        params.Add(POEst)
        params.Add(POOficio)
        params.Add(POCosto)
        params.Add(POAvance)
        params.Add(POOficioR)

        params.Add(PCId)
        params.Add(PCFecS)
        params.Add(PCNum)
        params.Add(PCEst)
        params.Add(PCInciso)

        params.Add(RId)
        params.Add(RMun)
        params.Add(REst)
        params.Add(RFed)
        params.Add(ROtro)
        params.Add(RMOtro)
        params.Add(RFidoc)

        params.Add(Accion)
        params.Add(Documento)

        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Movimientos", params)
    End Function

    Public Shared Function Insertar(ByVal objMov As clsMovimientos) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objMov._IdSol
        Dim FId As SqlParameter = New SqlParameter("@fid", SqlDbType.Int, 6)
        FId.Value = objMov._FId
        Dim FFecha As SqlParameter = New SqlParameter("@ffecha", SqlDbType.Date, 10)
        FFecha.Value = objMov._FFecha
        Dim FPlazo As SqlParameter = New SqlParameter("@fplazo", SqlDbType.NVarChar, 20)
        FPlazo.Value = objMov._FPlazo
        Dim FCoop As SqlParameter = New SqlParameter("@fcoop", SqlDbType.Int, 6)
        FCoop.Value = objMov._FCoop
        Dim FEntrega As SqlParameter = New SqlParameter("@fentrega", SqlDbType.NVarChar, 20)
        FEntrega.Value = objMov._FEntrega

        Dim SId As SqlParameter = New SqlParameter("@sid", SqlDbType.Int, 6)
        SId.Value = objMov._SId
        Dim SFecS As SqlParameter = New SqlParameter("@sfecs", SqlDbType.Date, 10)
        SFecS.Value = objMov._SFecS
        Dim SFecA As SqlParameter = New SqlParameter("@sfeca", SqlDbType.Date, 10)
        SFecA.Value = objMov._SFecA
        Dim SProm As SqlParameter = New SqlParameter("@sprom", SqlDbType.NVarChar, 50)
        SProm.Value = objMov._SProm
        Dim SObra As SqlParameter = New SqlParameter("@sobra", SqlDbType.NVarChar, 50)
        SObra.Value = objMov._SObra
        Dim SPredios As SqlParameter = New SqlParameter("@spredios", SqlDbType.NVarChar, 10)
        SPredios.Value = objMov._SPredios
        Dim SPredDesc As SqlParameter = New SqlParameter("@spreddesc", SqlDbType.NVarChar, 200)
        SPredDesc.Value = objMov._SPredDesc

        Dim APId As SqlParameter = New SqlParameter("@apid", SqlDbType.Int, 6)
        APId.Value = objMov._APId
        Dim APFecha As SqlParameter = New SqlParameter("@apfecha", SqlDbType.Date, 10)
        APFecha.Value = objMov._APFecha
        Dim APMonto As SqlParameter = New SqlParameter("@apmonto", SqlDbType.NVarChar, 20)
        APMonto.Value = objMov._APMonto
        Dim APAvance As SqlParameter = New SqlParameter("@apavance", SqlDbType.NVarChar, 50)
        APAvance.Value = objMov._APAvance

        Dim POId As SqlParameter = New SqlParameter("@poid", SqlDbType.Int, 6)
        POId.Value = objMov._POId
        Dim POFecS As SqlParameter = New SqlParameter("@pofecs", SqlDbType.Date, 10)
        POFecS.Value = objMov._POFecS
        Dim POFecE As SqlParameter = New SqlParameter("@pofece", SqlDbType.Date, 10)
        POFecE.Value = objMov._POFecE
        Dim POEst As SqlParameter = New SqlParameter("@poest", SqlDbType.NVarChar, 50)
        POEst.Value = objMov._POEst
        Dim POOficio As SqlParameter = New SqlParameter("@pooficio", SqlDbType.NVarChar, 50)
        POOficio.Value = objMov._POOficio
        Dim POCosto As SqlParameter = New SqlParameter("@pocosto", SqlDbType.NVarChar, 50)
        POCosto.Value = objMov._POCosto
        Dim POAvance As SqlParameter = New SqlParameter("@poavance", SqlDbType.NVarChar, 50)
        POAvance.Value = objMov._POAvance
        Dim POOficioR As SqlParameter = New SqlParameter("@pooficior", SqlDbType.NVarChar, 50)
        POOficioR.Value = objMov._POOficioR

        Dim PCId As SqlParameter = New SqlParameter("@pcid", SqlDbType.Int, 6)
        PCId.Value = objMov._PCId
        Dim PCFecS As SqlParameter = New SqlParameter("@pcfecs", SqlDbType.Date, 10)
        PCFecS.Value = objMov._PCFecS
        Dim PCNum As SqlParameter = New SqlParameter("@pcnum", SqlDbType.NVarChar, 10)
        PCNum.Value = objMov._PCNum
        Dim PCEst As SqlParameter = New SqlParameter("@pcest", SqlDbType.NVarChar, 10)
        PCEst.Value = objMov._PCEst
        Dim PCInciso As SqlParameter = New SqlParameter("@pcinciso", SqlDbType.NVarChar, 10)
        PCInciso.Value = objMov._PCInciso

        Dim RId As SqlParameter = New SqlParameter("@rid", SqlDbType.Int, 6)
        RId.Value = objMov._RId

        Dim RMun As SqlParameter = New SqlParameter("@rmun", SqlDbType.Decimal, 10)
        RMun.Precision = 10
        RMun.Scale = 2
        RMun.Value = objMov._RMun
        Dim REst As SqlParameter = New SqlParameter("@rest", SqlDbType.Decimal, 10)
        REst.Precision = 10
        REst.Scale = 2
        REst.Value = objMov._REst
        Dim RFed As SqlParameter = New SqlParameter("@rfed", SqlDbType.Decimal, 10)
        RFed.Precision = 10
        RFed.Scale = 2
        RFed.Value = objMov._RFed
        Dim ROtro As SqlParameter = New SqlParameter("@rotro", SqlDbType.NVarChar, 50)
        ROtro.Value = objMov._ROtro
        Dim RMOtro As SqlParameter = New SqlParameter("@rmotro", SqlDbType.Decimal, 10)
        RMOtro.Precision = 10
        RMOtro.Scale = 2
        RMOtro.Value = objMov._RMOtro
        Dim RFidoc As SqlParameter = New SqlParameter("@rfidoc", SqlDbType.Decimal, 10)
        RFidoc.Precision = 10
        RFidoc.Scale = 2
        RFidoc.Value = objMov._RFidoc

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objMov._Accion

        Dim Documento As SqlParameter = New SqlParameter("@documento", SqlDbType.NVarChar, 255)
        Documento.Value = objMov._Documento

        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objMov._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objMov._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objMov._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objMov._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(FId)
        params.Add(FFecha)
        params.Add(FPlazo)
        params.Add(FCoop)
        params.Add(FEntrega)

        params.Add(SId)
        params.Add(SFecS)
        params.Add(SFecA)
        params.Add(SProm)
        params.Add(SObra)
        params.Add(SPredios)
        params.Add(SPredDesc)

        params.Add(APId)
        params.Add(APFecha)
        params.Add(APMonto)
        params.Add(APAvance)

        params.Add(POId)
        params.Add(POFecS)
        params.Add(POFecE)
        params.Add(POEst)
        params.Add(POOficio)
        params.Add(POCosto)
        params.Add(POAvance)
        params.Add(POOficioR)

        params.Add(PCId)
        params.Add(PCFecS)
        params.Add(PCNum)
        params.Add(PCEst)
        params.Add(PCInciso)

        params.Add(RId)
        params.Add(RMun)
        params.Add(REst)
        params.Add(RFed)
        params.Add(ROtro)
        params.Add(RMOtro)
        params.Add(RFidoc)

        params.Add(Accion)
        params.Add(Documento)

        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Movimientos", params)
    End Function

    Public Shared Function obra(ByVal objmov As clsMovimientos) As DataTable
        Dim strQuery As String = _
       "select * from mSFidoc where mSolId= " & objmov.IdSol
        Return conn.EjecutarConsultaO(strQuery)
    End Function

#End Region

End Class

