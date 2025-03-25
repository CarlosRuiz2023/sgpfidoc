Imports System.Data

Public Class clsCalles
#Region "variables privadas"
    Private _SECCNO As Integer = 0
    Private _SSCCNO As Integer = 0
    Private _SECFNO As Integer = 0
    Private _SSCFNO As Integer = 0
    Private _CLACNO As Integer = 0
    Private _NACCNO As String = String.Empty
    Private _NOMFNO As String = String.Empty
    Private _Calle As String = String.Empty
    Private _Colonia As String = String.Empty
    Private _CLAVES As Integer = 0
    Private _listado As String = String.Empty
    Private _NANCNO As String = String.Empty
    Private _Accion As String = String.Empty
    Private strMensaje As String = String.Empty
    Shared conn As New clsConexion
#End Region

#Region "Propiedades"
    Public Property SECCNO() As Integer
        Get
            Return _SECCNO
        End Get
        Set(ByVal Value As Integer)
            _SECCNO = Value
        End Set
    End Property
    Public Property SSCCNO() As Integer
        Get
            Return _SSCCNO
        End Get
        Set(ByVal Value As Integer)
            _SSCCNO = Value
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
    Public Property SECFNO() As Integer
        Get
            Return _SECFNO
        End Get
        Set(ByVal Value As Integer)
            _SECFNO = Value
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
    Public Property NACCNO() As String
        Get
            Return _NACCNO
        End Get
        Set(ByVal Value As String)
            _NACCNO = Value
        End Set
    End Property
    Public Property NOMFNO() As String
        Get
            Return _NOMFNO
        End Get
        Set(ByVal Value As String)
            _NOMFNO = Value
        End Set
    End Property

    Public Property CLAVES() As Integer
        Get
            Return _CLAVES
        End Get
        Set(ByVal Value As Integer)
            _CLAVES = Value
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
    Public Property listado() As String
        Get
            Return _listado
        End Get
        Set(ByVal Value As String)
            _listado = Value
        End Set
    End Property

    Public Property NANCNO() As String
        Get
            Return _NANCNO
        End Get
        Set(ByVal Value As String)
            _NANCNO = Value
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


#End Region

#Region "Metodos"

    Public Shared Function Consulta(ByVal objCalles As clsCalles) As DataTable
        Dim strQuery As String = _
        "SELECT DISTINCT	A.SECFNO,A.SSCFNO,A.NOMFNO,((A.SECFNO * 1000) + A.SSCFNO) AS CLAVES,B.NACCNO,B.NANCNO,B.SECCNO,B.SSCCNO,B.CLACNO " & _
        "FROM	[192.1.1.4].LCSDESUR2.dbo.DEUPFCOL AS A " & _
        "INNER JOIN(SELECT SECCNO,SSCCNO,CLACNO,NACCNO,NANCNO,((SECCNO * 1000) + SSCCNO) AS CLAVES " & _
        "FROM	[192.1.1.4].LCSDESUR2.dbo.DEUPFCAL WHERE	SECCNO < 80 ) AS B ON B.CLAVES = ((A.SECFNO * 1000) + A.SSCFNO) " & _
        "WHERE(SECFNO < 80)"

        If objCalles._NACCNO <> "" Then strQuery = strQuery & " and NACCNO like '%" & objCalles._NACCNO & "%'"
        If objCalles._NOMFNO <> "" Then strQuery = strQuery & " and NOMFNO like '%" & objCalles._NOMFNO & "%'"
        If objCalles._NANCNO <> "" Then strQuery = strQuery & " and NANCNO like '%" & objCalles._NANCNO & "%'"
        Return conn.EjecutarConsulta2(strQuery)
    End Function

    Public Shared Function ConsultaCalles(ByVal objCalles As clsCalles) As DataTable
        Dim strQuery As String = _
        "SELECT DISTINCT A.SECFNO,A.SSCFNO,A.NOMFNO,((A.SECFNO * 1000) + A.SSCFNO) AS CLAVES,B.NACCNO,B.NANCNO,B.SECCNO,B.SSCCNO,B.CLACNO " & _
        "FROM	[192.1.1.4].LCSDESUR2.dbo.DEUPFCOL AS A " & _
        "INNER JOIN(SELECT SECCNO,SSCCNO,CLACNO,NACCNO,NANCNO,((SECCNO * 1000) + SSCCNO) AS CLAVES " & _
        "FROM	[192.1.1.4].LCSDESUR2.dbo.DEUPFCAL WHERE	SECCNO < 80 ) AS B ON B.CLAVES = ((A.SECFNO * 1000) + A.SSCFNO) " & _
        "WHERE(SECFNO < 80) and A.SECFNO = " & objCalles._SECFNO & "  and A.SSCFNO = " & objCalles._SSCFNO & " and B.CLACNO=" & objCalles._CLACNO & " "

        'If objCalles._NACCNO <> "" Then strQuery = strQuery & " and NACCNO like '%" & objCalles._NACCNO & "%'"
        'If objCalles._NOMFNO <> "" Then strQuery = strQuery & " and NOMFNO like '%" & objCalles._NOMFNO & "%'"
        Return conn.EjecutarConsulta2(strQuery)
    End Function

    Public Shared Function ConsultaCallesN(ByVal objCalles As clsCalles) As DataTable
        Dim strQuery As String = _
        "SELECT DISTINCT A.SECFNO,A.SSCFNO,A.NOMFNO,((A.SECFNO * 1000) + A.SSCFNO) AS CLAVES,B.NACCNO,B.SECCNO,B.SSCCNO,B.CLACNO " & _
        "FROM	[192.1.1.4].LCSDESUR2.dbo.DEUPFCOL AS A " & _
        "INNER JOIN(SELECT SECCNO,SSCCNO,CLACNO,NACCNO,((SECCNO * 1000) + SSCCNO) AS CLAVES " & _
        "FROM	[192.1.1.4].LCSDESUR2.dbo.DEUPFCAL WHERE	SECCNO < 80 ) AS B	ON	B.CLAVES = ((A.SECFNO * 1000) + A.SSCFNO) " & _
        "WHERE(SECFNO < 80) and cast(A.SECFNO as varchar)+'-'+ cast(A.SSCFNO as varchar)+'-'+ cast(B.CLACNO as varchar) in (" & objCalles.listado & ")"

        'A.SECFNO = " & objCalles._SECFNO & "  and A.SSCFNO = " & objCalles._SSCFNO & " and B.CLACNO=" & objCalles._CLACNO & " "
        'If objCalles._NACCNO <> "" Then strQuery = strQuery & " and NACCNO like '%" & objCalles._NACCNO & "%'"
        'If objCalles._NOMFNO <> "" Then strQuery = strQuery & " and NOMFNO like '%" & objCalles._NOMFNO & "%'"
        Return conn.EjecutarConsulta2(strQuery)
    End Function

#End Region
End Class
