
Imports System.Data.SqlClient
Imports System.Data

Partial Class Admin_catalogos_PoligonoE
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

        If vId <> 0 Then
            objPoligono.IdPoligono = vId
            objPoligono.Accion = "Buscar2"
            clsPoligono.Consulta_Poligonos(objPoligono, dt)
            Me.lblPoligono.Text = dt.Rows(0).Item(1)

        End If

    End Sub

    Protected Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminar.Click
        Dim ban As Integer = 0
        Dim vId As Integer = funcion.LeerRequest("id", Request)
        Dim dt As DataTable = Nothing

        Try
            objPoligono.Vigencia = "VENCIDA"

            If vId <> 0 Then
                objPoligono.IdPoligono = vId
                'objEstatus.Estatus = dt.Rows(0).Item(1)
                objPoligono.Accion = "Eliminar"
            End If


            If clsPoligono.Consulta_Poligonos(objPoligono, dt) Then
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
            lblError.Text = "Ha ocurrido un error.  Dato no eliminado  " & ex1.Message
        Catch ex2 As Exception
            lblError.Text = "Ha ocurrido un error.  Dato no eliminado  " & ex2.Message
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
