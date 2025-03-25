Public Class clsFactibilidad

#Region "variables privadas"
    Private _IdSol As Integer = 0   'Clave de solicitud' 
    Private _IdFact As Integer = 0 'Clave de factibilidad
    Private _NumFact As Integer = 0 'Numero de factibilidad'
    Private _opc1 As Integer = 0    'Colonia Regular'
    Private _opc2 As Integer = 0    'Servicio de Agua potable' 
    Private _opc3 As Integer = 0    'Servicio de Electricidad'
    Private _opc4 As Integer = 0    'Servicio de drenaje'
    Private _opc5 As Integer = 0    'Pavimento colindante' 
    Private _opc6 As Integer = 0    'Existe Afectación' 
    Private _opc7 As Integer = 0    'Sección menor a 13 mts'   
    Private _opc8 As Integer = 0    'Costos extras' 
    Private _opc9 As Integer = 0    'Área de donación'   
    Private _opc10 As Integer = 0   'Consolidación'
    Private _opc11 As Integer = 0   ''  
    Private _opc12 As Integer = 0   '' 
    Private _observtec As String = String.Empty          'Observaciones tecnicas que hace el investigador'
    Private _observgral As String = String.Empty         'Observaciones que incluyen los que firman' 
    Private _docdig As String = String.Empty             'Nombre del documento digital de la factibilidad deberia estar impreso'
    Private _EstatusFact As String = String.Empty        'Estatus que albergara el resultado de la factibilidad "PROCEDE","NO PROCEDE" y "PROCEDE POR INSTRUCCION"'
    Private _UsuFact As Integer = 0                      'Número de Usuario que realiza la factibilidad'
    Private _NomUsuFact As String = String.Empty         'Número de Usuario que realiza la factibilidad'
    Private _UsuCre As String = String.Empty             'Usuario que da de alta la factibilidad'
    Private _FecCre As Date                              'Fecha de creación de la factibilidad'
    Private _UsuMod As String = String.Empty             'Usuario que modifica por ultima vez la factibilidad'
    Private _FecMod As Date 'Fecha de la ultima vez que se modifica la factibilidad'
    Private _FolioDcto As String = String.Empty             'Folio del documento digitalizado'
    Private _accion As Integer = 0                       'Variable para activar las acciones que se realizan para el objeto 0---->ALTA, 1 ----> EDITAR y 2 ----> BAJA'
    'Private _SapalId As Integer = 0                      'Id que se le asigna a los archivos de SAPAL  
    'Private _FileSapalSol As String = String.Empty    'Nombre de archivo donde se hizo la solicitud a SAPAL
    'Private _FileSapalResp As String = String.Empty   'Nombre de archivo que responde SAPAL 
    'Private _DUId As Integer = 0                      'Id que se le asigna a los archivos de Desarrollo Urbano        
    'Private _FileDUSol As String = String.Empty       'Nombre de archivo donde se hizo la solicitud a Desarrollo Urbano 
    'Private _FileDUResp As String = String.Empty      'Nombre de archivo que responde DU




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
    Public Property IdFact() As Integer
        Get
            Return _IdFact
        End Get
        Set(ByVal Value As Integer)
            _IdFact = Value
        End Set
    End Property
    Public Property NumFact() As Integer
        Get
            Return _NumFact
        End Get
        Set(ByVal Value As Integer)
            _NumFact = Value
        End Set
    End Property
    Public Property opc1() As Integer
        Get
            Return _opc1
        End Get
        Set(ByVal Value As Integer)
            _opc1 = Value
        End Set
    End Property
    Public Property opc2() As Integer
        Get
            Return _opc2
        End Get
        Set(ByVal Value As Integer)
            _opc2 = Value
        End Set
    End Property
    Public Property opc3() As Integer
        Get
            Return _opc3
        End Get
        Set(ByVal Value As Integer)
            _opc3 = Value
        End Set
    End Property
    Public Property opc4() As Integer
        Get
            Return _opc4
        End Get
        Set(ByVal Value As Integer)
            _opc4 = Value
        End Set
    End Property
    Public Property opc5() As Integer
        Get
            Return _opc5
        End Get
        Set(ByVal Value As Integer)
            _opc5 = Value
        End Set
    End Property
    Public Property opc6() As Integer
        Get
            Return _opc6
        End Get
        Set(ByVal Value As Integer)
            _opc6 = Value
        End Set
    End Property
    Public Property opc7() As Integer
        Get
            Return _opc7
        End Get
        Set(ByVal Value As Integer)
            _opc7 = Value
        End Set
    End Property
    Public Property opc8() As Integer
        Get
            Return _opc8
        End Get
        Set(ByVal Value As Integer)
            _opc8 = Value
        End Set
    End Property
    Public Property opc9() As Integer
        Get
            Return _opc9
        End Get
        Set(ByVal Value As Integer)
            _opc9 = Value
        End Set
    End Property
    Public Property opc10() As Integer
        Get
            Return _opc10
        End Get
        Set(ByVal Value As Integer)
            _opc10 = Value
        End Set
    End Property
    Public Property opc11() As Integer
        Get
            Return _opc11
        End Get
        Set(ByVal Value As Integer)
            _opc11 = Value
        End Set
    End Property
    Public Property opc12() As Integer
        Get
            Return _opc12
        End Get
        Set(ByVal Value As Integer)
            _opc12 = Value
        End Set
    End Property
    Public Property observtec() As String
        Get
            Return _observtec
        End Get
        Set(ByVal Value As String)
            _observtec = Value
        End Set
    End Property
    Public Property observgral() As String
        Get
            Return _observgral
        End Get
        Set(ByVal Value As String)
            _observgral = Value
        End Set
    End Property
    Public Property docdig() As String
        Get
            Return _docdig
        End Get
        Set(ByVal Value As String)
            _docdig = Value
        End Set
    End Property

    Public Property EstatusFact() As String
        Get
            Return _EstatusFact
        End Get
        Set(ByVal Value As String)
            _EstatusFact = Value
        End Set
    End Property
    Public Property UsuFact() As Integer
        Get
            Return _UsuFact
        End Get
        Set(ByVal Value As Integer)
            _UsuFact = Value
        End Set
    End Property
    Public Property NomUsuFact() As String
        Get
            Return _NomUsuFact
        End Get
        Set(ByVal Value As String)
            _NomUsuFact = Value
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
    Public Property FolioDcto() As String
        Get
            Return _FolioDcto
        End Get
        Set(ByVal Value As String)
            _FolioDcto = Value
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
    'Public Property SapalId() As Integer
    '    Get
    '        Return _SapalId
    '    End Get
    '    Set(ByVal Value As Integer)
    '        _SapalId = Value
    '    End Set
    'End Property
    'Public Property FileSapalSol() As String
    '   Get
    '        Return _FileSapalSol
    '    End Get
    '    Set(ByVal Value As String)
    '        _FileSapalSol = Value
    '    End Set
    'End Property
    'Public Property FileSapalResp() As String
    '    Get
    '        Return _FileSapalResp
    '    End Get
    '    Set(ByVal Value As String)
    '        _FileSapalResp = Value
    '    End Set
    'End Property
    'Public Property DUId() As Integer
    '    Get
    '        Return _DUId
    '    End Get
    '    Set(ByVal Value As Integer)
    '        _DUId = Value
    '    End Set
    'End Property
    'Public Property FileDUSol() As String
    '    Get
    '        Return _FileDUSol
    '    End Get
    '    Set(ByVal Value As String)
    '        _FileDUSol = Value
    '    End Set
    'End Property
    'Public Property FileDUResp() As String
    '    Get
    '        Return _FileDUResp
    '    End Get
    '    Set(ByVal Value As String)
    '        _FileDUResp = Value
    '    End Set
    'End Property
    Public Property Accion() As Integer
        Get
            Return _accion
        End Get
        Set(ByVal Value As Integer)
            _accion = Value
        End Set
    End Property


#End Region

#Region "Metodos"

#End Region

End Class
