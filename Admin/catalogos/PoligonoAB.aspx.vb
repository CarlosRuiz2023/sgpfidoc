Imports System.Data.SqlClient
Imports System.Data


Partial Class Admin_catalogos_PoligonoAB
    Inherits System.Web.UI.Page
    
    Public objUsuarioEN As New clsUsuarios
    Public objPoligono As New clsPoligono
    Public funcion As New funciones
    Dim strMensajeError As String
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
        If Not IsPostBack Then
            If Not IsNothing(Session("USUARIO")) Then
                
            Else
                Session.Abandon()
                Response.Redirect("~/Default.aspx")
                
            End If
            CargarDatos()
        End If
        'CargarDatos()
        
    End Sub
    
    Private Sub CargarDatos()
        Dim vId As Integer = funcion.LeerRequest("id", Request)
        Dim dt As DataTable = Nothing
        Dim t2 As Integer = 0
        'Me.txtEmpleado.Text = vId
        
        If vId <> 0 Then
            objPoligono.IdPoligono = vId
            objPoligono.Accion = "Buscar2"
            If clsPoligono.Consulta_Poligonos(objPoligono, dt) Then 'Si carga los registros sin problemas
                Me.txtPoligono.Text = dt.Rows(0).Item(1)
                Me.txtDescrip.Text = dt.Rows(0).Item(3)
                Me.txtOrigenGobierno.Text = dt.Rows(0).Item(2) + " "
                Me.txtNumRegistro.Text = dt.Rows(0).Item(5)
                
                Me.lblCapturo.Text = dt.Rows(0).Item("cUsrCre")
                Me.lblFecCap.Text = dt.Rows(0).Item("cFechaReg")
                Me.lblModifico.Text = dt.Rows(0).Item("cUsrModif")
                Me.lblFecMod.Text = dt.Rows(0).Item("cFechaModif")
            Else ' Si  hubo un problema al cargar los datos
                lblError.Text = objPoligono.Mensaje ' Muestra el mensaje
            End If
        End If
        
    End Sub
    
    Protected Sub btnGuardar_Click(sender As Object, e As ImageClickEventArgs) Handles btnGuardar.Click
        Dim ban As Integer = 0
        Dim vId As Integer = funcion.LeerRequest("id", Request)
        Dim dt As DataTable = Nothing
        objPoligono.Accion = "Todos"
        clsPoligono.Consulta_Poligonos(objPoligono, dt)
        
        Try
        objPoligono.Etiqueta = Me.txtPoligono.Text
        objPoligono.Descripcion = Me.txtDescrip.Text
        objPoligono.OrigenGob = Me.txtOrigenGobierno.Text
        objPoligono.NumRegistro = Me.txtNumRegistro.Text
        
        
        Dim dtu As DataTable
        objUsuarioEN.Accion = "Consulta"
        Dim u As Integer = Session("USUARIO")
        objUsuarioEN.IdUsuario = u
        dtu = clsUsuarios.Consulta_Usuarios(objUsuarioEN)
        
        If vId <> 0 Then
            objPoligono.IdPoligono = vId
            objPoligono.UsrModif = dtu.Rows(0).Item(2)
            objPoligono.Accion = "Actualizar"
        Else
            objPoligono.UsrCre = dtu.Rows(0).Item(2)
            objPoligono.Accion = "Insertar"
        End If
        
        ban = clsPoligono.Insertar(objPoligono)
        If ban Then
            'Limpiar()
            'lblComentario.Text = "Registro Ingresado"
            'objAlumnoEN.Nombre = ""
            'dgvClientes.DataSource = AlumnoENTIDAD.Buscar(objAlumnoEN)
            'Response.Redirect("~/catalogos/Usuarios.aspx")
            Dim script As String = "<script type='text/javascript'>" & _
                "window.opener.location.reload(true); window.close();" & _
                "</script>"
            
            'ScriptManager.RegisterStartupScript(Me, GetType(Page), "alerta", script, False)
            Page.ClientScript.RegisterStartupScript(GetType(Page), "script", script, False)
            
        Else
            MsgBox(strMensajeError)
            strMensajeError = ""
        End If
        
        Catch ex1 As SqlException
        lblError.Text = "Ha ocurrido un error.  Datos no guardados  " & ex1.Message
        Catch ex2 As Exception
        lblError.Text = "Ha ocurrido un error.  Datos no guardados  " & ex2.Message
        End Try
    End Sub
    
    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Dim script As String = "<script type='text/javascript'>" & _
            "window.opener.location.reload(true); window.close();" & _
            "</script>"
        'ScriptManager.RegisterStartupScript(Me, GetType(Page), "alerta", script, False)
        Page.ClientScript.RegisterStartupScript(GetType(Page), "script", script, False)
    End Sub
    
    

End Class