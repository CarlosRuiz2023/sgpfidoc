Imports System.Data
Imports System.Data.SqlClient

Public Class clsCooperador
#Region "variables privadas"
    Private _IdCoo As Integer = 0
    Private _IdSol As Integer = 0
    Private _IdTipObra As Integer = 0
    Private _SECFNO As Integer = 0
    Private _SSCFNO As Integer = 0
    Private _CLACNO As Integer = 0
    Private _Tramo As String = String.Empty
    Private _IdPrograma As Integer = 0
    Private _CuentaP As String = String.Empty
    Private _Nombre As String = String.Empty
    Private _Tel As String = String.Empty
    Private _NLote As String = String.Empty
    Private _Ext As String = String.Empty
    Private _Letra As String = String.Empty
    Private _CP As Integer = 0
    Private _Manzana As String = String.Empty
    Private _NInt As String = String.Empty
    Private _SECFNO2 As Integer = 0
    Private _SSCFNO2 As Integer = 0
    Private _CLACNO2 As Integer = 0
    Private _Calle As String = String.Empty
    Private _Colonia As String = String.Empty
    Private _CalleN As String = String.Empty
    Private _ColoniaN As String = String.Empty
    Private _NExt2 As String = String.Empty
    Private _NLetra2 As String = String.Empty
    Private _NInt2 As String = String.Empty
    Private _Tel2 As String = String.Empty
    Private _CP2 As Integer = 0
    Private _correo As String = String.Empty
    Private _Municipio As String = String.Empty
    Private _Estado As String = String.Empty
    Private _Pais As String = String.Empty
    Private _NFichas As String = String.Empty
    Private _Metros As String = String.Empty
    Private _Busqueda As String = String.Empty
    Private _Accion As String = String.Empty
    Private _UsuCre As String = String.Empty
    Private _FecCre As Date
    Private _UsuMod As String = String.Empty
    Private _FecMod As Date
    Private _Esquina As Integer = 0
    Private _Esquinacon As String = String.Empty
    Private _NExtV As String = String.Empty
    Private _R20 As String = String.Empty
    Private _CoopSif As String = String.Empty
    Private _Ordena As String = String.Empty
    Private _NombreI As String = String.Empty

    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property IdCoo() As Integer
        Get
            Return _IdCoo
        End Get
        Set(ByVal Value As Integer)
            _IdCoo = Value
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
    Public Property IdTipObra() As Integer
        Get
            Return _IdTipObra
        End Get
        Set(ByVal Value As Integer)
            _IdTipObra = Value
        End Set
    End Property

    Public Property SECFNO() As Integer
        Get
            Return _SECFNO
        End Get
        Set(ByVal Value As Integer)
            _SECFNO = Value
        End Set
    End Property
    Public Property SSCFNO() As Integer
        Get
            Return _SSCFNO
        End Get
        Set(ByVal Value As Integer)
            _SSCFNO = Value
        End Set
    End Property
    Public Property CLACNO() As Integer
        Get
            Return _CLACNO
        End Get
        Set(ByVal Value As Integer)
            _CLACNO = Value
        End Set
    End Property

    Public Property IdPrograma() As Integer
        Get
            Return _IdPrograma
        End Get
        Set(ByVal Value As Integer)
            _IdPrograma = Value
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
    Public Property CuentaP() As String
        Get
            Return _CuentaP
        End Get
        Set(ByVal Value As String)
            _CuentaP = Value
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
    Public Property Tel() As String
        Get
            Return _Tel
        End Get
        Set(ByVal Value As String)
            _Tel = Value
        End Set
    End Property
    Public Property NLote() As String
        Get
            Return _NLote
        End Get
        Set(ByVal Value As String)
            _NLote = Value
        End Set
    End Property

    Public Property Ext() As String
        Get
            Return _Ext
        End Get
        Set(ByVal Value As String)
            _Ext = Value
        End Set
    End Property
    Public Property Letra() As String
        Get
            Return _Letra
        End Get
        Set(ByVal Value As String)
            _Letra = Value
        End Set
    End Property
    Public Property CP() As String
        Get
            Return _CP
        End Get
        Set(ByVal Value As String)
            _CP = Value
        End Set
    End Property
    Public Property Manzana() As String
        Get
            Return _Manzana
        End Get
        Set(ByVal Value As String)
            _Manzana = Value
        End Set
    End Property
    Public Property NInt() As String
        Get
            Return _NInt
        End Get
        Set(ByVal Value As String)
            _NInt = Value
        End Set
    End Property
    Public Property SECFNO2() As Integer
        Get
            Return _SECFNO2
        End Get
        Set(ByVal Value As Integer)
            _SECFNO2 = Value
        End Set
    End Property
    Public Property SSCFNO2() As Integer
        Get
            Return _SSCFNO2
        End Get
        Set(ByVal Value As Integer)
            _SSCFNO2 = Value
        End Set
    End Property
    Public Property CLACNO2() As Integer
        Get
            Return _CLACNO2
        End Get
        Set(ByVal Value As Integer)
            _CLACNO2 = Value
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
    Public Property Colonia() As String
        Get
            Return _Colonia
        End Get
        Set(ByVal Value As String)
            _Colonia = Value
        End Set
    End Property
    Public Property CalleN() As String
        Get
            Return _CalleN
        End Get
        Set(ByVal Value As String)
            _CalleN = Value
        End Set
    End Property
    Public Property ColoniaN() As String
        Get
            Return _ColoniaN
        End Get
        Set(ByVal Value As String)
            _ColoniaN = Value
        End Set
    End Property
    Public Property NExt2() As String
        Get
            Return _NExt2
        End Get
        Set(ByVal Value As String)
            _NExt2 = Value
        End Set
    End Property
    Public Property NLetra2() As String
        Get
            Return _NLetra2
        End Get
        Set(ByVal Value As String)
            _NLetra2 = Value
        End Set
    End Property
    Public Property NInt2() As String
        Get
            Return _NInt2
        End Get
        Set(ByVal Value As String)
            _NInt2 = Value
        End Set
    End Property
    Public Property Tel2() As String
        Get
            Return _Tel2
        End Get
        Set(ByVal Value As String)
            _Tel2 = Value
        End Set
    End Property
    Public Property CP2() As String
        Get
            Return _CP2
        End Get
        Set(ByVal Value As String)
            _CP2 = Value
        End Set
    End Property
    Public Property correo() As String
        Get
            Return _correo
        End Get
        Set(ByVal Value As String)
            _correo = Value
        End Set
    End Property
    Public Property Municipio() As String
        Get
            Return _Municipio
        End Get
        Set(ByVal Value As String)
            _Municipio = Value
        End Set
    End Property
    Public Property Estado() As String
        Get
            Return _Estado
        End Get
        Set(ByVal Value As String)
            _Estado = Value
        End Set
    End Property
    Public Property Pais() As String
        Get
            Return _Pais
        End Get
        Set(ByVal Value As String)
            _Pais = Value
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
    Public Property NFichas() As String
        Get
            Return _NFichas
        End Get
        Set(ByVal Value As String)
            _NFichas = Value
        End Set
    End Property
    Public Property Metros() As String
        Get
            Return _Metros
        End Get
        Set(ByVal Value As String)
            _Metros = Value
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

    Public Property Esquina() As Integer
        Get
            Return _Esquina
        End Get
        Set(ByVal Value As Integer)
            _Esquina = Value
        End Set
    End Property
    Public Property Esquinacon() As String
        Get
            Return _Esquinacon
        End Get
        Set(ByVal Value As String)
            _Esquinacon = Value
        End Set
    End Property
    Public Property NExtV() As String
        Get
            Return _NExtV
        End Get
        Set(ByVal Value As String)
            _NExtV = Value
        End Set
    End Property

    Public Property R20() As String
        Get
            Return _R20
        End Get
        Set(ByVal Value As String)
            _R20 = Value
        End Set
    End Property

    Public Property CoopSif() As String
        Get
            Return _CoopSif
        End Get
        Set(ByVal Value As String)
            _CoopSif = Value
        End Set
    End Property

    Public Property ordena() As String
        Get
            Return _Ordena
        End Get
        Set(ByVal Value As String)
            _Ordena = Value
        End Set
    End Property

    Public Property NombreI() As String
        Get
            Return _NombreI
        End Get
        Set(ByVal Value As String)
            _NombreI = Value
        End Set
    End Property

#End Region

#Region "Metodos"

    Public Shared Function Consulta(ByVal objCoo As clsCooperador) As DataTable
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdCoo As SqlParameter = New SqlParameter("@idcoo", SqlDbType.Int, 6)
        IdCoo.Value = objCoo._IdCoo
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objCoo._IdSol
        Dim IdTipObra As SqlParameter = New SqlParameter("@idtipoobra", SqlDbType.Int, 6)
        IdTipObra.Value = objCoo._IdTipObra
        Dim SECFNO As SqlParameter = New SqlParameter("@SECFNO", SqlDbType.Int, 6)
        SECFNO.Value = objCoo._SECFNO
        Dim SSCFNO As SqlParameter = New SqlParameter("@SSCFNO", SqlDbType.Int, 6)
        SSCFNO.Value = objCoo._SSCFNO
        Dim CLACNO As SqlParameter = New SqlParameter("@CLACNO", SqlDbType.Int, 6)
        CLACNO.Value = objCoo._CLACNO
        Dim Tramo As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 100)
        Tramo.Value = objCoo._Tramo
        Dim IdPrograma As SqlParameter = New SqlParameter("@idprograma", SqlDbType.Int, 6)
        IdPrograma.Value = objCoo._IdPrograma
        Dim CuentaP As SqlParameter = New SqlParameter("@cuentap", SqlDbType.NVarChar, 25)
        CuentaP.Value = objCoo._CuentaP
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 150)
        Nombre.Value = objCoo._Nombre
        Dim Tel As SqlParameter = New SqlParameter("@tel", SqlDbType.NVarChar, 50)
        Tel.Value = objCoo._Tel
        Dim NLote As SqlParameter = New SqlParameter("@nlote", SqlDbType.NVarChar, 10)
        NLote.Value = objCoo._NLote
        Dim Ext As SqlParameter = New SqlParameter("@next", SqlDbType.NVarChar, 10)
        Ext.Value = objCoo._Ext
        Dim Letra As SqlParameter = New SqlParameter("@letra", SqlDbType.NVarChar, 10)
        Letra.Value = objCoo._Letra
        Dim CP As SqlParameter = New SqlParameter("@cp", SqlDbType.Int, 6)
        CP.Value = objCoo._CP
        Dim Manzana As SqlParameter = New SqlParameter("@manzana", SqlDbType.NVarChar, 20)
        Manzana.Value = objCoo._Manzana
        Dim NInt As SqlParameter = New SqlParameter("@nint", SqlDbType.NVarChar, 10)
        NInt.Value = objCoo._NInt
        Dim SECFNO2 As SqlParameter = New SqlParameter("@SECFNO2", SqlDbType.Int, 6)
        SECFNO2.Value = objCoo._SECFNO2
        Dim SSCFNO2 As SqlParameter = New SqlParameter("@SSCFNO2", SqlDbType.Int, 6)
        SSCFNO2.Value = objCoo._SSCFNO2
        Dim CLACNO2 As SqlParameter = New SqlParameter("@CLACNO2", SqlDbType.Int, 6)
        CLACNO2.Value = objCoo._CLACNO2
        Dim CalleN As SqlParameter = New SqlParameter("@callen", SqlDbType.NVarChar, 150)
        CalleN.Value = objCoo._CalleN
        Dim ColoniaN As SqlParameter = New SqlParameter("@colonian", SqlDbType.NVarChar, 150)
        ColoniaN.Value = objCoo._ColoniaN
        Dim Calle As SqlParameter = New SqlParameter("@calle", SqlDbType.NVarChar, 50)
        Calle.Value = objCoo._Calle
        Dim Colonia As SqlParameter = New SqlParameter("@colonia", SqlDbType.NVarChar, 50)
        Colonia.Value = objCoo._Colonia
        Dim NExt2 As SqlParameter = New SqlParameter("@next2", SqlDbType.NVarChar, 10)
        NExt2.Value = objCoo._NExt2
        Dim NLetra2 As SqlParameter = New SqlParameter("@nletra2", SqlDbType.NVarChar, 10)
        NLetra2.Value = objCoo._NLetra2
        Dim NInt2 As SqlParameter = New SqlParameter("@nint2", SqlDbType.NVarChar, 10)
        NInt2.Value = objCoo._NInt2
        Dim Tel2 As SqlParameter = New SqlParameter("@tel2", SqlDbType.NVarChar, 20)
        Tel2.Value = objCoo._Tel2
        Dim CP2 As SqlParameter = New SqlParameter("@cp2", SqlDbType.Int, 6)
        CP2.Value = objCoo._CP2
        Dim correo As SqlParameter = New SqlParameter("@correo", SqlDbType.NVarChar, 50)
        correo.Value = objCoo._correo
        Dim Municipio As SqlParameter = New SqlParameter("@municipio", SqlDbType.NVarChar, 20)
        Municipio.Value = objCoo._Municipio
        Dim Estado As SqlParameter = New SqlParameter("@estado", SqlDbType.NVarChar, 20)
        Estado.Value = objCoo._Estado
        Dim Pais As SqlParameter = New SqlParameter("@pais", SqlDbType.NVarChar, 20)
        Pais.Value = objCoo._Pais
        Dim NFichas As SqlParameter = New SqlParameter("@nfichas", SqlDbType.NVarChar, 50)
        NFichas.Value = objCoo._NFichas
        Dim Metros As SqlParameter = New SqlParameter("@metros", SqlDbType.NVarChar, 20)
        Metros.Value = objCoo._Metros
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 30)
        Accion.Value = objCoo._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objCoo._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objCoo._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objCoo._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objCoo._FecMod
        Dim Esquina As SqlParameter = New SqlParameter("@esquina", SqlDbType.Int, 6)
        Esquina.Value = objCoo._Esquina
        Dim Esquinacon As SqlParameter = New SqlParameter("@esquinacon", SqlDbType.NVarChar, 100)
        Esquinacon.Value = objCoo._Esquinacon
        Dim NExtV As SqlParameter = New SqlParameter("@nextv", SqlDbType.NVarChar, 10)
        NExtV.Value = objCoo._NExtV
        Dim R20 As SqlParameter = New SqlParameter("@r20", SqlDbType.NVarChar, 20)
        R20.Value = objCoo._R20
        Dim CoopSif As SqlParameter = New SqlParameter("@coopsif", SqlDbType.NVarChar, 20)
        CoopSif.Value = objCoo._CoopSif
        Dim ordena As SqlParameter = New SqlParameter("@ordena", SqlDbType.NVarChar, 20)
        ordena.Value = objCoo._Ordena
        Dim NombreI As SqlParameter = New SqlParameter("@nombrei", SqlDbType.NVarChar, 50)
        NombreI.Value = objCoo._NombreI

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdCoo)
        params.Add(IdSol)
        params.Add(IdTipObra)
        params.Add(SECFNO)
        params.Add(SSCFNO)
        params.Add(CLACNO)
        params.Add(Tramo)
        params.Add(IdPrograma)
        params.Add(CuentaP)
        params.Add(Nombre)
        params.Add(NombreI)
        params.Add(Tel)
        params.Add(NLote)
        params.Add(Ext)
        params.Add(Letra)
        params.Add(CP)
        params.Add(Manzana)
        params.Add(NInt)
        params.Add(SECFNO2)
        params.Add(SSCFNO2)
        params.Add(CLACNO2)
        params.Add(Calle)
        params.Add(Colonia)
        params.Add(CalleN)
        params.Add(ColoniaN)
        params.Add(NExt2)
        params.Add(NLetra2)
        params.Add(NInt2)
        params.Add(Tel2)
        params.Add(CP2)
        params.Add(correo)
        params.Add(Municipio)
        params.Add(Estado)
        params.Add(Pais)
        params.Add(NFichas)
        params.Add(Metros)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Esquina)
        params.Add(Esquinacon)
        params.Add(NExtV)
        params.Add(R20)
        params.Add(CoopSif)
        params.Add(ordena)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarConsulta("SP_Cooperadores", params)
    End Function
    Public Shared Function Insertar(ByVal objCoo As clsCooperador) As Boolean
        Dim params = New List(Of SqlParameter)

        '---------------------------Crea variables de tipo SqlParameter y les asigna un valor
        Dim IdCoo As SqlParameter = New SqlParameter("@idcoo", SqlDbType.Int, 6)
        IdCoo.Value = objCoo._IdCoo
        Dim IdSol As SqlParameter = New SqlParameter("@idsol", SqlDbType.Int, 6)
        IdSol.Value = objCoo._IdSol
        Dim IdTipObra As SqlParameter = New SqlParameter("@idtipoobra", SqlDbType.Int, 6)
        IdTipObra.Value = objCoo._IdTipObra
        Dim SECFNO As SqlParameter = New SqlParameter("@SECFNO", SqlDbType.Int, 6)
        SECFNO.Value = objCoo._SECFNO
        Dim SSCFNO As SqlParameter = New SqlParameter("@SSCFNO", SqlDbType.Int, 6)
        SSCFNO.Value = objCoo._SSCFNO
        Dim CLACNO As SqlParameter = New SqlParameter("@CLACNO", SqlDbType.Int, 6)
        CLACNO.Value = objCoo._CLACNO
        Dim Tramo As SqlParameter = New SqlParameter("@tramo", SqlDbType.NVarChar, 100)
        Tramo.Value = objCoo._Tramo
        Dim IdPrograma As SqlParameter = New SqlParameter("@idprograma", SqlDbType.Int, 6)
        IdPrograma.Value = objCoo._IdPrograma
        Dim CuentaP As SqlParameter = New SqlParameter("@cuentap", SqlDbType.NVarChar, 25)
        CuentaP.Value = objCoo._CuentaP
        Dim Nombre As SqlParameter = New SqlParameter("@nombre", SqlDbType.NVarChar, 50)
        Nombre.Value = objCoo._Nombre
        Dim NombreI As SqlParameter = New SqlParameter("@nombrei", SqlDbType.NVarChar, 50)
        NombreI.Value = objCoo._NombreI
        Dim Tel As SqlParameter = New SqlParameter("@tel", SqlDbType.NVarChar, 50)
        Tel.Value = objCoo._Tel
        Dim NLote As SqlParameter = New SqlParameter("@nlote", SqlDbType.NVarChar, 10)
        NLote.Value = objCoo._NLote
        Dim Ext As SqlParameter = New SqlParameter("@next", SqlDbType.NVarChar, 10)
        Ext.Value = objCoo._Ext
        Dim Letra As SqlParameter = New SqlParameter("@letra", SqlDbType.NVarChar, 10)
        Letra.Value = objCoo._Letra
        Dim CP As SqlParameter = New SqlParameter("@cp", SqlDbType.Int, 6)
        CP.Value = objCoo._CP
        Dim Manzana As SqlParameter = New SqlParameter("@manzana", SqlDbType.NVarChar, 20)
        Manzana.Value = objCoo._Manzana
        Dim NInt As SqlParameter = New SqlParameter("@nint", SqlDbType.NVarChar, 10)
        NInt.Value = objCoo._NInt
        Dim SECFNO2 As SqlParameter = New SqlParameter("@SECFNO2", SqlDbType.Int, 6)
        SECFNO2.Value = objCoo._SECFNO2
        Dim SSCFNO2 As SqlParameter = New SqlParameter("@SSCFNO2", SqlDbType.Int, 6)
        SSCFNO2.Value = objCoo._SSCFNO2
        Dim CLACNO2 As SqlParameter = New SqlParameter("@CLACNO2", SqlDbType.Int, 6)
        CLACNO2.Value = objCoo._CLACNO2
        Dim Calle As SqlParameter = New SqlParameter("@calle", SqlDbType.NVarChar, 50)
        Calle.Value = objCoo._Calle
        Dim Colonia As SqlParameter = New SqlParameter("@colonia", SqlDbType.NVarChar, 50)
        Colonia.Value = objCoo._Colonia
        Dim CalleN As SqlParameter = New SqlParameter("@callen", SqlDbType.NVarChar, 50)
        CalleN.Value = objCoo._CalleN
        Dim ColoniaN As SqlParameter = New SqlParameter("@colonian", SqlDbType.NVarChar, 50)
        ColoniaN.Value = objCoo._ColoniaN
        Dim NExt2 As SqlParameter = New SqlParameter("@next2", SqlDbType.NVarChar, 10)
        NExt2.Value = objCoo._NExt2
        Dim NLetra2 As SqlParameter = New SqlParameter("@nletra2", SqlDbType.NVarChar, 10)
        NLetra2.Value = objCoo._NLetra2
        Dim NInt2 As SqlParameter = New SqlParameter("@nint2", SqlDbType.NVarChar, 10)
        NInt2.Value = objCoo._NInt2
        Dim Tel2 As SqlParameter = New SqlParameter("@tel2", SqlDbType.NVarChar, 20)
        Tel2.Value = objCoo._Tel2
        Dim CP2 As SqlParameter = New SqlParameter("@cp2", SqlDbType.Int, 6)
        CP2.Value = objCoo._CP2
        Dim correo As SqlParameter = New SqlParameter("@correo", SqlDbType.NVarChar, 50)
        correo.Value = objCoo._correo
        Dim Municipio As SqlParameter = New SqlParameter("@municipio", SqlDbType.NVarChar, 20)
        Municipio.Value = objCoo._Municipio
        Dim Estado As SqlParameter = New SqlParameter("@estado", SqlDbType.NVarChar, 20)
        Estado.Value = objCoo._Estado
        Dim Pais As SqlParameter = New SqlParameter("@pais", SqlDbType.NVarChar, 20)
        Pais.Value = objCoo._Pais
        Dim NFichas As SqlParameter = New SqlParameter("@nfichas", SqlDbType.NVarChar, 50)
        NFichas.Value = objCoo._NFichas
        Dim metros As SqlParameter = New SqlParameter("@metros", SqlDbType.NVarChar, 20)
        metros.Value = objCoo._Metros
        Dim Accion As SqlParameter = New SqlParameter("@accion", SqlDbType.NVarChar, 30)
        Accion.Value = objCoo._Accion
        Dim UsuCre As SqlParameter = New SqlParameter("@usucre", SqlDbType.NVarChar, 50)
        UsuCre.Value = objCoo._UsuCre
        Dim FecCre As SqlParameter = New SqlParameter("@feccre", SqlDbType.Date, 10)
        FecCre.Value = objCoo._FecCre
        Dim UsuMod As SqlParameter = New SqlParameter("@usumod", SqlDbType.NVarChar, 50)
        UsuMod.Value = objCoo._UsuMod
        Dim FecMod As SqlParameter = New SqlParameter("@fecmod", SqlDbType.Date, 10)
        FecMod.Value = objCoo._FecMod
        Dim Esquina As SqlParameter = New SqlParameter("@esquina", SqlDbType.Int, 6)
        Esquina.Value = objCoo._Esquina
        Dim Esquinacon As SqlParameter = New SqlParameter("@esquinacon", SqlDbType.NVarChar, 100)
        Esquinacon.Value = objCoo._Esquinacon
        Dim NExtV As SqlParameter = New SqlParameter("@nextv", SqlDbType.NVarChar, 10)
        NExtV.Value = objCoo._NExtV
        Dim R20 As SqlParameter = New SqlParameter("@r20", SqlDbType.NVarChar, 20)
        R20.Value = objCoo._R20
        Dim CoopSif As SqlParameter = New SqlParameter("@coopsif", SqlDbType.NVarChar, 20)
        CoopSif.Value = objCoo._CoopSif
        Dim ordena As SqlParameter = New SqlParameter("@ordena", SqlDbType.NVarChar, 20)
        ordena.Value = objCoo._Ordena

        '--------------------------Agrega los parámetros a un arreglo
        params.Add(IdCoo)
        params.Add(IdSol)
        params.Add(IdTipObra)
        params.Add(SECFNO)
        params.Add(SSCFNO)
        params.Add(CLACNO)
        params.Add(Tramo)
        params.Add(IdPrograma)
        params.Add(CuentaP)
        params.Add(Nombre)
        params.Add(NombreI)
        params.Add(Tel)
        params.Add(NLote)
        params.Add(Ext)
        params.Add(Letra)
        params.Add(CP)
        params.Add(Manzana)
        params.Add(NInt)
        params.Add(SECFNO2)
        params.Add(SSCFNO2)
        params.Add(CLACNO2)
        params.Add(Calle)
        params.Add(Colonia)
        params.Add(CalleN)
        params.Add(ColoniaN)
        params.Add(NExt2)
        params.Add(NLetra2)
        params.Add(NInt2)
        params.Add(Tel2)
        params.Add(CP2)
        params.Add(correo)
        params.Add(Municipio)
        params.Add(Estado)
        params.Add(Pais)
        params.Add(NFichas)
        params.Add(metros)
        params.Add(Accion)
        params.Add(UsuCre)
        params.Add(FecCre)
        params.Add(UsuMod)
        params.Add(FecMod)
        params.Add(Esquina)
        params.Add(Esquinacon)
        params.Add(NExtV)
        params.Add(R20)
        params.Add(CoopSif)
        params.Add(ordena)

        '-------------------------Invoca la función para ejecutar el SP
        Return conn.EjecutarOperacion("SP_Cooperadores", params)
    End Function

#End Region
End Class
