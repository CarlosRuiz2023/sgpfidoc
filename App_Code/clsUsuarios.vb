Imports System.Data
Imports System.Data.SqlClient
Imports Npgsql

Public Class clsUsuarios
#Region "variables privadas"
    Private _IdUsuario As Integer = 0
    Private _Usuario As String = String.Empty
    Private _Pass As String = String.Empty
    Private _Empleado As Integer = 0
    Private _Nombre As String = String.Empty
    Private _idarea As Integer = 0
    Private _Area As String = String.Empty
    Private _Correo As String = String.Empty
    Private _Curp As String = String.Empty
    Private _Rfc As String = String.Empty
    Private _Ss As String = String.Empty
    Private _IdRol As Integer = 0
    Private _accion As Integer = 0
    Private _RolTxt As String = String.Empty
    Private _RolDesc As String = String.Empty
    Private _IdFun As Integer = 0
    Private _FunTxt As String = String.Empty
    Private _FunDesc As String = String.Empty
    Private _IdMod As Integer = 0
    Private _ModTxt As String = String.Empty
    Private _ModDesc As String = String.Empty
    Private _cConsultar As Integer = 0
    Private _cAlta As Integer = 0
    Private _cBaja As Integer = 0
    Private _cMod As Integer = 0
    Private _cAdmon As Integer = 0
    Private _AccionP As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _Idest As Integer = 0
    Private _Activo As Integer = 0
    Private _FecUltCon As DateTime
    Private _UsuEstatus As Integer = 0
    'Private _NoError As Integer = 0
    'Private _DescError As String = String.Empty
    Private _strMensaje As String = String.Empty
    Private _strMensajeDefault As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdUsuario() As Integer
        Get
            Return _IdUsuario
        End Get
        Set(ByVal Value As Integer)
            _IdUsuario = Value
        End Set
    End Property
    Public Property Usuario() As String
        Get
            Return _Usuario
        End Get
        Set(ByVal Value As String)
            _Usuario = Value
        End Set
    End Property
    Public Property Pass() As String
        Get
            Return _Pass
        End Get
        Set(ByVal Value As String)
            _Pass = Value
        End Set
    End Property
    Public Property Empleado() As Integer
        Get
            Return _Empleado
        End Get
        Set(ByVal Value As Integer)
            _Empleado = Value
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
    Public Property Area() As String
        Get
            Return _Area
        End Get
        Set(ByVal Value As String)
            _Area = Value
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
    Public Property Curp() As String
        Get
            Return _Curp
        End Get
        Set(ByVal Value As String)
            _Curp = Value
        End Set
    End Property
    Public Property Rfc() As String
        Get
            Return _Rfc
        End Get
        Set(ByVal Value As String)
            _Rfc = Value
        End Set
    End Property
    Public Property Ss() As String
        Get
            Return _Ss
        End Get
        Set(ByVal Value As String)
            _Ss = Value
        End Set
    End Property
    Public Property IdRol() As Integer
        Get
            Return _IdRol
        End Get
        Set(ByVal Value As Integer)
            _IdRol = Value
        End Set
    End Property
    Public Property idarea() As Integer
        Get
            Return _idarea
        End Get
        Set(ByVal Value As Integer)
            _idarea = Value
        End Set
    End Property
    Public Property UsuEstatus() As Integer
        Get
            Return _UsuEstatus
        End Get
        Set(ByVal Value As Integer)
            _UsuEstatus = Value
        End Set
    End Property
    Public Property accion() As Integer
        Get
            Return _accion
        End Get
        Set(ByVal Value As Integer)
            _accion = Value
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

    'Roles
    Public Property RolTxt() As String
        Get
            Return _RolTxt
        End Get
        Set(ByVal Value As String)
            _RolTxt = Value
        End Set
    End Property
    Public Property RolDesc() As String
        Get
            Return _RolDesc
        End Get
        Set(ByVal Value As String)
            _RolDesc = Value
        End Set
    End Property

    'Funciones
    Public Property IdFun() As Integer
        Get
            Return _IdFun
        End Get
        Set(ByVal Value As Integer)
            _IdFun = Value
        End Set
    End Property
    Public Property FunTxt() As String
        Get
            Return _FunTxt
        End Get
        Set(ByVal Value As String)
            _FunTxt = Value
        End Set
    End Property
    Public Property FunDesc() As String
        Get
            Return _FunDesc
        End Get
        Set(ByVal Value As String)
            _FunDesc = Value
        End Set
    End Property
    Public Property FecUltCon() As DateTime
        Get
            Return _FecUltCon
        End Get
        Set(ByVal Value As DateTime)
            _FecUltCon = Value
        End Set
    End Property
    'Modulos
    Public Property IdMod() As Integer
        Get
            Return _IdMod
        End Get
        Set(ByVal Value As Integer)
            _IdMod = Value
        End Set
    End Property
    Public Property ModTxt() As String
        Get
            Return _ModTxt
        End Get
        Set(ByVal Value As String)
            _ModTxt = Value
        End Set
    End Property
    Public Property ModDesc() As String
        Get
            Return _ModDesc
        End Get
        Set(ByVal Value As String)
            _ModDesc = Value
        End Set
    End Property

    'Checkbox
    Public Property cConsultar() As Integer
        Get
            Return _cConsultar
        End Get
        Set(ByVal Value As Integer)
            _cConsultar = Value
        End Set
    End Property

    Public Property cAlta() As Integer
        Get
            Return _cAlta
        End Get
        Set(ByVal Value As Integer)
            _cAlta = Value
        End Set
    End Property

    Public Property cBaja() As Integer
        Get
            Return _cBaja
        End Get
        Set(ByVal Value As Integer)
            _cBaja = Value
        End Set
    End Property

    Public Property cMod() As Integer
        Get
            Return _cMod
        End Get
        Set(ByVal Value As Integer)
            _cMod = Value
        End Set
    End Property

    Public Property cAdmon() As Integer
        Get
            Return _cAdmon
        End Get
        Set(ByVal Value As Integer)
            _cAdmon = Value
        End Set
    End Property

    Public Property AccionP() As String
        Get
            Return _AccionP
        End Get
        Set(ByVal Value As String)
            _AccionP = Value
        End Set
    End Property

    Public Property Idest() As Integer
        Get
            Return _Idest
        End Get
        Set(ByVal Value As Integer)
            _Idest = Value
        End Set
    End Property

    Public Property Activo() As Integer
        Get
            Return _Activo
        End Get
        Set(ByVal Value As Integer)
            _Activo = Value
        End Set
    End Property

    Public Property Mensaje() As String
        Get
            Return _strMensaje
        End Get
        Set(ByVal Value As String)
            _strMensaje = Value
        End Set
    End Property

    Public Property MensajeDefault() As String
        Get
            Return _strMensajeDefault
        End Get
        Set(ByVal Value As String)
            _strMensajeDefault = Value
        End Set
    End Property

#End Region
#Region "Metodos"

    Public Shared Function ValidarUser(ByVal objUsuario As clsUsuarios) As Integer
        Dim params = New List(Of NpgsqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim Usuario As NpgsqlParameter = New NpgsqlParameter("@username", NpgsqlTypes.NpgsqlDbType.Varchar, 20)
        Usuario.Value = objUsuario._Usuario


        Dim Pass As NpgsqlParameter = New NpgsqlParameter("@pass", NpgsqlTypes.NpgsqlDbType.Varchar, 80)
        Pass.Value = objUsuario._Pass

        '--------------------------Agrega los parámetros a un arreglo

        params.Add(Usuario)
        params.Add(Pass)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacionPgsql("public2.sp_valida_usuario", params, objUsuario.MensajeDefault)

    End Function

    Public Function GetPermisos(ByVal pIDUSUARIO As Integer, ByVal pIDMENU As String) As Data.DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdUsuario As SqlParameter = New SqlParameter("@idusuario", Data.SqlDbType.Int, 6)
        IdUsuario.Value = pIDUSUARIO

        Dim IdMenu As SqlParameter = New SqlParameter("@idmenu", Data.SqlDbType.Int, 6)
        IdMenu.Value = pIDMENU

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdUsuario)
        params.Add(IdMenu)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_ConsultaPermisos", params)
    End Function

    Public Shared Function Consulta_Rol(ByVal objUsuario As clsUsuarios) As Data.DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdRol As SqlParameter = New SqlParameter("@idrol", Data.SqlDbType.Int, 6)
        IdRol.Value = objUsuario._IdRol

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdRol)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_ConsultaRol", params)
    End Function

    Public Shared Function Consulta_Usuarios(ByVal objUsuario As clsUsuarios) As Data.DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdUsuario As SqlParameter = New SqlParameter("@iduser", Data.SqlDbType.Int, 6)
        IdUsuario.Value = objUsuario._IdUsuario

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdUsuario)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_ConsultaUsuarios", params)
    End Function

    Public Shared Function Consulta_UsuariosPsql(ByVal objUsuario As clsUsuarios) As Data.DataTable
        Dim params = New List(Of NpgsqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdUsuario As NpgsqlParameter = New NpgsqlParameter("@iduser", NpgsqlTypes.NpgsqlDbType.Integer, 10)
        IdUsuario.Value = objUsuario._IdUsuario

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdUsuario)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsultaPsql("sp_consulta_usuarios", params)
    End Function

    Public Shared Function Insertar(ByVal objUsuario As clsUsuarios) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdUsuario As SqlParameter = New SqlParameter("@idusuario", Data.SqlDbType.Int, 6)
        IdUsuario.Value = objUsuario._IdUsuario
        Dim Empleado As SqlParameter = New SqlParameter("@empleado", Data.SqlDbType.Int, 6)
        Empleado.Value = objUsuario._Empleado
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", Data.SqlDbType.NVarChar, 50)
        Nombre.Value = objUsuario._Nombre
        Dim Area As SqlParameter = New SqlParameter("@area", Data.SqlDbType.NVarChar, 30)
        Area.Value = objUsuario._Area
        Dim Correo As SqlParameter = New SqlParameter("@correo", Data.SqlDbType.NVarChar, 50)
        Correo.Value = objUsuario._Correo
        Dim Usuario As SqlParameter = New SqlParameter("@usuario", Data.SqlDbType.NVarChar, 20)
        Usuario.Value = objUsuario._Usuario
        Dim Pass As SqlParameter = New SqlParameter("@pass", Data.SqlDbType.NVarChar, 50)
        Pass.Value = objUsuario._Pass
        Dim Curp As SqlParameter = New SqlParameter("@curp", Data.SqlDbType.NVarChar, 20)
        Curp.Value = objUsuario._Curp
        Dim Rfc As SqlParameter = New SqlParameter("@rfc", Data.SqlDbType.NVarChar, 15)
        Rfc.Value = objUsuario._Rfc
        Dim Ss As SqlParameter = New SqlParameter("@ss", Data.SqlDbType.NVarChar, 20)
        Ss.Value = objUsuario._Ss
        Dim IdRol As SqlParameter = New SqlParameter("@rol", Data.SqlDbType.Int, 6)
        IdRol.Value = objUsuario._IdRol
        Dim Accion As SqlParameter = New SqlParameter("@accion", Data.SqlDbType.NVarChar, 10)
        Accion.Value = objUsuario._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objUsuario._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objUsuario._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objUsuario._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objUsuario._FecMod
        Dim Activo As SqlParameter = New SqlParameter("@activo", Data.SqlDbType.Int, 6)
        Activo.Value = objUsuario._Activo

        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output


        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdUsuario)
        params.Add(Empleado)
        params.Add(Nombre)
        params.Add(Area)
        params.Add(Correo)
        params.Add(Usuario)
        params.Add(Pass)
        params.Add(Curp)
        params.Add(Rfc)
        params.Add(Ss)
        params.Add(IdRol)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Accion)
        params.Add(Activo)
        params.Add(parIdError)
        params.Add(parDesError)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Usuarios", params)
    End Function

    Public Shared Function Buscar_Usuarios(ByVal objUsuario As clsUsuarios) As Data.DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdUsuario As SqlParameter = New SqlParameter("@idusuario", Data.SqlDbType.Int, 6)
        IdUsuario.Value = objUsuario._IdUsuario
        Dim Empleado As SqlParameter = New SqlParameter("@empleado", Data.SqlDbType.Int, 6)
        Empleado.Value = objUsuario._Empleado
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", Data.SqlDbType.NVarChar, 50)
        Nombre.Value = objUsuario._Nombre
        Dim Area As SqlParameter = New SqlParameter("@area", Data.SqlDbType.NVarChar, 30)
        Area.Value = objUsuario._Area
        Dim Correo As SqlParameter = New SqlParameter("@correo", Data.SqlDbType.NVarChar, 50)
        Correo.Value = objUsuario._Correo
        Dim Usuario As SqlParameter = New SqlParameter("@usuario", Data.SqlDbType.NVarChar, 20)
        Usuario.Value = objUsuario._Usuario
        Dim Pass As SqlParameter = New SqlParameter("@pass", Data.SqlDbType.NVarChar, 50)
        Pass.Value = objUsuario._Pass
        Dim Curp As SqlParameter = New SqlParameter("@curp", Data.SqlDbType.NVarChar, 20)
        Curp.Value = objUsuario._Curp
        Dim Rfc As SqlParameter = New SqlParameter("@rfc", Data.SqlDbType.NVarChar, 15)
        Rfc.Value = objUsuario._Rfc
        Dim Ss As SqlParameter = New SqlParameter("@ss", Data.SqlDbType.NVarChar, 20)
        Ss.Value = objUsuario._Ss
        Dim IdRol As SqlParameter = New SqlParameter("@rol", Data.SqlDbType.Int, 6)
        IdRol.Value = objUsuario._IdRol
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objUsuario._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objUsuario._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objUsuario._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objUsuario._FecMod
        Dim Accion As SqlParameter = New SqlParameter("@accion", Data.SqlDbType.NVarChar, 20)
        Accion.Value = "Buscar"
        Dim Activo As SqlParameter = New SqlParameter("@activo", Data.SqlDbType.Int, 6)
        Activo.Value = objUsuario._Activo
        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdUsuario)
        params.Add(Empleado)
        params.Add(Nombre)
        params.Add(Area)
        params.Add(Correo)
        params.Add(Usuario)
        params.Add(Pass)
        params.Add(Curp)
        params.Add(Rfc)
        params.Add(Ss)
        params.Add(IdRol)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Accion)
        params.Add(Activo)
        params.Add(parIdError)
        params.Add(parDesError)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Usuarios", params)
    End Function

    Public Shared Function Consulta_Roles(ByVal objUsuario As clsUsuarios) As Data.DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdRol As SqlParameter = New SqlParameter("@idrol", Data.SqlDbType.Int, 6)
        IdRol.Value = objUsuario._IdRol

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdRol)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_ConsultaRol", params)
    End Function

    Public Shared Function InsertarRol(ByVal objUsuario As clsUsuarios) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdRol As SqlParameter = New SqlParameter("@idrol", Data.SqlDbType.Int, 6)
        IdRol.Value = objUsuario._IdRol
        Dim RolTxt As SqlParameter = New SqlParameter("@rol", Data.SqlDbType.NVarChar, 20)
        RolTxt.Value = objUsuario._RolTxt
        Dim RolDesc As SqlParameter = New SqlParameter("@descripcion", Data.SqlDbType.NVarChar, 100)
        RolDesc.Value = objUsuario._RolDesc

        Dim Accion As SqlParameter = New SqlParameter("@accion", Data.SqlDbType.NVarChar, 10)
        Accion.Value = objUsuario._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objUsuario._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objUsuario._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objUsuario._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objUsuario._FecMod
        Dim Activo As SqlParameter = New SqlParameter("@activo", Data.SqlDbType.Int, 6)
        Activo.Value = objUsuario._Activo

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdRol)
        params.Add(RolTxt)
        params.Add(RolDesc)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Activo)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Roles", params)
    End Function

    Public Shared Function Consulta_Funcion(ByVal objUsuario As clsUsuarios) As Data.DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdFun As SqlParameter = New SqlParameter("@idfun", Data.SqlDbType.Int, 6)
        IdFun.Value = objUsuario._IdFun

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdFun)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_ConsultaFun", params)
    End Function

    Public Shared Function InsertarFuncion(ByVal objUsuario As clsUsuarios) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdFun As SqlParameter = New SqlParameter("@idfun", SqlDbType.Int, 6)
        IdFun.Value = objUsuario._IdFun
        Dim FunTxt As SqlParameter = New SqlParameter("@funcion", SqlDbType.NVarChar, 20)
        FunTxt.Value = objUsuario._FunTxt
        Dim FunDesc As SqlParameter = New SqlParameter("@descripcion", SqlDbType.NVarChar, 30)
        FunDesc.Value = objUsuario._FunDesc

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objUsuario._Accion

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdFun)
        params.Add(FunTxt)
        params.Add(FunDesc)
        params.Add(Accion)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Funciones", params)
    End Function

    Public Shared Function Consulta_Modulo(ByVal objUsuario As clsUsuarios) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdMod As SqlParameter = New SqlParameter("@idmod", SqlDbType.Int, 6)
        IdMod.Value = objUsuario._IdMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_ConsultaMod", params)
    End Function

    Public Shared Function InsertarModulo(ByVal objUsuario As clsUsuarios) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdMod As SqlParameter = New SqlParameter("@idmod", SqlDbType.Int, 6)
        IdMod.Value = objUsuario._IdMod
        Dim ModTxt As SqlParameter = New SqlParameter("@modulo", SqlDbType.NVarChar, 30)
        ModTxt.Value = objUsuario._ModTxt
        Dim ModDesc As SqlParameter = New SqlParameter("@descripcion", SqlDbType.NVarChar, 50)
        ModDesc.Value = objUsuario._ModDesc

        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objUsuario._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objUsuario._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objUsuario._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objUsuario._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objUsuario._FecMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdMod)
        params.Add(ModTxt)
        params.Add(ModDesc)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Modulos", params)
    End Function

    Public Shared Function Consulta_Permiso(ByVal objUsuario As clsUsuarios) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdRol As SqlParameter = New SqlParameter("@idrol", SqlDbType.Int, 6)
        IdRol.Value = objUsuario._IdRol

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdRol)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_ConsultaPer", params)
    End Function

    Public Shared Function Llenar(ByVal objUsuario As clsUsuarios) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdRol As SqlParameter = New SqlParameter("@idrol", SqlDbType.Int, 6)
        IdRol.Value = objUsuario._IdRol

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdRol)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Llenar", params)
    End Function

    Public Shared Function Inserta_Permiso(ByVal objUsuario As clsUsuarios) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim cConsulta As SqlParameter = New SqlParameter("@cConsulta", SqlDbType.Int, 6)
        cConsulta.Value = objUsuario._cConsultar
        Dim cAlta As SqlParameter = New SqlParameter("@cAlta", SqlDbType.Int, 6)
        cAlta.Value = objUsuario._cAlta
        Dim cBaja As SqlParameter = New SqlParameter("@cBaja", SqlDbType.Int, 6)
        cBaja.Value = objUsuario._cBaja
        Dim cMod As SqlParameter = New SqlParameter("@cMod", SqlDbType.Int, 6)
        cMod.Value = objUsuario._cMod
        Dim cAdmon As SqlParameter = New SqlParameter("@cAdmon", SqlDbType.Int, 6)
        cAdmon.Value = objUsuario._cAdmon

        Dim idrol As SqlParameter = New SqlParameter("@idrol", SqlDbType.Int, 6)
        idrol.Value = objUsuario._IdRol
        Dim idmodulo As SqlParameter = New SqlParameter("@idmodulo", SqlDbType.Int, 6)
        idmodulo.Value = objUsuario._IdMod
        Dim AccionP As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        AccionP.Value = objUsuario._AccionP

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(cConsulta)
        params.Add(cAlta)
        params.Add(cBaja)
        params.Add(cMod)
        params.Add(cAdmon)
        params.Add(idrol)
        params.Add(idmodulo)
        params.Add(AccionP)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Permisos", params)
    End Function

    Public Shared Function permisos(ByVal objUsuario As clsUsuarios) As DataTable
        Dim strQuery As String = _
        "select u.mUsuIdRol, p.mModId, p.mAccCons, p.mAccAlta, p.mAccBaja,p.mAccMod, p.mAccAdmon from mUsuarios u " & _
        "inner join mPermisos p on p.mRolId = u.mUsuIdRol " & _
        "where u.mUsuId = " & objUsuario.IdUsuario
        Return conn.EjecutarConsultaO(strQuery)
    End Function

    Public Shared Function Consulta_EU(ByVal objUsuario As clsUsuarios) As Data.DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim Idest As SqlParameter = New SqlParameter("@idest", Data.SqlDbType.Int, 6)
        Idest.Value = objUsuario._Idest

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(Idest)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_ConsultaEstU", params)
    End Function

    Public Shared Function Consulta_UsuRol(ByVal objusuario As clsUsuarios, ByRef tbl As DataTable) As Boolean
        Dim params = New List(Of SqlParameter)


        Dim Accion As SqlParameter = New SqlParameter("@accion", Data.SqlDbType.NVarChar, 20)
        Accion.Value = objusuario._Accion
        Dim Activo As SqlParameter = New SqlParameter("@activo", Data.SqlDbType.Int, 6)
        Activo.Value = objusuario._Activo

        Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
        parIdError.Direction = ParameterDirection.Output
        Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
        parDesError.Direction = ParameterDirection.Output

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(Accion)
        params.Add(Activo)
        params.Add(parIdError)
        params.Add(parDesError)


        '-------------------------Invoca la función para ejecutar el SP

        Dim intError As Integer = conn.EjecutarOperacionPrueba2("SP_Usuarios", params, objusuario.Mensaje, tbl)
        If intError > 0 Then
            Select Case intError
                Case 2601
                    objusuario.Mensaje = "ERROR NO EVALUADO"
                Case 2627
                    objusuario.Mensaje = "ERROR NO EVALUADO"
                Case 2812
                    objusuario.Mensaje = "ERROR NO EVALUADO"
                Case Else
                    objusuario.Mensaje = intError & " - " & objusuario.Mensaje
            End Select
            Return False
        Else
            objusuario.Mensaje = "OK"
            Return True
        End If
    End Function

#End Region
End Class
