Imports System.Data
Imports System.Data.SqlClient
Public Class clsSolicitudes
#Region "variables privadas"
    Private _IdSol As Integer = 0
    Private _IdEstatus As Integer = 0
    Private _IdOrigen As Integer = 0
    Private _Fecha As Date
    Private _Fecha1 As Date
    Private _Fecha2 As Date
    Private _Nombre As String = String.Empty
    Private _Direccion As String = String.Empty
    Private _Telefono As String = String.Empty
    Private _Correo As String = String.Empty
    Private _SECFNO As Integer = 0
    Private _SSCFNO As Integer = 0
    Private _CLACNO As Integer = 0
    Private _Tramo As String = String.Empty
    Private _Distancia As Decimal = 0.0
    Private _Observaciones As String = String.Empty
    Private _listado As String = String.Empty
    Private _Busqueda As String = String.Empty
    Private _Accion As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _Atencion As String = String.Empty
    Private _TramoO As String = String.Empty
    Private _Ordena As String = String.Empty
    Private _Inicio As Integer = 0
    Private _Fin As Integer = 0
    Private _Autorizar As Integer = 0
    Private _Calle As String = String.Empty
    Private _Col As String = String.Empty
    Private _ubic As Integer = 0
    Private strMensaje As String = String.Empty
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
    Public Property IdEstatus() As Integer
        Get
            Return _IdEstatus
        End Get
        Set(ByVal Value As Integer)
            _IdEstatus = Value
        End Set
    End Property

    Public Property IdOrigen() As Integer
        Get
            Return _IdOrigen
        End Get
        Set(ByVal Value As Integer)
            _IdOrigen = Value
        End Set
    End Property

    Public Property Fecha() As Date
        Get
            Return _Fecha
        End Get
        Set(ByVal Value As Date)
            _Fecha = Value
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
    Public Property Nombre() As String
        Get
            Return _Nombre
        End Get
        Set(ByVal Value As String)
            _Nombre = Value
        End Set
    End Property
    Public Property Direccion() As String
        Get
            Return _Direccion
        End Get
        Set(ByVal Value As String)
            _Direccion = Value
        End Set
    End Property
    Public Property Telefono() As String
        Get
            Return _Telefono
        End Get
        Set(ByVal Value As String)
            _Telefono = Value
        End Set
    End Property
    Public Property Correo() As String
        Get
            Return _Correo
        End Get
        Set(ByVal Value As String)
            _Correo = Value
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
    Public Property Busqueda() As String
        Get
            Return _Busqueda
        End Get
        Set(ByVal Value As String)
            _Busqueda = Value
        End Set
    End Property
    Public Property listado() As String
        Get
            Return _listado
        End Get
        Set(ByVal Value As String)
            _listado = Value
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

    Public Property Atencion() As String
        Get
            Return _Atencion
        End Get
        Set(ByVal Value As String)
            _Atencion = Value
        End Set
    End Property

    Public Property TramoO() As String
        Get
            Return _TramoO
        End Get
        Set(ByVal Value As String)
            _TramoO = Value
        End Set
    End Property

    Public Property Ordena() As String
        Get
            Return _Ordena
        End Get
        Set(ByVal Value As String)
            _Ordena = Value
        End Set
    End Property

    Public Property Inicio() As Integer
        Get
            Return _Inicio
        End Get
        Set(ByVal Value As Integer)
            _Inicio = Value
        End Set
    End Property

    Public Property Fin() As Integer
        Get
            Return _Fin
        End Get
        Set(ByVal Value As Integer)
            _Fin = Value
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
    Public Property ubic() As Integer
        Get
            Return _ubic
        End Get
        Set(ByVal Value As Integer)
            _ubic = Value
        End Set
    End Property

    Public Property Autorizar() As Integer
        Get
            Return _Autorizar
        End Get
        Set(ByVal Value As Integer)
            _Autorizar = Value
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
    Public Shared Function Consulta(ByVal objSol As clsSolicitudes) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objSol._IdSol
        Dim IdEstatus As SqlParameter = New SqlParameter("@idestatus", SqlDbType.Int, 6)
        IdEstatus.Value = objSol._IdEstatus
        Dim IdOrigen As SqlParameter = New SqlParameter("@idorigen", SqlDbType.Int, 6)
        IdOrigen.Value = objSol._IdOrigen
        Dim Fecha As SqlParameter = New SqlParameter("@fecha", SqlDbType.Date, 10)
        Fecha.Value = objSol._Fecha
        Dim Fecha1 As SqlParameter = New SqlParameter("@fecha1", SqlDbType.Date, 10)
        Fecha1.Value = objSol._Fecha1
        Dim Fecha2 As SqlParameter = New SqlParameter("@fecha2", SqlDbType.Date, 10)
        Fecha2.Value = objSol._Fecha2
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 30)
        Nombre.Value = objSol._Nombre
        Dim Direccion As SqlParameter = New SqlParameter("@direccion", SqlDbType.NVarChar, 100)
        Direccion.Value = objSol._Direccion
        Dim Tel As SqlParameter = New SqlParameter("@tel", SqlDbType.NVarChar, 20)
        Tel.Value = objSol._Telefono
        Dim Correo As SqlParameter = New SqlParameter("@correo", SqlDbType.NVarChar, 50)
        Correo.Value = objSol._Correo
        Dim SECFNO As SqlParameter = New SqlParameter("@SECFNO", SqlDbType.Int, 6)
        SECFNO.Value = objSol._SECFNO
        Dim SSCFNO As SqlParameter = New SqlParameter("@SSCFNO", SqlDbType.Int, 6)
        SSCFNO.Value = objSol._SSCFNO
        Dim CLACNO As SqlParameter = New SqlParameter("@CLACNO", SqlDbType.Int, 6)
        CLACNO.Value = objSol._CLACNO
        Dim Tramo As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 200)
        Tramo.Value = objSol._Tramo
        Dim Distancia As SqlParameter = New SqlParameter("@distancia", SqlDbType.Decimal, 10)
        Distancia.Value = objSol._Distancia
        Dim Observa As SqlParameter = New SqlParameter("@observa", SqlDbType.NVarChar, 400)
        Observa.Value = objSol._Observaciones
        Dim listado As SqlParameter = New SqlParameter("@listado", SqlDbType.NVarChar, 255)
        listado.Value = objSol._listado
        Dim Busqueda As SqlParameter = New SqlParameter("@busqueda1", SqlDbType.NVarChar, 255)
        Busqueda.Value = objSol._Busqueda
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objSol._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objSol._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objSol._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objSol._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objSol._FecMod
        Dim Atencion As SqlParameter = New SqlParameter("@atencion", SqlDbType.NVarChar, 50)
        Atencion.Value = objSol._Atencion
        Dim TramoO As SqlParameter = New SqlParameter("@tramoo", SqlDbType.NVarChar, 250)
        TramoO.Value = objSol._TramoO
        Dim Ordena As SqlParameter = New SqlParameter("@ordena", SqlDbType.NVarChar, 50)
        Ordena.Value = objSol._Ordena
        Dim Calle As SqlParameter = New SqlParameter("@calle", SqlDbType.NVarChar, 150)
        Calle.Value = objSol._Calle
        Dim Col As SqlParameter = New SqlParameter("@col", SqlDbType.NVarChar, 150)
        Col.Value = objSol._Col

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(IdEstatus)
        params.Add(IdOrigen)
        params.Add(Fecha)
        params.Add(Fecha1)
        params.Add(Fecha2)
        params.Add(Nombre)
        params.Add(Direccion)
        params.Add(Tel)
        params.Add(Correo)
        params.Add(SECFNO)
        params.Add(SSCFNO)
        params.Add(CLACNO)
        params.Add(Tramo)
        params.Add(Distancia)
        params.Add(Observa)
        params.Add(listado)
        params.Add(Busqueda)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Atencion)
        params.Add(TramoO)
        params.Add(Ordena)
        params.Add(Calle)
        params.Add(Col)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Solicitudes", params)
    End Function

    Public Shared Function ActualizarCalles(ByVal objSol As clsSolicitudes) As Boolean

        Dim params = New List(Of SqlParameter)
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objSol._IdSol
        Dim SECFNO As SqlParameter = New SqlParameter("@SECFNO", SqlDbType.Int, 6)
        SECFNO.Value = objSol._SECFNO
        Dim SSCFNO As SqlParameter = New SqlParameter("@SSCFNO", SqlDbType.Int, 6)
        SSCFNO.Value = objSol._SSCFNO
        Dim CLACNO As SqlParameter = New SqlParameter("@CLACNO", SqlDbType.Int, 6)
        CLACNO.Value = objSol._CLACNO
        Dim Tramo As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 200)
        Tramo.Value = objSol._Tramo
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objSol._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objSol._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objSol._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objSol._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objSol._FecMod
        Dim TramoO As SqlParameter = New SqlParameter("@tramoo", SqlDbType.NVarChar, 250)
        TramoO.Value = objSol._TramoO
        Dim Calle As SqlParameter = New SqlParameter("@calle", SqlDbType.NVarChar, 150)
        Calle.Value = objSol._Calle
        Dim Col As SqlParameter = New SqlParameter("@col", SqlDbType.NVarChar, 150)
        Col.Value = objSol._Col
        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(SECFNO)
        params.Add(SSCFNO)
        params.Add(CLACNO)
        params.Add(Tramo)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(TramoO)
        params.Add(Calle)
        params.Add(Col)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)


        '    '-----------r--------------Invoca la función para ejecutar el SP
        objSol.strMensaje = Nothing
        Dim intError As Integer = conn.EjecutarOperacionPrueba3("SP_Solicitudes", params, objSol.strMensaje, objSol.IdSol)

        'Evaluamos las respuesta de SQL

        If intError > 0 Then
            Select Case intError
                Case 2601
                    objSol.strMensaje = "Ya se tiene un presupuesto guardado con el mismo programa"
                Case 2627
                    objSol.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objSol.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objSol.strMensaje = intError & " - " & objSol.strMensaje
            End Select
            Return False
        Else
            objSol.strMensaje = "OK"
            Return True
        End If
    End Function

    Public Shared Function Insertar(ByVal objSol As clsSolicitudes) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objSol._IdSol
        Dim IdEstatus As SqlParameter = New SqlParameter("@idestatus", SqlDbType.Int, 6)
        IdEstatus.Value = objSol._IdEstatus
        Dim IdOrigen As SqlParameter = New SqlParameter("@idorigen", SqlDbType.Int, 6)
        IdOrigen.Value = objSol._IdOrigen
        Dim Fecha As SqlParameter = New SqlParameter("@fecha", SqlDbType.Date, 10)
        Fecha.Value = objSol._Fecha
        Dim Fecha1 As SqlParameter = New SqlParameter("@fecha1", SqlDbType.Date, 10)
        Fecha1.Value = objSol._Fecha1
        Dim Fecha2 As SqlParameter = New SqlParameter("@fecha2", SqlDbType.Date, 10)
        Fecha2.Value = objSol._Fecha2
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 30)
        Nombre.Value = objSol._Nombre
        Dim Direccion As SqlParameter = New SqlParameter("@direccion", SqlDbType.NVarChar, 100)
        Direccion.Value = objSol._Direccion
        Dim Tel As SqlParameter = New SqlParameter("@tel", SqlDbType.NVarChar, 20)
        Tel.Value = objSol._Telefono
        Dim Correo As SqlParameter = New SqlParameter("@correo", SqlDbType.NVarChar, 50)
        Correo.Value = objSol._Correo
        Dim SECFNO As SqlParameter = New SqlParameter("@SECFNO", SqlDbType.Int, 6)
        SECFNO.Value = objSol._SECFNO
        Dim SSCFNO As SqlParameter = New SqlParameter("@SSCFNO", SqlDbType.Int, 6)
        SSCFNO.Value = objSol._SSCFNO
        Dim CLACNO As SqlParameter = New SqlParameter("@CLACNO", SqlDbType.Int, 6)
        CLACNO.Value = objSol._CLACNO
        Dim Tramo As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 200)
        Tramo.Value = objSol._Tramo
        Dim Distancia As SqlParameter = New SqlParameter("@distancia", SqlDbType.Decimal, 10)
        Distancia.Value = objSol._Distancia
        Dim Observa As SqlParameter = New SqlParameter("@observa", SqlDbType.NVarChar, 400)
        Observa.Value = objSol._Observaciones
        Dim listado As SqlParameter = New SqlParameter("@listado", SqlDbType.NVarChar, 255)
        listado.Value = objSol._listado
        Dim Busqueda As SqlParameter = New SqlParameter("@busqueda1", SqlDbType.NVarChar, 255)
        Busqueda.Value = objSol._Busqueda
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objSol._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objSol._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objSol._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objSol._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objSol._FecMod
        Dim Atencion As SqlParameter = New SqlParameter("@atencion", SqlDbType.NVarChar, 50)
        Atencion.Value = objSol._Atencion
        Dim TramoO As SqlParameter = New SqlParameter("@tramoo", SqlDbType.NVarChar, 250)
        TramoO.Value = objSol._TramoO
        Dim Ordena As SqlParameter = New SqlParameter("@ordena", SqlDbType.NVarChar, 50)
        Ordena.Value = objSol._Ordena
        Dim Calle As SqlParameter = New SqlParameter("@calle", SqlDbType.NVarChar, 150)
        Calle.Value = objSol._Calle
        Dim Col As SqlParameter = New SqlParameter("@col", SqlDbType.NVarChar, 150)
        Col.Value = objSol._Col

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(IdEstatus)
        params.Add(IdOrigen)
        params.Add(Fecha)
        params.Add(Fecha1)
        params.Add(Fecha2)
        params.Add(Nombre)
        params.Add(Direccion)
        params.Add(Tel)
        params.Add(Correo)
        params.Add(SECFNO)
        params.Add(SSCFNO)
        params.Add(CLACNO)
        params.Add(Tramo)
        params.Add(Distancia)
        params.Add(Observa)
        params.Add(listado)
        params.Add(Busqueda)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Atencion)
        params.Add(TramoO)
        params.Add(Ordena)
        params.Add(Calle)
        params.Add(Col)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_solicitudes", params)
    End Function

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="objSol"></param>
    ''' <param name="tbl"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Shared Function Consulta_Solicitudes(ByVal objSol As clsSolicitudes, ByRef tbl As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)
        Dim strMensaje As String = String.Empty
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objSol._IdSol
        Dim IdEstatus As SqlParameter = New SqlParameter("@idestatus", SqlDbType.Int, 6)
        IdEstatus.Value = objSol._IdEstatus
        Dim IdOrigen As SqlParameter = New SqlParameter("@idorigen", SqlDbType.Int, 6)
        IdOrigen.Value = objSol._IdOrigen
        Dim Fecha As SqlParameter = New SqlParameter("@fecha", SqlDbType.Date, 10)
        Fecha.Value = objSol._Fecha
        Dim Fecha1 As SqlParameter = New SqlParameter("@fecha1", SqlDbType.Date, 10)
        Fecha1.Value = objSol._Fecha1
        Dim Fecha2 As SqlParameter = New SqlParameter("@fecha2", SqlDbType.Date, 10)
        Fecha2.Value = objSol._Fecha2
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 30)
        Nombre.Value = objSol._Nombre
        Dim Direccion As SqlParameter = New SqlParameter("@direccion", SqlDbType.NVarChar, 100)
        Direccion.Value = objSol._Direccion
        Dim Tel As SqlParameter = New SqlParameter("@tel", SqlDbType.NVarChar, 20)
        Tel.Value = objSol._Telefono
        Dim Correo As SqlParameter = New SqlParameter("@correo", SqlDbType.NVarChar, 50)
        Correo.Value = objSol._Correo
        Dim SECFNO As SqlParameter = New SqlParameter("@SECFNO", SqlDbType.Int, 6)
        SECFNO.Value = objSol._SECFNO
        Dim SSCFNO As SqlParameter = New SqlParameter("@SSCFNO", SqlDbType.Int, 6)
        SSCFNO.Value = objSol._SSCFNO
        Dim CLACNO As SqlParameter = New SqlParameter("@CLACNO", SqlDbType.Int, 6)
        CLACNO.Value = objSol._CLACNO
        Dim Tramo As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 300)
        Tramo.Value = objSol._Tramo
        Dim Distancia As SqlParameter = New SqlParameter("@distancia", SqlDbType.Decimal, 10)
        Distancia.Value = objSol._Distancia
        Dim Observa As SqlParameter = New SqlParameter("@observa", SqlDbType.NVarChar, 400)
        Observa.Value = objSol._Observaciones
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 15)
        Accion.Value = objSol._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objSol._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objSol._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objSol._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objSol._FecMod
        Dim Atencion As SqlParameter = New SqlParameter("@atencion", SqlDbType.NVarChar, 50)
        Atencion.Value = objSol._Atencion
        Dim Calle As SqlParameter = New SqlParameter("@calle", SqlDbType.NVarChar, 150)
        Calle.Value = objSol._Calle
        Dim Col As SqlParameter = New SqlParameter("@col", SqlDbType.NVarChar, 150)
        Col.Value = objSol._Col
        Dim TramoO As SqlParameter = New SqlParameter("@tramoo", SqlDbType.NVarChar, 250)
        TramoO.Value = objSol._TramoO
        Dim Autorizar As SqlParameter = New SqlParameter("@autorizar", SqlDbType.NVarChar, 250)
        Autorizar.Value = objSol._Autorizar
        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdSol)
        params.Add(IdEstatus)
        params.Add(IdOrigen)
        params.Add(Fecha)
        params.Add(Fecha1)
        params.Add(Fecha2)
        params.Add(Nombre)
        params.Add(Direccion)
        params.Add(Tel)
        params.Add(Correo)
        params.Add(SECFNO)
        params.Add(SSCFNO)
        params.Add(CLACNO)
        params.Add(Tramo)
        params.Add(Distancia)
        params.Add(Observa)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Atencion)
        params.Add(Calle)
        params.Add(Col)
        params.Add(TramoO)
        params.Add(Autorizar)
        params.Add(parIdError)
        params.Add(parDesError)

        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_Solicitudes", params, objSol.Mensaje, tbl)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objSol.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objSol.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objSol.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objSol.strMensaje = intError & " - " & objSol.strMensaje
            End Select
            Return False
        Else
            objSol.strMensaje = "OK"
            Return True
        End If
    End Function

    Public Shared Function ListadoSol(ByVal objSol As clsSolicitudes) As DataTable
        Dim strQuery As String = ""
        If objSol.listado <> "" Then
            strQuery = _
           "select mSolId, mSolNombre, mSolTramo,mSolSECFNO,mSolSSCFNO,mSolCLACNO from mSolicitudes where 1 = 1 and cEstatusSolicitud = 2" & _
            " and cast(mSolSECFNO as varchar)+'-'+ cast(mSolSSCFNO as varchar)+'-'+ cast(mSolCLACNO as varchar) in (" & objSol.listado & ")"
        End If

        If objSol.Tramo <> "" Then
            strQuery = _
           "select mSolId, mSolNombre, mSolTramo,mSolSECFNO,mSolSSCFNO,mSolCLACNO from mSolicitudes where 1 = 1 and mSolTramo like '%" & objSol.Tramo & "%' "
        End If

        Return conn.EjecutarConsulta3(strQuery)
    End Function
    Public Shared Function FechasSol(ByVal objSol As clsSolicitudes) As DataTable
        Dim strQuery As String = _
       "select mSolId, mSolNombre, mSolFecha,cEstatusSolicitud,mSolTramo from mSolicitudes where 1 = 1 and cEstatusSolicitud = 2" & _
        "and mSolFecha >= CONVERT(DATETIME, '" & objSol.Fecha1 & "', 103) and mSolFecha <= CONVERT(DATETIME, '" & objSol.Fecha2 & "', 103)"

        Return conn.EjecutarConsulta3(strQuery)
    End Function
    Public Shared Function Reactivar(ByVal objSol As clsSolicitudes) As DataTable
        Dim strQuery As String = _
        "update mSolicitudes set cEstatusSolicitud=1, mSolFecha=GETDATE(),usrmod='" & objSol.UsuMod & "',fecmod=GETDATE() where mSolId=" & objSol.IdSol
        Return conn.EjecutarConsultaO(strQuery)
    End Function
    Public Shared Function Programas(ByVal objSol As clsSolicitudes) As DataTable
        Dim strQuery As String = _
       "select distinct c.cProgId, p.cProgNombre from mSolicitudes s inner join mCooperadores c on s.mSolId = c.mSolId inner join cProgramas p on c.cProgId = p.cProgId where s.mSolId = " & objSol.IdSol & " and s.cEstatusSolicitud = 2"
        Return conn.EjecutarConsultaO(strQuery)
    End Function
    Public Shared Function PreObras(ByVal objSol As clsSolicitudes) As DataTable
        Dim strQuery As String = _
       "select distinct s.mSolId,s.mSolFecha,s.* from mSolicitudes s   order by s.msolId desc,s.mSolFecha desc"
        Return conn.EjecutarConsultaO(strQuery)
    End Function
    Public Shared Function Requerimientos(ByVal objSol As clsSolicitudes) As DataTable
        Dim strQuery As String = _
       "select * from cRequerimientos"
        Return conn.EjecutarConsultaO(strQuery)
    End Function
    Public Shared Function solicitudes(ByVal objSol As clsSolicitudes) As DataTable
        Dim strQuery As String = _
        "select s.mSolId, s.mSolSECFNO, s.mSolSSCFNO,s.mSolCLACNO,s.mSolTramo,s.mSolNombre, s.mSolFecha, s.cEstatusSolicitud, s.mSolCalle, s.mSolColonia, e.cEstDescripcion, p.mSapalEstatus, d.mDUEstatus,s.mSolTramoO from mSolicitudes s " & _
        "left join mDU d on s.mSolId = d.mSolId " & _
        "left join mSapal p on s.mSolId = p.mSolId " & _
        "left join cEstatusSolicitud e on s.cEstatusSolicitud = e.cEstId order by s.mSolFecha desc, s.mSolId desc"
        Return conn.EjecutarConsultaO(strQuery)
    End Function

    Public Shared Function Obras(ByVal objSol As clsSolicitudes) As DataTable
        Dim strQuery As String = _
       "select distinct s.mSolId,s.mSolFecha,s.* from mSolicitudes s  where cEstatusSolicitud = 2 order by s.msolId desc,s.mSolFecha desc"
        Return conn.EjecutarConsultaO(strQuery)
    End Function

    Public Shared Function ConsultaOr(ByVal objSol As clsSolicitudes) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor

        Dim Ordena As SqlParameter = New SqlParameter("@sortBy", SqlDbType.NVarChar, 50)
        Ordena.Value = objSol._Ordena
        Dim inicio As SqlParameter = New SqlParameter("@startIndex", SqlDbType.Int, 6)
        inicio.Value = objSol._Inicio
        Dim fin As SqlParameter = New SqlParameter("@pageSize", SqlDbType.Int, 6)
        fin.Value = objSol._Fin
        Dim totalregistros As SqlParameter = New SqlParameter("@totalObras", SqlDbType.Int, 6) ' .Value = Space(1000)
        totalregistros.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo

        params.Add(Ordena)
        params.Add(inicio)
        params.Add(fin)
        params.Add(totalregistros)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("spGetAllPreObras", params)
    End Function

    Public Shared Function Sol_Search(ByVal tramo As String, calle As String, col As String, ordena As String, inicio As Integer, fin As Integer) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim Tramo2 As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 200)
        Tramo2.Value = tramo
        Dim Calle2 As SqlParameter = New SqlParameter("@calle", SqlDbType.NVarChar, 150)
        Calle2.Value = calle
        Dim Col2 As SqlParameter = New SqlParameter("@col", SqlDbType.NVarChar, 150)
        Col2.Value = col
        Dim Ordena2 As SqlParameter = New SqlParameter("@sortBy", SqlDbType.NVarChar, 50)
        Ordena2.Value = ordena
        Dim inicio2 As SqlParameter = New SqlParameter("@startIndex", SqlDbType.Int, 6)
        inicio2.Value = inicio
        Dim fin2 As SqlParameter = New SqlParameter("@pageSize", SqlDbType.Int, 6)
        fin2.Value = fin

        '--------------------------Agrega los parámetros a un arreglo

        params.Add(Ordena2)
        params.Add(inicio2)
        params.Add(fin2)
        params.Add(Tramo2)
        params.Add(Calle2)
        params.Add(Col2)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("spSol_Search", params)
    End Function

    Public Shared Function Sol_Count(ByVal objSol As clsSolicitudes) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim Tramo As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 200)
        Tramo.Value = objSol._Tramo
        Dim Calle As SqlParameter = New SqlParameter("@calle", SqlDbType.NVarChar, 150)
        Calle.Value = objSol._Calle
        Dim Col As SqlParameter = New SqlParameter("@col", SqlDbType.NVarChar, 150)
        Col.Value = objSol._Col
        Dim Ordena As SqlParameter = New SqlParameter("@sortBy", SqlDbType.NVarChar, 50)
        Ordena.Value = objSol._Ordena
        Dim inicio As SqlParameter = New SqlParameter("@startIndex", SqlDbType.Int, 6)
        inicio.Value = objSol._Inicio
        Dim fin As SqlParameter = New SqlParameter("@pageSize", SqlDbType.Int, 6)
        fin.Value = objSol._Fin

        '--------------------------Agrega los parámetros a un arreglo

        params.Add(Ordena)
        params.Add(inicio)
        params.Add(fin)
        params.Add(Tramo)
        params.Add(Calle)
        params.Add(Col)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("spSol_SearchCount", params)
    End Function

#End Region
End Class
