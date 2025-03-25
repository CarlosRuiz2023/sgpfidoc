Imports System.Data
Imports System.Data.SqlClient

Public Class clsTipoPavimento
#Region "variables privadas"
    Private _TipoPavId As Integer = 0
    Private _TipoPav As String = String.Empty
    Private _TipoPavRom As String = String.Empty
    Private _Eliminar As String = String.Empty
    Private _Accion As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _UsuMod As String = String.Empty

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property TipoPavId() As String
        Get
            Return _TipoPavId
        End Get
        Set(ByVal Value As String)
            _TipoPavId = Value
        End Set
    End Property

    Public Property TipoPav() As String
        Get
            Return _TipoPav
        End Get
        Set(ByVal Value As String)
            _TipoPav = Value
        End Set
    End Property

    Public Property TipoPavRom() As String
        Get
            Return _TipoPavRom
        End Get
        Set(ByVal Value As String)
            _TipoPavRom = Value
        End Set
    End Property
    Public Property Eliminar() As String
        Get
            Return _Eliminar
        End Get
        Set(ByVal Value As String)
            _Eliminar = Value
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

    Public Property UsuMod() As String
        Get
            Return _UsuMod
        End Get
        Set(ByVal Value As String)
            _UsuMod = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consulta_TipoPav(ByVal objTipoPav As clsTipoPavimento) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim TipoPavId As SqlParameter = New SqlParameter("@TipoPavId", SqlDbType.Int, 6)
        TipoPavId.Value = objTipoPav._TipoPavId
        Dim TipoPav As SqlParameter = New SqlParameter("@TipoPav", SqlDbType.NVarChar, 50)
        TipoPav.Value = objTipoPav._TipoPav
        Dim TipoPavRom As SqlParameter = New SqlParameter("@TipoPavRom", SqlDbType.NVarChar, 50)
        TipoPavRom.Value = objTipoPav._TipoPavRom
        Dim Eliminar As SqlParameter = New SqlParameter("@Eliminar", SqlDbType.NVarChar, 10)
        Eliminar.Value = objTipoPav._Eliminar
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objTipoPav._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objTipoPav._UsuCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objTipoPav._UsuMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(TipoPavId)
        params.Add(TipoPav)
        params.Add(TipoPavRom)
        params.Add(Eliminar)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(UsuMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_TiposPav", params)
    End Function

    Public Shared Function Insertar(ByVal objTipoPav As clsTipoPavimento) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim TipoPavId As SqlParameter = New SqlParameter("@TipoPavId", SqlDbType.Int, 6)
        TipoPavId.Value = objTipoPav._TipoPavId
        Dim TipoPav As SqlParameter = New SqlParameter("@TipoPav", SqlDbType.NVarChar, 50)
        TipoPav.Value = objTipoPav._TipoPav
        Dim TipoPavRom As SqlParameter = New SqlParameter("@TipoPavRom", SqlDbType.NVarChar, 50)
        TipoPavRom.Value = objTipoPav._TipoPavRom
        Dim Eliminar As SqlParameter = New SqlParameter("@Eliminar", SqlDbType.NVarChar, 10)
        Eliminar.Value = objTipoPav._Eliminar
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objTipoPav._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objTipoPav._UsuCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objTipoPav._UsuMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(TipoPavId)
        params.Add(TipoPav)
        params.Add(TipoPavRom)
        params.Add(Eliminar)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(UsuMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_TiposPav", params)
    End Function

    Public Shared Function EliminarLogico(ByVal objTipoPav As clsTipoPavimento) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim TipoPavId As SqlParameter = New SqlParameter("@TipoPavId", SqlDbType.Int, 6)
        TipoPavId.Value = objTipoPav._TipoPavId
        Dim TipoPav As SqlParameter = New SqlParameter("@TipoPav", SqlDbType.NVarChar, 50)
        TipoPav.Value = objTipoPav._TipoPav
        Dim TipoPavRom As SqlParameter = New SqlParameter("@TipoPavRom", SqlDbType.NVarChar, 50)
        TipoPavRom.Value = objTipoPav._TipoPavRom
        Dim Eliminar As SqlParameter = New SqlParameter("@Eliminar", SqlDbType.NVarChar, 10)
        Eliminar.Value = objTipoPav._Eliminar
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 10)
        Accion.Value = objTipoPav._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objTipoPav._UsuCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objTipoPav._UsuMod

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(TipoPavId)
        params.Add(TipoPav)
        params.Add(TipoPavRom)
        params.Add(Eliminar)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(UsuMod)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_TiposPav", params)
    End Function




#End Region
End Class