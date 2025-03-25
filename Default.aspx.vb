
Partial Class Admin_Default
    Inherits System.Web.UI.Page


    Private objUsuarioEN As New clsUsuarios
    Public funcion As New funciones
   

    Protected Sub btnDefault_Click1(sender As Object, e As ImageClickEventArgs) Handles btnDefault.Click
        objUsuarioEN.Usuario = txtUsuario.Text
        objUsuarioEN.Pass = txtPassword.Text

        Dim result As Integer = clsUsuarios.ValidarUser(objUsuarioEN)
        lblMessage.Text = ""
        If result > 0 Then
            Session("ValidUser") = True
            Session("USUARIO") = clsUsuarios.ValidarUser(objUsuarioEN)
            Session("IDUSUARIO") = result
            Response.Redirect("~\Admin\Inicio.aspx")
        Else
            Session("ValidUser") = False
        End If
        lblMessage.Text = objUsuarioEN.MensajeDefault
        objUsuarioEN = Nothing
    End Sub
End Class
