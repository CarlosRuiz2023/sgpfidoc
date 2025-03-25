Imports System.Data
Imports System.Data.SqlClient

Public Class clsCallesSIG
#Region "variables privadas"
    Private _oid As Integer = 0
    Private _Sector As Integer = 0
    Private _Subsector As Integer = 0
    Private _CveCalle As Integer = 0
    Private _Tramo As String = String.Empty
    Private _Calle As String = String.Empty
    Private _CalleAnt As String = String.Empty
    Private _Colonia As String = String.Empty
    Private _Accion As String = String.Empty
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property oid() As Integer
        Get
            Return _oid
        End Get
        Set(ByVal Value As Integer)
            _oid = Value
        End Set
    End Property
    Public Property Sector() As Integer
        Get
            Return _Sector
        End Get
        Set(ByVal Value As Integer)
            _Sector = Value
        End Set
    End Property
    Public Property Subsector() As Integer
        Get
            Return _Subsector
        End Get
        Set(ByVal Value As Integer)
            _Subsector = Value
        End Set
    End Property
    Public Property CveCalle() As Integer
        Get
            Return _CveCalle
        End Get
        Set(ByVal Value As Integer)
            _CveCalle = Value
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
    Public Property CalleAnt() As String
        Get
            Return _CalleAnt
        End Get
        Set(ByVal Value As String)
            _CalleAnt = Value
        End Set
    End Property
    Public Property Colonia() As String
        Get
            Return _Colonia
        End Get
        Set(ByVal Value As String)
            _Colonia = Value
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
    Public Property Mensaje() As String
        Get
            Return strMensaje
        End Get
        Set(ByVal Value As String)
            strMensaje = Value
        End Set
    End Property
#End Region

#Region "Metodos"

    Public Shared Function Consulta_CallesSIG(ByVal objCallesSIG As clsCallesSIG, ByRef tbl As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim oid As SqlParameter = New SqlParameter("@oid", SqlDbType.Int, 6)
        oid.Value = objCallesSIG._oid

        Dim Sector As SqlParameter = New SqlParameter("@Sector", SqlDbType.Int, 6)
        Sector.Value = objCallesSIG._Sector

        Dim Subsector As SqlParameter = New SqlParameter("@Subsector", SqlDbType.Int, 6)
        Subsector.Value = objCallesSIG._Subsector

        Dim CveCalle As SqlParameter = New SqlParameter("@CveCalle", SqlDbType.Int, 6)
        CveCalle.Value = objCallesSIG._CveCalle

        Dim Calle As SqlParameter = New SqlParameter("@Calle", SqlDbType.NVarChar, 100)
        Calle.Value = objCallesSIG._Calle

        Dim CalleAnt As SqlParameter = New SqlParameter("@CalleAnt", SqlDbType.NVarChar, 100)
        CalleAnt.Value = objCallesSIG._CalleAnt

        Dim Colonia As SqlParameter = New SqlParameter("@Colonia", SqlDbType.NVarChar, 100)
        Colonia.Value = objCallesSIG._Colonia

        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 50)
        Accion.Value = objCallesSIG._Accion

        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output
        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output


        '--------------------------Agrega los parámetros a un arreglo
        params.Add(oid)
        params.Add(Sector)
        params.Add(Subsector)
        params.Add(CveCalle)
        params.Add(Calle)
        params.Add(CalleAnt)
        params.Add(Colonia)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)

        '-------------------------Invoca la función para ejecutar el SP

        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_CallesSIG", params, objCallesSIG.strMensaje, tbl)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objCallesSIG.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objCallesSIG.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objCallesSIG.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objCallesSIG.strMensaje = intError & " - " & objCallesSIG.strMensaje
            End Select
            Return False
        Else
            objCallesSIG.strMensaje = "OK"
            Return True
        End If
    End Function

    Public Shared Function Consulta_ColoniasSIG(ByVal objColSIG As clsCallesSIG, ByRef tbl As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim oid As SqlParameter = New SqlParameter("@oid", SqlDbType.Int, 6)
        oid.Value = objColSIG._oid

        Dim Sector As SqlParameter = New SqlParameter("@Sector", SqlDbType.Int, 6)
        Sector.Value = objColSIG._Sector

        Dim Subsector As SqlParameter = New SqlParameter("@Subsector", SqlDbType.Int, 6)
        Subsector.Value = objColSIG._Subsector

        Dim CveCalle As SqlParameter = New SqlParameter("@CveCalle", SqlDbType.Int, 6)
        CveCalle.Value = objColSIG._CveCalle

        Dim Calle As SqlParameter = New SqlParameter("@Calle", SqlDbType.NVarChar, 100)
        Calle.Value = objColSIG._Calle

        Dim CalleAnt As SqlParameter = New SqlParameter("@CalleAnt", SqlDbType.NVarChar, 100)
        CalleAnt.Value = objColSIG._CalleAnt

        Dim Colonia As SqlParameter = New SqlParameter("@Colonia", SqlDbType.NVarChar, 100)
        Colonia.Value = objColSIG._Colonia

        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 50)
        Accion.Value = objColSIG._Accion

        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output
        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output


        '--------------------------Agrega los parámetros a un arreglo
        params.Add(oid)
        params.Add(Sector)
        params.Add(Subsector)
        params.Add(CveCalle)
        params.Add(Calle)
        params.Add(CalleAnt)
        params.Add(Colonia)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)

        '-------------------------Invoca la función para ejecutar el SP

        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_CallesSIG", params, objColSIG.strMensaje, tbl)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objColSIG.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objColSIG.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objColSIG.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objColSIG.strMensaje = intError & " - " & objColSIG.strMensaje
            End Select
            Return False
        Else
            objColSIG.strMensaje = "OK"
            Return True
        End If
    End Function

    Public Shared Function Inserta_CalleSIG(ByVal objCallesSIG As clsCallesSIG) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim oid As SqlParameter = New SqlParameter("@oid", SqlDbType.Int, 6)
        oid.Value = objCallesSIG._oid

        Dim Sector As SqlParameter = New SqlParameter("@Sector", SqlDbType.Int, 6)
        Sector.Value = objCallesSIG._Sector

        Dim Subsector As SqlParameter = New SqlParameter("@Subsector", SqlDbType.Int, 6)
        Subsector.Value = objCallesSIG._Subsector

        Dim CveCalle As SqlParameter = New SqlParameter("@CveCalle", SqlDbType.Int, 6)
        CveCalle.Value = objCallesSIG._CveCalle

        Dim Calle As SqlParameter = New SqlParameter("@Calle", SqlDbType.NVarChar, 100)
        Calle.Value = objCallesSIG._Calle

        Dim CalleAnt As SqlParameter = New SqlParameter("@CalleAnt", SqlDbType.NVarChar, 100)
        CalleAnt.Value = objCallesSIG._CalleAnt

        Dim Colonia As SqlParameter = New SqlParameter("@Colonia", SqlDbType.NVarChar, 100)
        Colonia.Value = objCallesSIG._Colonia

        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.NVarChar, 50)
        Accion.Value = objCallesSIG._Accion

        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output
        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output


        '--------------------------Agrega los parámetros a un arreglo
        params.Add(oid)
        params.Add(Sector)
        params.Add(Subsector)
        params.Add(CveCalle)
        params.Add(Calle)
        params.Add(CalleAnt)
        params.Add(Colonia)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)

        '-------------------------Invoca la función para ejecutar el SP

        Dim intError As Integer = conn.EjecutarOperacionPrueba("SP_CallColSIG", params, objCallesSIG.strMensaje)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objCallesSIG.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objCallesSIG.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objCallesSIG.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objCallesSIG.strMensaje = intError & " - " & objCallesSIG.strMensaje
            End Select
            Return False
        Else
            objCallesSIG.strMensaje = "OK"
            Return True
        End If
    End Function



#End Region
End Class
