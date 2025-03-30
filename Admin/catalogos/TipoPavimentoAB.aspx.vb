Imports System.Data.SqlClient
Imports System.Data

Partial Class Admin_catalogos_TipoPavimentoAB
    Inherits System.Web.UI.Page
    
    Public objUsuarioEN As New clsUsuarios
    Public objTipoPavimento As New clsTipoPavimento
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
            objTipoPavimento.TipoPavId = vId
            objTipoPavimento.Accion = "Buscar"
            
            Dim dt As DataTable
            dt = clsTipoPavimento.Consulta_TipoPav(objTipoPavimento)
            
            Me.txtTipoPavimento.Text = dt.Rows(0).Item(1)
            Me.txtTipoPavRom.Text = dt.Rows(0).Item(2)
            'txtEmpleado.DataBind()
            
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
        objTipoPavimento.Accion = "Todos"
        dt = clsTipoPavimento.Consulta_TipoPav(objTipoPavimento)
        
        Try
        objTipoPavimento.TipoPav = Me.txtTipoPavimento.Text
        objTipoPavimento.TipoPavRom = Me.txtTipoPavRom.Text
        objTipoPavimento.Eliminar = "NULL"
        
        Dim dtu As DataTable
        objUsuarioEN.Accion = "Consulta"
        Dim u As Integer = Session("USUARIO")
        objUsuarioEN.IdUsuario = u
        dtu = clsUsuarios.Consulta_Usuarios(objUsuarioEN)
        
        If vId <> 0 Then
            objTipoPavimento.TipoPavId = vId
            'objEstatus.Estatus = dt.Rows(0).Item(1)
            objTipoPavimento.UsuMod = dtu.Rows(0).Item(2)
            objTipoPavimento.Accion = "Actualizar"
        Else
            'objTipoPavimento.TipoPavId = 0
            objTipoPavimento.UsuCre = dtu.Rows(0).Item(2)
            objTipoPavimento.Accion = "Insertar"
        End If
        
        ban = clsTipoPavimento.Insertar(objTipoPavimento)
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