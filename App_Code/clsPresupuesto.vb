Imports System.Data
Imports System.Data.SqlClient


Public Class clsPresupuesto
#Region "variables privadas"
    Private _NoFolioPrep As Integer = 0
    Private _IdSol As Integer = 0
    Private _CostoMtoLineal As Decimal = 0
    Private _Longitud As Decimal = 0
    Private _Dcto As String = String.Empty
    Private _FechaRealizacion As Date
    Private _ProgId As Integer = 0
    Private _TipoPavId As Integer = 0
    Private _MtsSeccion As Decimal = 0
    Private _MtsBanqueta As Decimal = 0
    Private _MtsArroyo As Decimal = 0
    Private _DerramaVecinos As Decimal = 0
    Private _DerramaEU As Decimal = 0
    Private _Mts2Arroyo As Decimal = 0
    Private _Mts2Banqueta As Decimal = 0
    Private _GastosAdmvos As Decimal = 0
    Private _IdCalidad As String = String.Empty
    Private _CostoTotalVecinos As Decimal = 0
    Private _CostoTotalMunicipio As Decimal = 0
    Private _IdAsamblea As Integer = 0
    Private _Accion As String = String.Empty
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"


    Public Property NoFolioPrep() As Integer
        Get
            Return _NoFolioPrep
        End Get
        Set(ByVal Value As Integer)
            _NoFolioPrep = Value
        End Set
    End Property
    Public Property IdSol() As Integer
        Get
            Return _idSol
        End Get
        Set(ByVal Value As Integer)
            _IdSol = Value
        End Set
    End Property
    Public Property CostoMtoLineal() As Decimal
        Get
            Return _CostoMtoLineal
        End Get
        Set(ByVal Value As Decimal)
            _CostoMtoLineal = Value
        End Set
    End Property
    Public Property Longitud() As Decimal

        Get
            Return _Longitud
        End Get
        Set(ByVal Value As Decimal)
            _Longitud = Value
        End Set
    End Property
    Public Property Dcto() As String
        Get
            Return _Dcto
        End Get
        Set(ByVal Value As String)
            _Dcto = Value
        End Set
    End Property
    Public Property FechaRealizacion() As Date
        Get
            Return _FechaRealizacion
        End Get
        Set(ByVal Value As Date)
            _FechaRealizacion = Value
        End Set
    End Property
    Public Property ProgId() As Integer
        Get
            Return _ProgId
        End Get
        Set(ByVal Value As Integer)
            _ProgId = Value
        End Set
    End Property
    Public Property TipoPavId() As Integer
        Get
            Return _TipoPavId
        End Get
        Set(ByVal Value As Integer)
            _TipoPavId = Value
        End Set
    End Property
    Public Property MtsSeccion() As Decimal
        Get
            Return _MtsSeccion
        End Get
        Set(ByVal Value As Decimal)
            _MtsSeccion = Value
        End Set
    End Property
    Public Property MtsBanqueta() As Decimal
        Get
            Return _MtsBanqueta
        End Get
        Set(ByVal Value As Decimal)
            _MtsBanqueta = Value
        End Set
    End Property
    Public Property MtsArroyo() As Decimal
        Get
            Return _MtsArroyo
        End Get
        Set(ByVal Value As Decimal)
            _MtsArroyo = Value
        End Set
    End Property
    Public Property DerramaVecinos() As Decimal
        Get
            Return _DerramaVecinos
        End Get
        Set(ByVal Value As Decimal)
            _DerramaVecinos = Value
        End Set
    End Property
    Public Property DerramaEU() As Decimal
        Get
            Return _DerramaEU
        End Get
        Set(ByVal Value As Decimal)
            _DerramaEU = Value
        End Set
    End Property
    Public Property Mts2Arroyo() As Decimal
        Get
            Return _Mts2Arroyo
        End Get
        Set(ByVal Value As Decimal)
            _Mts2Arroyo = Value
        End Set
    End Property
    Public Property Mts2Banqueta() As Decimal
        Get
            Return _Mts2Banqueta
        End Get
        Set(ByVal Value As Decimal)
            _Mts2Banqueta = Value
        End Set
    End Property
    Public Property GastosAdmvos() As Decimal
        Get
            Return _GastosAdmvos
        End Get
        Set(ByVal Value As Decimal)
            _GastosAdmvos = Value
        End Set
    End Property
    Public Property IdCalidad() As String
        Get
            Return _IdCalidad
        End Get
        Set(ByVal Value As String)
            _IdCalidad = Value
        End Set
    End Property
    Public Property CostoTotalVecinos() As Decimal
        Get
            Return _CostoTotalVecinos
        End Get
        Set(ByVal Value As Decimal)
            _CostoTotalVecinos = Value
        End Set
    End Property
    Public Property CostoTotalMunicipio() As Decimal
        Get
            Return _CostoTotalMunicipio
        End Get
        Set(ByVal Value As Decimal)
            _CostoTotalMunicipio = Value
        End Set
    End Property
    Public Property IdAsamblea() As Integer
        Get
            Return _IdAsamblea
        End Get
        Set(ByVal Value As Integer)
            _IdAsamblea = Value
        End Set
    End Property
    Property Accion As String
        Get
            Return _Accion
        End Get
        Set(value As String)
            _Accion = value
        End Set
    End Property
    Property Mensaje() As String
        ' la parte Get es la que devuelve el valor de la propiedad
        Get
            Return strMensaje
        End Get
        ' la parte Set es la que se usa al asignar el nuevo valor
        Set(ByVal Value As String)
            If Value <> "" Then
                strMensaje = Value
            End If
        End Set
    End Property



#End Region

#Region "Metodos"



    Public Shared Function Consulta(ByVal objPresup As clsPresupuesto, ByRef tbl As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim NoFolio As SqlParameter = New SqlParameter("@NoFolioPrep", SqlDbType.Int, 6)
        NoFolio.Value = objPresup._NoFolioPrep
        Dim IdSol As SqlParameter = New SqlParameter("@IdSol", SqlDbType.Int, 6)
        IdSol.Value = objPresup._IdSol
        Dim CostoMtoLineal As SqlParameter = New SqlParameter("@CostoMtoLineal", SqlDbType.Decimal, 15)
        CostoMtoLineal.Value = objPresup._CostoMtoLineal
        Dim Longitud As SqlParameter = New SqlParameter("@Longitud", SqlDbType.Decimal, 15)
        Longitud.Value = objPresup._Longitud
        Dim Dcto As SqlParameter = New SqlParameter("@Dcto", SqlDbType.NVarChar, 200)
        Dcto.Value = objPresup._Dcto
        Dim FechaRealizacion As SqlParameter = New SqlParameter("@FechaRealizacion", SqlDbType.Date, 200)
        FechaRealizacion.Value = objPresup._FechaRealizacion
        Dim ProgId As SqlParameter = New SqlParameter("@ProgId", SqlDbType.Int, 10)
        ProgId.Value = objPresup._ProgId
        Dim TipoPavId As SqlParameter = New SqlParameter("@TipoPavId", SqlDbType.Int, 10)
        TipoPavId.Value = objPresup._TipoPavId
        Dim MtsSeccion As SqlParameter = New SqlParameter("@MtsSeccion", SqlDbType.Decimal, 18)
        MtsSeccion.Value = objPresup._MtsSeccion
        Dim MtsBanqueta As SqlParameter = New SqlParameter("@MtsBanqueta", SqlDbType.Decimal, 18)
        MtsBanqueta.Value = objPresup._MtsBanqueta
        Dim MtsArroyo As SqlParameter = New SqlParameter("@MtsArroyo", SqlDbType.Decimal, 18)
        MtsArroyo.Value = objPresup._MtsArroyo
        Dim DerramaVecinos As SqlParameter = New SqlParameter("@DerramaVecinos", SqlDbType.Decimal, 18)
        DerramaVecinos.Value = objPresup._DerramaVecinos
        Dim DerramaEU As SqlParameter = New SqlParameter("@DerramaEU", SqlDbType.Decimal, 18)
        DerramaEU.Value = objPresup._DerramaEU
        Dim Mts2Arroyo As SqlParameter = New SqlParameter("@Mts2Arroyo", SqlDbType.Decimal, 18)
        Mts2Arroyo.Value = objPresup._Mts2Arroyo
        Dim Mts2Banqueta As SqlParameter = New SqlParameter("@Mts2Banqueta", SqlDbType.Decimal, 18)
        Mts2Banqueta.Value = objPresup._Mts2Banqueta
        Dim GastosAdmvos As SqlParameter = New SqlParameter("@GastosAdmvos", SqlDbType.Decimal, 18)
        GastosAdmvos.Value = objPresup._GastosAdmvos
        Dim IdCalidad As SqlParameter = New SqlParameter("@IdCalidad", SqlDbType.NVarChar, 10)
        IdCalidad.Value = objPresup._IdCalidad
        Dim CostoTotalVecinos As SqlParameter = New SqlParameter("@CostoTotalVecinos", SqlDbType.Decimal, 18)
        CostoTotalVecinos.Value = objPresup._CostoTotalVecinos
        Dim CostoTotalMunicipio As SqlParameter = New SqlParameter("@CostoTotalMunicipio", SqlDbType.Decimal, 18)
        CostoTotalMunicipio.Value = objPresup._CostoTotalMunicipio
        Dim IdAsamblea As SqlParameter = New SqlParameter("@IdAsamblea", SqlDbType.Int, 10)
        IdAsamblea.Value = objPresup._IdAsamblea

        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 10)
        Accion.Value = objPresup._Accion

        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(NoFolio)
        params.Add(IdSol)
        params.Add(CostoMtoLineal)
        params.Add(Longitud)
        params.Add(Dcto)
        params.Add(FechaRealizacion)
        params.Add(ProgId)
        params.Add(TipoPavId)
        params.Add(MtsSeccion)
        params.Add(MtsBanqueta)
        params.Add(MtsArroyo)
        params.Add(DerramaVecinos)
        params.Add(DerramaEU)
        params.Add(Mts2Arroyo)
        params.Add(Mts2Banqueta)
        params.Add(GastosAdmvos)
        params.Add(IdCalidad)
        params.Add(CostoTotalVecinos)
        params.Add(CostoTotalMunicipio)
        params.Add(IdAsamblea)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)


        '-------------------------Invoca la función para ejecutar el SP

        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_Presupuesto", params, objPresup.Mensaje, tbl)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objPresup.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objPresup.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objPresup.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objPresup.strMensaje = intError & " - " & objPresup.strMensaje
            End Select
            Return False
        Else
            objPresup.strMensaje = "OK"
            Return True
        End If
    End Function

    Public Shared Function Consulta_PresupSol(ByVal objPresup As clsPresupuesto, ByRef tbl As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim NoFolio As SqlParameter = New SqlParameter("@NoFolioPrep", SqlDbType.Int, 6)
        NoFolio.Value = objPresup._NoFolioPrep
        Dim IdSol As SqlParameter = New SqlParameter("@IdSol", SqlDbType.Int, 6)
        IdSol.Value = objPresup._IdSol
        Dim CostoMtoLineal As SqlParameter = New SqlParameter("@CostoMtoLineal", SqlDbType.Decimal, 15)
        CostoMtoLineal.Value = objPresup._CostoMtoLineal
        Dim IdCalidad As SqlParameter = New SqlParameter("@IdCalidad", SqlDbType.NVarChar, 10)
        IdCalidad.Value = objPresup._IdCalidad
        Dim IdAsamblea As SqlParameter = New SqlParameter("@IdAsamblea", SqlDbType.Int, 10)
        IdAsamblea.Value = objPresup._IdAsamblea

        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 10)
        Accion.Value = objPresup._Accion

        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(NoFolio)
        params.Add(IdSol)
        params.Add(CostoMtoLineal)
        params.Add(IdAsamblea)
        params.Add(IdCalidad)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)

        '-------------------------Invoca la función para ejecutar el SP



        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_Presupuesto", params, objPresup.strMensaje, tbl)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objPresup.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objPresup.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objPresup.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objPresup.strMensaje = intError & " - " & objPresup.strMensaje
            End Select
            Return False
        Else
            objPresup.strMensaje = "OK"
            Return True
        End If
    End Function

    Public Shared Function Insertar(ByVal objPresup As clsPresupuesto) As Boolean
        Dim params = New List(Of SqlParameter)
        Dim NoFolio As SqlParameter = New SqlParameter("@NoFolioPrep", SqlDbType.Int, 6)
        NoFolio.Value = objPresup._NoFolioPrep
        Dim IdSol As SqlParameter = New SqlParameter("@IdSol", SqlDbType.Int, 6)
        IdSol.Value = objPresup._IdSol
        Dim CostoMtoLineal As SqlParameter = New SqlParameter("@CostoMtoLineal", SqlDbType.Decimal, 15)
        CostoMtoLineal.Value = objPresup._CostoMtoLineal
        Dim Longitud As SqlParameter = New SqlParameter("@Longitud", SqlDbType.Decimal, 15)
        Longitud.Value = objPresup._Longitud
        Dim Dcto As SqlParameter = New SqlParameter("@Dcto", SqlDbType.NVarChar, 200)
        Dcto.Value = objPresup._Dcto
        Dim FechaRealizacion As SqlParameter = New SqlParameter("@FechaRealizacion", SqlDbType.Date, 10)
        FechaRealizacion.Value = objPresup._FechaRealizacion
        Dim ProgId As SqlParameter = New SqlParameter("@ProgId", SqlDbType.Int, 10)
        ProgId.Value = objPresup._ProgId
        Dim TipoPavId As SqlParameter = New SqlParameter("@TipoPavId", SqlDbType.Int, 10)
        TipoPavId.Value = objPresup._TipoPavId
        Dim MtsSeccion As SqlParameter = New SqlParameter("@MtsSeccion", SqlDbType.Decimal, 10)
        MtsSeccion.Value = objPresup._MtsSeccion
        Dim MtsBanqueta As SqlParameter = New SqlParameter("@MtsBanqueta", SqlDbType.Decimal, 10)
        MtsBanqueta.Value = objPresup._MtsBanqueta
        Dim MtsArroyo As SqlParameter = New SqlParameter("@MtsArroyo", SqlDbType.Decimal, 10)
        MtsArroyo.Value = objPresup._MtsArroyo
        Dim DerramaVecinos As SqlParameter = New SqlParameter("@DerramaVecinos", SqlDbType.Decimal, 18)
        DerramaVecinos.Value = objPresup._DerramaVecinos
        Dim DerramaEU As SqlParameter = New SqlParameter("@DerramaEU", SqlDbType.Decimal, 18)
        DerramaEU.Value = objPresup._DerramaEU
        Dim Mts2Arroyo As SqlParameter = New SqlParameter("@Mts2Arroyo", SqlDbType.Decimal, 18)
        Mts2Arroyo.Value = objPresup._Mts2Arroyo
        Dim Mts2Banqueta As SqlParameter = New SqlParameter("@Mts2Banqueta", SqlDbType.Decimal, 18)
        Mts2Banqueta.Value = objPresup._Mts2Banqueta
        Dim GastosAdmvos As SqlParameter = New SqlParameter("@GastosAdmvos", SqlDbType.Decimal, 10)
        GastosAdmvos.Value = objPresup._GastosAdmvos
        Dim IdCalidad As SqlParameter = New SqlParameter("@IdCalidad", SqlDbType.NVarChar, 10)
        IdCalidad.Value = objPresup._IdCalidad
        Dim CostoTotalVecinos As SqlParameter = New SqlParameter("@CostoTotalVecinos", SqlDbType.Decimal, 10)
        CostoTotalVecinos.Value = objPresup._CostoTotalVecinos
        Dim CostoTotalMunicipio As SqlParameter = New SqlParameter("@CostoTotalMunicipio", SqlDbType.Decimal, 30)
        CostoTotalMunicipio.Value = objPresup._CostoTotalMunicipio
        Dim IdAsamblea As SqlParameter = New SqlParameter("@IdAsamblea", SqlDbType.Int, 6)
        IdAsamblea.Value = objPresup._IdAsamblea
        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 10)
        Accion.Value = objPresup._Accion
        'PARAMETROS DE RESPUESTA
        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output

        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output

        '    '--------------------------Agrega los parámetros a un arreglo
        params.Add(NoFolio)
        params.Add(IdSol)
        params.Add(CostoMtoLineal)
        params.Add(Longitud)
        params.Add(Dcto)
        params.Add(FechaRealizacion)
        params.Add(ProgId)
        params.Add(TipoPavId)
        params.Add(MtsSeccion)
        params.Add(MtsBanqueta)
        params.Add(MtsArroyo)
        params.Add(DerramaVecinos)
        params.Add(DerramaEU)
        params.Add(Mts2Arroyo)
        params.Add(Mts2Banqueta)
        params.Add(GastosAdmvos)
        params.Add(IdCalidad)
        params.Add(CostoTotalVecinos)
        params.Add(CostoTotalMunicipio)
        params.Add(IdAsamblea)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)
        params.Add(parAux1)

        '    '-----------r--------------Invoca la función para ejecutar el SP
        objPresup.strMensaje = Nothing
        Dim intError As Integer = conn.EjecutarOperacionPrueba3("SP_Presupuesto", params, objPresup.strMensaje, objPresup.NoFolioPrep)

        'Evaluamos las respuesta de SQL

        If intError > 0 Then
            Select Case intError
                Case 2601
                    objPresup.strMensaje = "Ya se tiene un presupuesto guardado con el mismo programa"
                Case 2627
                    objPresup.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objPresup.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objPresup.strMensaje = intError & " - " & objPresup.strMensaje
            End Select
            Return False
        Else
            objPresup.strMensaje = "OK"
            Return True
        End If
    End Function

    Public Shared Function Eliminar(ByVal objPresup As clsPresupuesto, ByRef strMensajeSQL As String) As Boolean
        Dim params = New List(Of SqlParameter)
        Dim NoFolio As SqlParameter = New SqlParameter("@NoFolioPrep", SqlDbType.Int, 6)
        NoFolio.Value = objPresup._NoFolioPrep
        Dim IdSol As SqlParameter = New SqlParameter("@IdSol", SqlDbType.Int, 6)
        IdSol.Value = objPresup._IdSol
        Dim ProgId As SqlParameter = New SqlParameter("@ProgId", SqlDbType.Int, 10)
        ProgId.Value = objPresup._ProgId

        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 10)
        Accion.Value = objPresup._Accion
        'PARAMETROS DE RESPUESTA
        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output

        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        '    '--------------------------Agrega los parámetros a un arreglo
        params.Add(NoFolio)
        params.Add(IdSol)
        params.Add(ProgId)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)

        '    '-------------------------Invoca la función para ejecutar el SP
        objPresup.strMensaje = Nothing
        Dim intError As Integer = conn.EjecutarOperacionPrueba("SP_Presupuesto", params, objPresup.Mensaje)
        'Evaluamos las respuesta de SQL

        If intError > 0 Then
            Select Case intError
                Case 2601
                    objPresup.Mensaje = "ERROR NO EVALUADO"
                Case 2627
                    objPresup.Mensaje = "ERROR NO EVALUADO"
                Case 2812
                    objPresup.Mensaje = "No se ha hallado el SP solicitado"
                Case Else
                    objPresup.Mensaje = intError & " - " & objPresup.strMensaje
            End Select
            Return False
        Else
            objPresup.Mensaje = "OK"
            Return True
        End If
    End Function
#End Region
End Class
