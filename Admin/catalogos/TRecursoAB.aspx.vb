Imports System.Data.SqlClient
Imports System.Data
Partial Class Admin_catalogos_TRecursoAB
    Inherits System.Web.UI.Page
    
    Public objUsuarioEN As New clsUsuarios
    Public objTipoR As New clsTRecurso
    
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
            objTipoR.IdTipo = vId
            objTipoR.Accion = "Buscar"
            
            Dim dt As DataTable
            dt = clsTRecurso.Consulta(objTipoR)
            
            Me.txtTipo.Text = dt.Rows(0).Item(1)
            'txtEmpleado.DataBind()
            
            If IsDBNull(dt.Rows(0).Item("cActivo")) Then
                Me.chkactivo.Checked = False
            ElseIf dt.Rows(0).Item("cActivo") = 1 Then
                Me.chkactivo.Checked = True
            ElseIf dt.Rows(0).Item("cActivo") = 0 Then
                Me.chkactivo.Checked = False
            End If
            
            Me.lblCapturo.Text = dt.Rows(0).Item("UsrCre")
            Me.lblFecCap.Text = dt.Rows(0).Item("FecCre")
            Me.lblModifico.Text = dt.Rows(0).Item("UsrMod")
            Me.lblFecMod.Text = dt.Rows(0).Item("FecMod")
        End If
        
    End Sub
    
    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim ban As Integer = 0
        Dim vId As Integer = funcion.LeerRequest("id", Request)
        Dim dt As DataTable
        objTipoR.Accion = "Todos"
        dt = clsTRecurso.Consulta(objTipoR)
        
        Try
        objTipoR.Nombre = Me.txtTipo.Text
        
        If chkactivo.Checked = True Then
            objTipoR.Activo = 1
        Else
            objTipoR.Activo = 0
        End If
        
        Dim dtu As DataTable
        objUsuarioEN.Accion = "Consulta"
        Dim u As Integer = Session("USUARIO")
        objUsuarioEN.IdUsuario = u
        dtu = clsUsuarios.Consulta_Usuarios(objUsuarioEN)
        
        If vId <> 0 Then
            objTipoR.IdTipo = vId
            'objEstatus.Estatus = dt.Rows(0).Item(1)
            objTipoR.UsuMod = dtu.Rows(0).Item(2)
            objTipoR.Accion = "Actualizar"
        Else
            objTipoR.IdTipo = 0
            objTipoR.UsuCre = dtu.Rows(0).Item(2)
            objTipoR.Accion = "Insertar"
        End If
        
        ban = clsTRecurso.Insertar(objTipoR)
        
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