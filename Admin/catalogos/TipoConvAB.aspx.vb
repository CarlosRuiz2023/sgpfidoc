Imports System.Data
Imports System.Data.SqlClient
Partial Class Admin_catalogos_TipoConvAB
    Inherits System.Web.UI.Page
    
    Public objUsuarioEN As New clsUsuarios
    Public objTipo As New clsTiposC
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
        'Me.txtEmpleado.Text = vId
        
        If vId <> 0 Then
            objTipo.IdTipo = vId
            objTipo.Accion = "Buscar"
            
            Dim dt As DataTable
            dt = clsTiposC.Consulta_TiposC(objTipo)
            
            Me.txtTipo.Text = dt.Rows(0).Item(1)
            'txtEmpleado.DataBind()
        End If
    End Sub
    
    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim ban As Integer = 0
        Dim vId As Integer = funcion.LeerRequest("id", Request)
        Dim dt As DataTable
        objTipo.Accion = "Todos"
        dt = clsTiposC.Consulta_TiposC(objTipo)
        
        Try
        objTipo.Nombre = Me.txtTipo.Text
        
        If vId <> 0 Then
            objTipo.IdTipo = vId
            'objEstatus.Estatus = dt.Rows(0).Item(1)
            objTipo.Accion = "Actualizar"
        Else
            objTipo.IdTipo = 0
            objTipo.Accion = "Insertar"
        End If
        
        ban = clsTiposC.Insertar(objTipo)
        If ban >= 0 Then
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