Imports System.Data
Imports System.Data.SqlClient

Public Class clsInvitacionAsam
#Region "variables privadas"

    Private _IdAsamblea As Integer = 0
    Private _IdSol As Integer = 0
    Private _IdInvitacion As Integer = 0
    Private _FechaEntrega As Date = Nothing
    Private _FechaImpresion As Date = Nothing
    Private _NoInvitaciones As Integer = 0

    Private _AsamFechaRealizacion As Date
    Private _AsamEstatus As String = String.Empty
    Private _AsamIdTipoAsamblea As Integer = 0
    Private _AsamHoraRealizacion As String = String.Empty
    Private _AsamUbicacion As String = String.Empty

    Private _IdPromotor As Integer = 0
    Private _DctoInvitacion As String = String.Empty
    Private _Accion As String = String.Empty
    Private _Observaciones As String = String.Empty
    Private _IdReturn As Integer = 0
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdAsamblea() As Integer
        Get
            Return _IdAsamblea
        End Get
        Set(ByVal Value As Integer)
            _IdAsamblea = Value
        End Set
    End Property

    Public Property IdInvitacion() As Integer
        Get
            Return _IdInvitacion
        End Get
        Set(ByVal Value As Integer)
            _IdInvitacion = Value
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
    Public Property AsamFechaRealizacion() As Date
        Get
            Return AsamFechaRealizacion
        End Get
        Set(ByVal Value As Date)
            _AsamFechaRealizacion = Value
        End Set
    End Property
    Public Property AsamEstatus() As String
        Get
            Return _AsamEstatus
        End Get
        Set(ByVal Value As String)
            _AsamEstatus = Value
        End Set
    End Property
    Public Property AsamUbicacion() As String
        Get
            Return _AsamUbicacion
        End Get
        Set(ByVal Value As String)
            _AsamUbicacion = Value
        End Set
    End Property
    Public Property AsamHoraRealizacion() As String
        Get
            Return _AsamHoraRealizacion
        End Get
        Set(ByVal Value As String)
            _AsamHoraRealizacion = Value
        End Set
    End Property
    Public Property AsamIdTipoAsamblea() As Integer
        Get
            Return _AsamIdTipoAsamblea
        End Get
        Set(ByVal Value As Integer)
            _AsamIdTipoAsamblea = Value
        End Set
    End Property

    Public Property FechaEntrega() As Date
        Get
            Return _FechaEntrega
        End Get
        Set(ByVal Value As Date)
            _FechaEntrega = Value
        End Set
    End Property
    Public Property FechaImpresion() As Date
        Get
            Return _FechaImpresion
        End Get
        Set(ByVal Value As Date)
            _FechaImpresion = Value
        End Set
    End Property
    Public Property NoInvitaciones() As Integer
        Get
            Return _NoInvitaciones
        End Get
        Set(ByVal Value As Integer)
            _NoInvitaciones = Value
        End Set
    End Property
    Public Property IdPromotor() As Integer
        Get
            Return _IdPromotor
        End Get
        Set(ByVal Value As Integer)
            _IdPromotor = Value
        End Set
    End Property
    Public Property DctoInvitacion() As String
        Get
            Return _DctoInvitacion
        End Get
        Set(ByVal Value As String)
            _DctoInvitacion = Value
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
    Property IdReturn() As Integer
        ' la parte Get es la que devuelve el valor de la propiedad
        Get
            Return IdReturn
        End Get
        ' la parte Set es la que se usa al asignar el nuevo valor
        Set(ByVal Value As Integer)
            _IdReturn = Value
        End Set
    End Property
#End Region

#Region "Metodos"

    Public Shared Function Consulta_InvitacionAsam(ByVal objInvitacionAsam As clsInvitacionAsam, ByRef tbl As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdAsamblea As SqlParameter = New SqlParameter("@IdAsamblea", SqlDbType.Int, 10)
        IdAsamblea.Value = objInvitacionAsam._IdAsamblea
        Dim IdSol As SqlParameter = New SqlParameter("@IdSol", SqlDbType.Int, 10)
        IdSol.Value = objInvitacionAsam._IdSol
        Dim IdInvitacion As SqlParameter = New SqlParameter("@IdInvitacion", SqlDbType.Int, 10)
        IdInvitacion.Value = objInvitacionAsam._IdInvitacion
        Dim FechaEntrega As SqlParameter = New SqlParameter("@FechaEntrega", SqlDbType.Date, 10)
        FechaEntrega.Value = objInvitacionAsam._FechaEntrega
        Dim FechaImpresion As SqlParameter = New SqlParameter("@FechaImpresion", SqlDbType.Date, 10)
        FechaImpresion.Value = objInvitacionAsam._FechaImpresion
        Dim IdPromotor As SqlParameter = New SqlParameter("@IdPromotor", SqlDbType.Int, 10)
        IdPromotor.Value = objInvitacionAsam._IdPromotor
        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.VarChar, 50)
        Accion.Value = objInvitacionAsam._Accion



        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output

        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output




        '--------------------------Agrega los parámetros a un arreglo

        params.Add(IdAsamblea)
        params.Add(IdInvitacion)
        params.Add(FechaEntrega)
        params.Add(FechaImpresion)
        params.Add(IdPromotor)
        params.Add(IdSol)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)


        '-------------------------Invoca la función para ejecutar el SP
        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_InvitacionAsam", params, objInvitacionAsam.strMensaje, tbl)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objInvitacionAsam.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objInvitacionAsam.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objInvitacionAsam.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objInvitacionAsam.strMensaje = intError & " - " & objInvitacionAsam.strMensaje
            End Select
            Return False
        Else
            objInvitacionAsam.strMensaje = "OK"

            Return True
        End If
    End Function

    Public Shared Function InsertarInvitacionAsam(ByVal objInvitacionAsam As clsInvitacionAsam) As Boolean
        Dim params = New List(Of SqlParameter)


        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdAsamblea As SqlParameter = New SqlParameter("@IdAsamblea", SqlDbType.Int, 10)
        IdAsamblea.Value = objInvitacionAsam._IdAsamblea
        Dim IdInvitacion As SqlParameter = New SqlParameter("@IdInvitacion", SqlDbType.Int, 10)
        IdInvitacion.Value = objInvitacionAsam._IdInvitacion
        Dim IdSol As SqlParameter = New SqlParameter("@IdSol", SqlDbType.Int, 10)
        IdSol.Value = objInvitacionAsam._IdSol
        Dim FechaEntrega As SqlParameter = New SqlParameter("@FechaEntrega", SqlDbType.Date, 10)
        FechaEntrega.Value = objInvitacionAsam._FechaEntrega
        Dim FechaImpresion As SqlParameter = New SqlParameter("@FechaImpresion", SqlDbType.Date, 10)
        FechaImpresion.Value = objInvitacionAsam._FechaImpresion
        Dim NoInvitaciones As SqlParameter = New SqlParameter("@NoInvitaciones", SqlDbType.Int, 10)
        NoInvitaciones.Value = objInvitacionAsam._NoInvitaciones
        Dim IdPromotor As SqlParameter = New SqlParameter("@IdPromotor", SqlDbType.Int, 10)
        IdPromotor.Value = objInvitacionAsam._IdPromotor
        Dim DctoInvitacion As SqlParameter = New SqlParameter("@DctoInvitacion", SqlDbType.VarChar, 100)
        DctoInvitacion.Value = objInvitacionAsam._DctoInvitacion
        Dim Observaciones As SqlParameter = New SqlParameter("@Observaciones", SqlDbType.VarChar, 1000)
        Observaciones.Value = objInvitacionAsam._Observaciones
        Dim AsamFechaRealizacion As SqlParameter = New SqlParameter("@AsamFechaRealizacion", SqlDbType.Date, 20)
        AsamFechaRealizacion.Value = objInvitacionAsam._AsamFechaRealizacion
        Dim AsamEstatus As SqlParameter = New SqlParameter("@AsamEstatus", SqlDbType.NVarChar, 30)
        AsamEstatus.Value = objInvitacionAsam._AsamEstatus
        Dim AsamIdTipoAsamblea As SqlParameter = New SqlParameter("@AsamIdTipoAsamblea", SqlDbType.Int, 6)
        AsamIdTipoAsamblea.Value = objInvitacionAsam._AsamIdTipoAsamblea
        Dim AsamHoraRealizacion As SqlParameter = New SqlParameter("@AsamHoraRealizacion", SqlDbType.NVarChar, 10)
        AsamHoraRealizacion.Value = objInvitacionAsam._AsamHoraRealizacion
        Dim AsamUbicacion As SqlParameter = New SqlParameter("@AsamUbicacion", SqlDbType.NVarChar, 30)
        AsamUbicacion.Value = objInvitacionAsam._AsamUbicacion
        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.VarChar, 50)
        Accion.Value = objInvitacionAsam._Accion



        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output

        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        Dim parAux1 As SqlParameter = New SqlParameter("@Aux1", SqlDbType.Int) ' .Value = 0
        parAux1.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo

        params.Add(IdAsamblea)
        params.Add(IdInvitacion)
        params.Add(FechaEntrega)
        params.Add(FechaImpresion)
        params.Add(NoInvitaciones)
        params.Add(IdPromotor)
        params.Add(DctoInvitacion)
        params.Add(Observaciones)
        params.Add(Accion)
        params.Add(IdSol)

        params.Add(AsamFechaRealizacion)
        params.Add(AsamEstatus)
        params.Add(AsamIdTipoAsamblea)
        params.Add(AsamHoraRealizacion)
        params.Add(AsamUbicacion)

        params.Add(parIdError)
        params.Add(parDesError)
        params.Add(parAux1)


        '-------------------------Invoca la función para ejecutar el SP
        Dim intError As Integer = conn.EjecutarOperacionPrueba3("SP_InvitacionAsam", params, objInvitacionAsam.strMensaje, objInvitacionAsam.IdInvitacion)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objInvitacionAsam.strMensaje = "EXISTE UNA ASAMBLEA DE COSTO CAPTURADA"
                Case 2627
                    objInvitacionAsam.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objInvitacionAsam.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objInvitacionAsam.strMensaje = intError & " - " & objInvitacionAsam.strMensaje
            End Select
            Return False
        Else
            objInvitacionAsam.strMensaje = "OK"
            Return True
        End If
    End Function

    Public Shared Function EliminarInvitacionAsam(ByVal objInvitacionAsam As clsInvitacionAsam) As Boolean
        Dim params = New List(Of SqlParameter)

        Dim IdAsamblea As SqlParameter = New SqlParameter("@IdAsamblea", SqlDbType.NVarChar, 18)
        IdAsamblea.Value = objInvitacionAsam._IdAsamblea
        Dim Accion As SqlParameter = New SqlParameter("@Accion", SqlDbType.VarChar, 50)
        Accion.Value = objInvitacionAsam._Accion

        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output

        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output


        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdAsamblea)
        params.Add(Accion)
        params.Add(parIdError)
        params.Add(parDesError)
        '-------------------------Invoca la función para ejecutar el SP
        objInvitacionAsam.Mensaje = Nothing
        Dim intError As Integer = conn.EjecutarOperacionPrueba("SP_InvitacionAsam", params, objInvitacionAsam.strMensaje)
        'Evaluamos las respuesta de SQL

        If intError > 0 Then
            Select Case intError
                Case 2601
                    objInvitacionAsam.strMensaje = "ERROR NO EVALUADO"
                Case 2627
                    objInvitacionAsam.strMensaje = "ERROR NO EVALUADO"
                Case 2812
                    objInvitacionAsam.strMensaje = "ERROR NO EVALUADO"
                Case Else
                    objInvitacionAsam.strMensaje = intError & " - " & objInvitacionAsam.strMensaje
            End Select
            Return False
        Else
            objInvitacionAsam.strMensaje = "OK"
            Return True
        End If
    End Function




#End Region
End Class
