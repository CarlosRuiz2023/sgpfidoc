Imports System.Data
Imports System.Data.SqlClient
Partial Class Admin_catalogos_UsuariosAB
    Inherits System.Web.UI.Page

    Public objUsuarioEN As New clsUsuarios
    Public funcion As New funciones

    Dim strMensajeError As Object

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Not IsNothing(Session("USUARIO")) Then

            Else
                Session.Abandon()
                Response.Redirect("~/Default.aspx")

            End If

            CargarDatos()
        End If

        txtEmpleado.Attributes.Add("onkeypress", "return validar(event)")
        'txtNombre.Attributes.Add("onkeypress", "return ValidTextNombre(event)")
        'txtArea.Attributes.Add("onkeypress", "return validartexto(event)")
        'txtCurp.Attributes.Add("onkeypress", "return validartexto(event)")
        'txtRFC.Attributes.Add("onkeypress", "return validartexto(event)")
        'txtSS.Attributes.Add("onkeypress", "return validartexto(event)")
        'txtUsuario.Attributes.Add("onkeypress", "return validartexto(event)")
        'CargarDatos()
    End Sub

    Private Sub CargarDatos()
        Dim vId As Integer = funcion.LeerRequest("id", Request)
        'Me.txtEmpleado.Text = vId

        If vId <> 0 Then
            objUsuarioEN.IdUsuario = vId

            Dim dt As DataTable
            dt = clsUsuarios.Consulta_Usuarios(objUsuarioEN)

            Me.txtEmpleado.Enabled = False
            Me.txtEmpleado.Text = dt.Rows(0).Item(0)

            Me.txtNombre.Text = dt.Rows(0).Item(2).ToString.Trim
            Me.txtArea.Text = dt.Rows(0).Item(3).ToString.Trim
            Me.txtCorreo.Text = dt.Rows(0).Item(4).ToString.Trim

            If IsDBNull(dt.Rows(0).Item(5)) Then
                Me.txtCurp.Text = ""
            Else
                Me.txtCurp.Text = dt.Rows(0).Item(5).ToString.Trim
            End If

            If IsDBNull(dt.Rows(0).Item(6)) Then
                Me.txtRFC.Text = ""
            Else
                Me.txtRFC.Text = dt.Rows(0).Item(6).ToString.Trim
            End If

            If IsDBNull(dt.Rows(0).Item(7)) Then
                Me.txtSS.Text = ""
            Else
                Me.txtSS.Text = dt.Rows(0).Item(7).ToString.Trim
            End If

            'Me.txtUsuario.Enabled = False
            Me.txtUsuario.Text = dt.Rows(0).Item(8).ToString.Trim
            Me.cmbRol.SelectedValue = dt.Rows(0).Item(9)

            'Me.lblcontra.Visible = False
            'Me.txtPass.Visible = False
            'Me.txtPass2.Visible = False
            Me.RequiredFieldValidator5.Visible = False
            'txtEmpleado.DataBind()
            If Not IsDBNull(dt.Rows(0).Item("cActivo")) Then
                cmbEstatus.SelectedValue = dt.Rows(0).Item("cActivo")
            End If

            Me.lblCapturo.Text = dt.Rows(0).Item("UsrCre")
            Me.lblFecCap.Text = dt.Rows(0).Item("FecCre")
            Me.lblModifico.Text = dt.Rows(0).Item("UsrMod")
            Me.lblFecMod.Text = dt.Rows(0).Item("FecMod")
        End If

        cmbRol.DataSource = clsUsuarios.Consulta_Rol(objUsuarioEN)
        cmbRol.DataValueField = "cRolId"
        cmbRol.DataTextField = "cRolNombre"
        cmbRol.DataBind()

        cmbEstatus.DataSource = clsUsuarios.Consulta_EU(objUsuarioEN)
        cmbEstatus.DataValueField = "cEstId"
        cmbEstatus.DataTextField = "cEstDesc"
        cmbEstatus.DataBind()
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim ban As Integer = 0
        Dim vId As Integer = funcion.LeerRequest("id", Request)
        Dim dt As DataTable
        objUsuarioEN.IdUsuario = vId
        dt = clsUsuarios.Consulta_Usuarios(objUsuarioEN)

        Try
        objUsuarioEN.Empleado = Me.txtEmpleado.Text
        objUsuarioEN.Nombre = Me.txtNombre.Text.Trim
        objUsuarioEN.Area = Me.txtArea.Text.Trim
        objUsuarioEN.Correo = Me.txtCorreo.Text.Trim
        objUsuarioEN.Curp = Me.txtCurp.Text.Trim
        objUsuarioEN.Rfc = Me.txtRFC.Text.Trim
        objUsuarioEN.Ss = Me.txtSS.Text.Trim
        objUsuarioEN.Usuario = Me.txtUsuario.Text.Trim

        objUsuarioEN.IdRol = Me.cmbRol.SelectedValue
        objUsuarioEN.Activo = Me.cmbEstatus.SelectedValue

        Dim dtu As DataTable
        objUsuarioEN.Accion = "Consulta"
        Dim u As Integer = Session("USUARIO")
        objUsuarioEN.IdUsuario = u
        dtu = clsUsuarios.Consulta_Usuarios(objUsuarioEN)

        If vId <> 0 Then
            objUsuarioEN.UsuMod = dtu.Rows(0).Item(2)
            objUsuarioEN.IdUsuario = vId

            If txtPass.Text = "" Then
                objUsuarioEN.Pass = dt.Rows(0).Item("mUsuPass")
            Else
                objUsuarioEN.Pass = funcion.Encriptar(txtPass.Text.Trim)
            End If

            objUsuarioEN.Accion = "Actualizar"
        Else
            objUsuarioEN.IdUsuario = 0
            objUsuarioEN.UsuCre = dtu.Rows(0).Item(2)
            objUsuarioEN.Pass = funcion.Encriptar(txtPass.Text.Trim)
            objUsuarioEN.Accion = "Insertar"
        End If

        ban = clsUsuarios.Insertar(objUsuarioEN)
        If ban >= 0 Then
            'Limpiar()
            'lblComentario.Text = "Registro Ingresado"
            'objAlumnoEN.Nombre = ""
            'dgvClientes.DataSource = AlumnoENTIDAD.Buscar(objAlumnoEN)
            'Response.Redirect("~/catalogos/Usuarios.aspx")
            Dim script As String = "<script type='text/javascript'>" & _
                " window.opener.location.reload(true); window.close();" & _
                "</script>"

            'ScriptManager.RegisterStartupScript(Me, GetType(Page), "alerta", script, False)
            Page.ClientScript.RegisterStartupScript(GetType(Page), "script", script, False)

        Else
            MsgBox(strMensajeError)
            strMensajeError = ""
        End If

        Catch ex1 As SqlException
        lblerror.Text = "Ha ocurrido un error.  Datos no guardados  " & ex1.Message
        Catch ex2 As Exception
        lblerror.Text = "Ha ocurrido un error.  Datos no guardados  " & ex2.Message
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